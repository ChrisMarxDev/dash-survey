import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'single_survey_state.dart';
part 'store_service.dart';

/// The main controller for dash survey.
/// It is responsible for fetching the next survey object and displaying it.
/// It also handles the user configuration and the survey state.
abstract interface class DashSurveyController {
  /// Get the next survey object for this user.
  /// This is useful if you want to display the survey in a different way than
  /// the default or if you want to display the survey in a different context.
  /// The logic for this function is shared with the [showNextSurvey] function.
  ///
  /// This function can also be used in combination with [DashSurveyBuilder] to
  /// fetch the survey before displaying the builder element.
  /// E.g. call getNextSurvey and if it has a value [DashSurveyBuilder] will
  /// immediately build with [SurveyState.activeSurvey] and will skip the
  /// [SurveyState.loading] state.
  Future<SurveyModel?> getNextSurvey({String? viewId});

  /// Show the next survey object for this user.
  Future<void> showNextSurvey({
    void Function(SurveyModel survey)? onComplete,
    void Function()? onCancel,
    String? viewId,
  });

  /// Set parameters for this user to target them in surveys
  /// E.g. when you want to target users by country or by user segments
  /// params is a map of key-value pairs
  /// e.g. {'country': 'US', 'age': '20'}
  ///
  /// UserParams will be merged with existing UserParams
  /// e.g. if you set {'country': 'US'} and then {'age': '20'}
  Future<void> setUserDimensions(Map<String, String> params);

  /// Clear all persisted data for this app installation.
  /// This will delete all user data and reset the survey state to the initial
  /// state.
  /// This is useful when you want to start fresh or when you want to logout the
  /// user.
  Future<void> clearUserConfiguration();
}

class DashSurveyControllerImplementation implements DashSurveyController {
  /// Create a new controller with the given API key.
  /// The API key is used to authenticate the user with the survey dash API.
  /// You can get the API key from the survey dash dashboard.
  DashSurveyControllerImplementation({
    required String apiKey,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
    this.demoMode = false,
  })  : _currentContextGetter = currentContextGetter,
        api = DashSurveyApiService(
          config.baseUrl ?? 'https://api.dash-survey.com',
          apiKey,
        ),
        _store = _DashSurveyStoreService(
          sharedPreferencesFuture: SharedPreferences.getInstance(),
        ) {
    _surveyHolderState = SurveyHolderState(
      controller: this,
    );
  }
  @visibleForTesting
  // ignore: public_member_api_docs
  DashSurveyControllerImplementation.fromRequiredServices({
    required this.api,
    required _DashSurveyStoreService storeService,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
    this.demoMode = false,
  })  : _currentContextGetter = currentContextGetter,
        _store = storeService {
    _surveyHolderState = SurveyHolderState(
      controller: this,
    );
  }

  final Locale? overrideLocale;

  final DashSurveyConfig config;

  final DashSurveyApiService api;

  final BuildContext Function() _currentContextGetter;

  final _DashSurveyStoreService _store;

  late final SurveyHolderState _surveyHolderState;

  final bool demoMode;

  String? userId;

  final Completer<void> _initCompleter = Completer<void>();
  final Completer<void> _fetchCompleter = Completer<void>();

  /// initialize the controller
  /// This will setup the user id and initialize the survey holder state
  Future<void> init() async {
    // setup this users id
    userId = await _store.getUserId();

    // await _surveyHolderState.init();

    _initCompleter.complete();
  }

  /// Set parameters for this user to target them in surveys
  /// E.g. when you want to target users by country or by user segments
  /// params is a map of key-value pairs
  /// e.g. {'country': 'US', 'age': '20'}
  ///
  /// UserParams will be merged with existing UserParams
  /// e.g. if you set {'country': 'US'} and then {'age': '20'}
  /// the final UserParams will be {'country': 'US', 'age': '20'}
  ///
  /// To delete a single dimension, set it to null
  /// e.g. {'country': null} will delete the country dimension
  ///
  /// To clear all dimensions, set an empty map or call [clearUserConfiguration]
  @override
  Future<void> setUserDimensions(Map<String, String?> params) async {
    final currentTargetDimensions = await _store.getUserTargetDimensions();
    final newTargetDimensions = {
      ...currentTargetDimensions,
    }
      ..addAll(params)
      ..removeWhere((key, value) => value == null);
    await _store.setUserTargetDimensions(newTargetDimensions);
  }

  /// Clear all persisted data for this app installation.
  /// This will delete all user data and reset the survey state to the initial
  /// state.
  /// This is useful when you want to start fresh or when you want to logout the
  /// user.
  @override
  Future<void> clearUserConfiguration() async {
    await _store.clear();
  }

  /// Your bread and butter function. Calling this will automatically fetch the
  /// next survey object for this user and display it.
  /// This functions will automatically handle targeting options and limits.
  @override
  Future<void> showNextSurvey({
    void Function(SurveyModel survey)? onComplete,
    void Function()? onCancel,
    String? viewId,
  }) async {
    final nextSurvey = await getNextSurvey(viewId: viewId);
    if (nextSurvey == null) {
      return;
    }
    await showSurveyBottomSheet(
      _currentContextGetter(),
      locale: getLocaleCode(),
      survey: nextSurvey,
    );
  }

