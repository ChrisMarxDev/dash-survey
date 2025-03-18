part of 'dash_survey_controller.dart';

class SingleSurveyState extends ChangeNotifier {
  SingleSurveyState({
    required SurveyModel survey,
    required LocaleCode locale,
    Map<String, SurveyAnswerModel> answers = const {},
  })  : _survey = survey,
        _locale = locale,
        _answers = answers;

  // Private fields
  SurveyModel _survey;
  LocaleCode _locale;
  Map<String, SurveyAnswerModel> _answers;

  // Getters
  SurveyModel get survey => _survey;
  LocaleCode get locale => _locale;
  Map<String, SurveyAnswerModel> get answers => Map.unmodifiable(_answers);

  // Setters
  set survey(SurveyModel value) {
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

  // Method to update answers
  void updateAnswer(String questionId, SurveyAnswerModel answer) {
    final newAnswers = Map<String, SurveyAnswerModel>.from(_answers);
    newAnswers[questionId] = answer;

    _answers = newAnswers;
    dashLogInfo('updateAnswer: $questionId $answer');
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SingleSurveyState &&
        other._survey == _survey &&
        other._locale == _locale &&
        mapEquals(other._answers, _answers);
  }

  @override
  int get hashCode => Object.hash(
        _survey,
        _locale,
        Object.hashAll(_answers.entries),
      );

  static SingleSurveyState of(BuildContext context) {
    return StateProvider.of<SingleSurveyState>(context);
  }

  static Future<void> submitSurvey(BuildContext context) async {
    final controller = DashSurveyControllerImplementation.of(context);
    final state = SingleSurveyState.of(context);
    await controller.submitSurvey(state);
  }
}
