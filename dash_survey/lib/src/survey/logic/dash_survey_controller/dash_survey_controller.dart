import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
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
    SurveyDisplayType displayType = SurveyDisplayType.bottomSheet,
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

/// The implementation of the [DashSurveyController] interface.
/// This is the main controller for the dash survey.
/// It is responsible for fetching the next survey object and displaying it.
/// It has some more internal functions to handle the survey state and the user
/// than the user facing [DashSurveyController] interface.
class DashSurveyControllerImplementation implements DashSurveyController {
  /// Create a new controller with the given API key.
  /// The API key is used to authenticate the user with the survey dash API.
  /// You can get the API key from the survey dash dashboard.
  DashSurveyControllerImplementation({
    required String apiKey,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
    this.debugMode = false,
  }) {
    _currentContextGetter = currentContextGetter;
    _api = DashSurveyApiService(
      config.baseUrl ?? 'https://api.dash-survey.com',
      apiKey,
    );
    _store = _DashSurveyStoreService(
      sharedPreferencesFuture: SharedPreferences.getInstance(),
    );
    _surveyHolderState = SurveyHolderState(
      controller: this,
    );
  }
  @visibleForTesting
  // ignore: public_member_api_docs
  DashSurveyControllerImplementation.fromRequiredServices({
    required DashSurveyApiService api,
    // ignore: library_private_types_in_public_api
    required _DashSurveyStoreService storeService,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
    this.debugMode = false,
  }) {
    _api = api;
    _currentContextGetter = currentContextGetter;
    _store = storeService;
    _surveyHolderState = SurveyHolderState(
      controller: this,
    );
  }

  /// The locale to use for the survey.
  /// If not set, the locale of the current context will be used.
  final Locale? overrideLocale;

  /// The config for the survey.
  /// This is used to configure the survey.
  final DashSurveyConfig config;

  /// The function to get the current context.
  /// This is used to get the current context for the survey.
  late final BuildContext Function() _currentContextGetter;

  /// Enables demo mode.
  /// If true, the survey will be fetched even if the user is not eligible.
  final bool debugMode;

  /// The user id for the current user.
  /// This is used to identify the user in the survey dash API.
  String? userId;

  // services
  late final DashSurveyApiService _api;

  late final _DashSurveyStoreService _store;

  late final SurveyHolderState _surveyHolderState;

