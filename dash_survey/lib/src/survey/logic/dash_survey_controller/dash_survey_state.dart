import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/async_value.dart';
import 'package:flutter/foundation.dart';

class DashSurveyState extends ChangeNotifier {
  DashSurveyState({
    required AsyncValue<SurveyModel?> survey,
    required LocaleCode locale,
  })  : _survey = survey,
        _locale = locale;

  // Private fields
  AsyncValue<SurveyModel?> _survey;
  LocaleCode _locale;

  // Getters
  AsyncValue<SurveyModel?> get survey => _survey;
  LocaleCode get locale => _locale;

  // Setters
  set survey(AsyncValue<SurveyModel?> value) {
    if (_survey != value) {
      _survey = value;
      notifyListeners();
    }
  }

  set locale(LocaleCode value) {
    if (_locale != value) {
      _locale = value;
      notifyListeners();
    }
  }
}
