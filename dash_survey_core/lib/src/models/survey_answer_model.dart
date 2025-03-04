import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_answer_model.mapper.dart';

@MappableClass()
class SubmitSurveyAnswerModel with SubmitSurveyAnswerModelMappable {
  SubmitSurveyAnswerModel({
    required this.answers,
    required this.surveyId,
    required this.userId,
    this.completed = true,
    this.demoMode = false,
  });

  final List<SurveyAnswerModel> answers;

  final String surveyId;
  final String userId;
  final bool completed;
  final bool demoMode;
}

@MappableClass()
sealed class SurveyAnswerModel with SurveyAnswerModelMappable {
  const SurveyAnswerModel({
    required this.questionId,
  });

  final String questionId;
}

@MappableClass()
class FreetextAnswerModel extends SurveyAnswerModel
    with FreetextAnswerModelMappable {
  const FreetextAnswerModel({
    required super.questionId,
    required this.answer,
    this.locale,
  });

  final String answer;
  final LocaleCode? locale;
}

@MappableClass()
class MultipleChoiceAnswerModel extends SurveyAnswerModel
    with MultipleChoiceAnswerModelMappable {
  const MultipleChoiceAnswerModel({
    required super.questionId,
    required this.answersIds,
    this.customAnswer,
    this.locale,
  });

  final List<String> answersIds;
  final String? customAnswer;
  final LocaleCode? locale;
}

@MappableClass()
class ScaleAnswerModel extends SurveyAnswerModel with ScaleAnswerModelMappable {
  const ScaleAnswerModel({
    required super.questionId,
    required this.answer,
  });

  final double answer;
}