  final Completer<void> _initCompleter = Completer<void>();
  // final Completer<void> _fetchCompleter = Completer<void>();

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
    SurveyDisplayType displayType = SurveyDisplayType.bottomSheet,
    String? viewId,
  }) async {
    final nextSurvey = await getNextSurvey(viewId: viewId);
    if (nextSurvey == null) {
      return;
    }
    if (displayType == SurveyDisplayType.bottomSheet) {
      await showSurveyBottomSheet(
        _currentContextGetter(),
        locale: getLocaleCode(),
        survey: nextSurvey,
      );
    }
  }

  /// Fetch the next survey object for this user.
  /// This is useful if you want to display the survey in a different way than
  /// the default or if you want to display the survey in a different context.
  /// The logic for this function is shared with the [showNextSurvey] function.
  @override
  Future<SurveyModel?> getNextSurvey({String? viewId}) async {
    if (_surveyHolderState._surveyState == SurveyState.activeSurvey &&
        _surveyHolderState.survey != null) {
      return _surveyHolderState.survey;
    }
    _surveyHolderState._surveyState = SurveyState.loading;
    final lastSurveyDate = await _lastSurveyDate();
    dashLogInfo('Last survey date: $lastSurveyDate');

    final isElligleAgain = lastSurveyDate == null ||
        config.surveyCoolDownInDays == 0 ||
        lastSurveyDate.isBefore(
          DateTime.now().subtract(
            Duration(days: config.surveyCoolDownInDays),
          ),
        );

    if (!isElligleAgain && !debugMode) {
      return null;
    }
    final surveys = await _rawFetchSurveys();
    dashLogInfo('Surveys: ${surveys.firstOrNull?.toJson()}');

    final fetchedSurvey = surveys.lastOrNull;
    if (fetchedSurvey == null) {
      if (debugMode) {
        _surveyHolderState._setSurvey(exampleSurvey);
      } else {
        _surveyHolderState._setNoSurveyAvailable();
      }
      return _surveyHolderState.survey;
    }
    _surveyHolderState._setSurvey(fetchedSurvey);
    return _surveyHolderState.survey;
  }

  /// Raw api call to fetch the next survey object for this user.
  Future<List<SurveyModel>> _rawFetchSurveys() async {
    final targetDimensions = await _store.getUserTargetDimensions();
    final surveys = await _api.getElliglbeOpenSurveys(
      userId: userId!,
      localeCode: getLocaleCode(),
      targetDimensions: targetDimensions,
      demoMode: debugMode,
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

  /// Submit a survey answer to the API.
  /// This will save the answers to the database.
  Future<void> submitSurvey(SingleSurveyState state) async {
    dashLogInfo('Submitting survey ${state.survey.id}');
    await _store.addCompletedSurvey(state.survey.id);
    _surveyHolderState._setSurveyToAnswered(completed: true);
    await _api.postSurveyAnswers(
      state.survey.id,
      userId!,
      state.answers.values.toList(),
    );
  }

  static DashSurveyControllerImplementation of(BuildContext context) {
    return DashSurvey.of(context) as DashSurveyControllerImplementation;
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
  return showSurveyBottomSheet(
    context,
    survey: exampleSurvey,
    onSubmit: onComplete,
    onCancel: onCancel,
    locale: localeCode,
  );
}

class SurveyHolderState extends ChangeNotifier {
  SurveyHolderState({required this.controller});
  final DashSurveyControllerImplementation controller;

  SurveyModel? _survey;

  /// The survey object held by the controller.
  /// This is used to display the survey in the UI.
  SurveyModel? get survey => _survey;

  // final Map<String, SurveyModel> _viewSpecificSurveys = {};

  SurveyState _surveyState = SurveyState.loading;

  /// The state of the survey.
  /// This is used to determine what to display in the UI.
  SurveyState get surveyState => _surveyState;

  void _setNoSurveyAvailable() {
    _survey = null;
    _surveyState = SurveyState.noSurveyAvailable;
    notifyListeners();
  }

  void _setSurvey(SurveyModel survey) {
    _survey = survey;
    _surveyState = SurveyState.activeSurvey;
    notifyListeners();
  }

  static SurveyHolderState of(BuildContext context) {
    return DashSurveyControllerImplementation.of(context)._surveyHolderState;
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

/// A stub implementation of the [DashSurveyController] interface.
/// This is used when the survey is disabled.
class DisabledDashSurveyController implements DashSurveyController {
  void _logWarning(String functionName) {
    final serviceDisabledWarning =
        // ignore: lines_longer_than_80_chars
        'WARNING: DashSurvey function $functionName was called, but the service is currently disabled';
    if (kDebugMode) {
      log(serviceDisabledWarning);
    }
  }

  @override
  Future<SurveyModel?> getNextSurvey({String? viewId}) async {
    _logWarning('getNextSurvey');
    return null;
  }

  @override
  Future<void> clearUserConfiguration() async {
    _logWarning('clearUserConfiguration');
  }

  @override
  Future<void> setUserDimensions(Map<String, String> params) async {
    _logWarning('setUserDimensions');
  }

  @override
  Future<void> showNextSurvey({
    void Function(SurveyModel survey)? onComplete,
    void Function()? onCancel,
    SurveyDisplayType displayType = SurveyDisplayType.bottomSheet,
    String? viewId,
  }) async {
    _logWarning('showNextSurvey');
  }
}