  /// Fetch the next survey object for this user.
  /// This is useful if you want to display the survey in a different way than
  /// the default or if you want to display the survey in a different context.
  /// The logic for this function is shared with the [showNextSurvey] function.
  @override
  Future<SurveyModel?> getNextSurvey({
    String? viewId,
  }) async {
    if (_surveyHolderState.surveyState == SurveyState.activeSurvey) {
      return _surveyHolderState.survey;
    }
    await _surveyHolderState.fetch();
    return _surveyHolderState.survey;
  }

  Future<SurveyModel?> _internalGetNextSurvey({
    String? viewId,
  }) async {
    final lastSurveyDate = await _lastSurveyDate();
    print('Last survey date: $lastSurveyDate');

    final isElligleAgain = lastSurveyDate == null ||
        config.surveyCoolDownInDays == 0 ||
        lastSurveyDate.isBefore(
          DateTime.now().subtract(
            Duration(days: config.surveyCoolDownInDays),
          ),
        );

    if (!isElligleAgain) {
      return null;
    }
    final surveys = await _fetchNextSurveyObjects();
    print('Surveys: ${surveys.firstOrNull?.toJson()}');

    return surveys.lastOrNull;
  }

  Future<List<SurveyModel>> _fetchNextSurveyObjects() async {
    final targetDimensions = await _store.getUserTargetDimensions();
    final surveys = await api.getElliglbeOpenSurveys(
      userId: userId!,
      localeCode: getLocaleCode(),
      targetDimensions: targetDimensions,
    );
    return surveys;
  }

  /// Get the locale code for the current user.
  /// If the override locale is set, it will return that locale.
  /// Otherwise, it will return the locale of the current context.
  LocaleCode getLocaleCode({BuildContext? context}) {
    final locale = overrideLocale ??
        Localizations.localeOf(context ?? _currentContextGetter());
    final result = LocaleCode(locale.languageCode);
    return result;
  }

  Future<DateTime?> _lastSurveyDate() async {
    final completedSurveys = await _store.getCompletedSurveys();
    if (completedSurveys.isEmpty) {
      return null;
    }
    return completedSurveys
        .reduce(
          (a, b) => a.dateTime.millisecondsSinceEpoch >
                  b.dateTime.millisecondsSinceEpoch
              ? a
              : b,
        )
        .dateTime;
  }

  Future<void> submitSurvey(SingleSurveyState state) async {
    dashLogInfo('Submitting survey ${state.survey.id}');
    _surveyHolderState._setSurveyToAnswered(completed: true);
    await api.postSurveyAnswers(
      state.survey.id,
      userId!,
      state.answers.values.toList(),
    );
  }
}

/// Show a demo survey that contains every question type
/// This is useful for developing the UI of your surveys
Future<void> showDemoSurvey({
  required BuildContext context,
  void Function(SurveyModel survey)? onComplete,
  void Function()? onCancel,
  SurveyDisplayType displayType = SurveyDisplayType.bottomSheet,
}) async {
  final locale = Localizations.localeOf(context);
  final localeCode = LocaleCode(locale.languageCode);
  // if (displayType == SurveyDisplayType.dialog) {
  //   return showSurveyDialog(
  //     context,
  //     locale: localeCode,
  //     survey: exampleSurvey,
  //     onSubmit: onComplete,
  //     onCancel: onCancel,
  //   );
  // } else if (displayType == SurveyDisplayType.bottomSheet) {
  return showSurveyBottomSheet(
    context,
    survey: exampleSurvey,
    onSubmit: onComplete,
    onCancel: onCancel,
    locale: localeCode,
  );
  // }
}

class SurveyHolderState extends ChangeNotifier {
  SurveyHolderState({required this.controller});
  final DashSurveyControllerImplementation controller;

  SurveyModel? _survey;

  SurveyModel? get survey => _survey;

  // final Map<String, SurveyModel> _viewSpecificSurveys = {};

  SurveyState _surveyState = SurveyState.loading;

  SurveyState get surveyState => _surveyState;

  // SurveyModel? getSurveyForView(String? viewId) {
  //   if (viewId == null) {
  //     return _survey;
  //   }
  //   return _viewSpecificSurveys[viewId];
  // }

  Future<void> fetch() async {
    _surveyState = SurveyState.loading;

    final fetchedSurvey = await controller._internalGetNextSurvey();

    if (fetchedSurvey == null) {
      _surveyState = SurveyState.noSurveyAvailable;
      notifyListeners();
    } else {
      _survey = fetchedSurvey;
      _surveyState = SurveyState.activeSurvey;
      notifyListeners();
    }
  }

  static SurveyHolderState of(BuildContext context) {
    return DashSurvey.of(context)._surveyHolderState;
  }

  void _setSurveyToAnswered({required bool completed}) {
    if (completed) {
      _surveyState = SurveyState.surveySubmitted;
    } else {
      _surveyState = SurveyState.surveyClosed;
    }
    notifyListeners();
  }
}
