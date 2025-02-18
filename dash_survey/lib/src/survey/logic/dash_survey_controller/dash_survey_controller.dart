import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/survey/widgets/survey_dialog/survey_dialog.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'single_survey_state.dart';
part 'store_service.dart';

abstract interface class DashSurveyControllerContract {
  Future<SurveyModel?> getNextSurvey({String? viewId});

  Future<void> showNextSurvey({
    void Function(SurveyModel survey)? onComplete,
    void Function()? onCancel,
    String? viewId,
  });

  Future<void> setUserDimensions(Map<String, String> params);

  Future<void> clearUserConfiguration();
}

class DashSurveyController implements DashSurveyControllerContract {
  /// Create a new controller with the given API key.
  /// The API key is used to authenticate the user with the survey dash API.
  /// You can get the API key from the survey dash dashboard.
  DashSurveyController({
    required String apiKey,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
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
  DashSurveyController.fromRequiredServices({
    required this.api,
    required _DashSurveyStoreService storeService,
    required BuildContext Function() currentContextGetter,
    this.overrideLocale,
    this.config = const DashSurveyConfig(),
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

  // TODOFIX
  final SurveyState surveyState = SurveyState.loading;

  String? userId;

  final List<SurveyModel> surveys = [];

  final Completer<void> _initCompleter = Completer<void>();

  /// Get the survey questions from the survey dash API.
  /// This is useful if you want to display the survey in a different way than
  /// the default or if you want to display the survey in a different context.
  /// The logic for this function is shared with the [DashSurveyController.showNextSurvey] function.
  Future<void> getSurveyQuestions() async {
    // final response = await http.get(Uri.parse('https://api.surveydash.com/v1/questions'));
  }

  Future<void> submitSurveyAnswers(List<SurveyQuestionModel> answers) async {
    // final response = await http.post(Uri.parse('https://api.surveydash.com/v1/submit'), body: answers);
  }

  Future<void> init() async {
    // setup this users id
    userId = await _store.getUserId();

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
      locale: _getLocaleCode(),
      survey: nextSurvey,
      // onSubmit: onComplete,
      // onCancel: onCancel,
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
    print('Surveys: ${surveys.first.toJson()}');

    return surveys.lastOrNull;
  }

  Future<List<SurveyModel>> _fetchNextSurveyObjects() async {
    final targetDimensions = await _store.getUserTargetDimensions();
    final surveys = await api.getElliglbeOpenSurveys(
      userId: userId!,
      localeCode: _getLocaleCode(),
      targetDimensions: targetDimensions,
    );
    return surveys;
  }

  LocaleCode _getLocaleCode() {
    final locale =
        overrideLocale ?? Localizations.localeOf(_currentContextGetter());
    return LocaleCode(locale.languageCode);
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
    logInfo('Submitting survey ${state.survey.id}');
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
  if (displayType == SurveyDisplayType.dialog) {
    return showSurveyDialog(
      context,
      locale: localeCode,
      survey: exampleSurvey,
      onSubmit: onComplete,
      onCancel: onCancel,
    );
  } else if (displayType == SurveyDisplayType.bottomSheet) {
    return showSurveyBottomSheet(
      context,
      survey: exampleSurvey,
      onSubmit: onComplete,
      onCancel: onCancel,
      locale: localeCode,
    );
  }
}

class SurveyHolderState extends ChangeNotifier {
  SurveyHolderState({required this.controller});
  final DashSurveyController controller;

  SurveyModel? _survey;

  SurveyModel? get survey => _survey;

  SurveyState _surveyState = SurveyState.loading;

  SurveyState get surveyState => _surveyState;

  Future<void> fetch() async {
    _surveyState = SurveyState.loading;

    _survey = await controller.getNextSurvey();

    notifyListeners();
  }

  void setSurvey(SurveyModel survey) {
    _survey = survey;
    notifyListeners();
  }

  Future<void> init() async {
    await fetch();
    notifyListeners();
  }
}
