import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_answer_model.mapper.dart';

@MappableClass()

/// Model for submitting a complete set of survey answers
class SubmitSurveyAnswerModel with SubmitSurveyAnswerModelMappable {
  /// Creates a new SubmitSurveyAnswerModel
  SubmitSurveyAnswerModel({
    required this.answers,
    required this.surveyId,
    required this.userId,
    this.completed = true,
    this.demoMode = false,
  });

  /// List of individual question answers
  final List<SurveyAnswerModel> answers;

  /// ID of the survey being answered
  final String surveyId;

  /// ID of the user submitting the answers
  final String userId;

  /// Whether the survey was completed fully
  final bool completed;

  /// Whether the submission is in demo mode
  final bool demoMode;
}

@MappableClass()

/// Base class for all types of survey answers
sealed class SurveyAnswerModel with SurveyAnswerModelMappable {
  /// Creates a new SurveyAnswerModel
  const SurveyAnswerModel({
    required this.questionId,
  });

  /// ID of the question being answered
  final String questionId;
}

@MappableClass()

/// Model for free text answers to survey questions
class FreetextAnswerModel extends SurveyAnswerModel
    with FreetextAnswerModelMappable {
  /// Creates a new FreetextAnswerModel
  const FreetextAnswerModel({
    required super.questionId,
    required this.answer,
    this.locale,
  });

  /// The text answer provided by the user
  final String answer;

  /// Optional locale of the answer
  final LocaleCode? locale;
}

@MappableClass()

/// Model for multiple choice answers to survey questions
class MultipleChoiceAnswerModel extends SurveyAnswerModel
    with MultipleChoiceAnswerModelMappable {
  /// Creates a new MultipleChoiceAnswerModel
  const MultipleChoiceAnswerModel({
    required super.questionId,
    required this.answersIds,
    this.customAnswer,
    this.locale,
  });

  /// List of selected answer option IDs
  final List<String> answersIds;

  /// Optional custom text answer if provided
  final String? customAnswer;

  /// Optional locale of the custom answer
  final LocaleCode? locale;
}

@MappableClass()

/// Model for scale/rating answers to survey questions
class ScaleAnswerModel extends SurveyAnswerModel with ScaleAnswerModelMappable {
  /// Creates a new ScaleAnswerModel
  const ScaleAnswerModel({
    required super.questionId,
    required this.answer,
  });

  /// The numeric scale value selected by the user
  final double answer;
}
