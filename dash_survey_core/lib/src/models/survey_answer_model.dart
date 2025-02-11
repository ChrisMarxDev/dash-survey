import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_answer_model.mapper.dart';

@MappableClass()
class SubmitSurveyAnswerModel with SubmitSurveyAnswerModelMappable {
  SubmitSurveyAnswerModel({
    required this.answers,
    required this.surveyId,
    required this.userId,
  });

  final List<SurveyAnswerModel> answers;

  final String surveyId;
  final String userId;
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
    required this.answers,
  });

  final List<String> answers;
}

@MappableClass()
class ScaleAnswerModel extends SurveyAnswerModel with ScaleAnswerModelMappable {
  const ScaleAnswerModel({
    required super.questionId,
    required this.answer,
  });

  final double answer;
}
