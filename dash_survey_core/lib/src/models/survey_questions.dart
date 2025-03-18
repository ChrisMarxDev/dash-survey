import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_questions.mapper.dart';

@MappableClass()

/// Base class for all types of survey questions
sealed class SurveyQuestionModel with SurveyQuestionModelMappable {
  /// Creates a new SurveyQuestionModel
  const SurveyQuestionModel({
    required this.questionText,
    required this.id,
    required this.surveyId,
    this.isRequired = true,
  });

  /// The localized text of the question
  final LocalizedText questionText;

  /// Unique identifier for the question
  final String id;

  /// ID of the survey this question belongs to
  final String surveyId;

  /// Whether the question is required
  final bool isRequired;
}

@MappableEnum()

/// Defines the type of text input expected for free text questions
enum TextType {
  /// Any text input is allowed
  any,

  /// Only floating point numbers are allowed
  float,

  /// Only integer numbers are allowed
  int,

  /// Only valid email addresses are allowed
  email,
}

@MappableEnum()

/// Defines the different types of survey questions
enum SurveyQuestionType {
  /// Free text input question
  freeText,

  /// Multiple choice question where multiple options can be selected
  multipleChoice,

  /// Single choice question where only one option can be selected
  singleChoice,

  /// Scale/rating question
  scale;

  /// Determines the question type from a SurveyQuestionModel instance
  /// @param question The question model to check
  /// @return The corresponding SurveyQuestionType
  static SurveyQuestionType fromModel(SurveyQuestionModel question) {
    return switch (question) {
      FreeTextSurveyQuestion() => SurveyQuestionType.freeText,
      MultipleChoiceSurveyQuestion() => SurveyQuestionType.multipleChoice,
      ScaleSurveyQuestion() => SurveyQuestionType.scale,
    };
  }

  // SurveyQuestionModel empty(
  //   String id,
  //   String surveyId, [
  //   List<LocaleCode> locales = const [],
  // ]) {
  //   return switch (this) {
  //     SurveyQuestionType.freeText => FreeTextSurveyQuestion(
  //         id: id,
  //         surveyId: surveyId,
  //         questionText: LocalizedText.empty(locales),
  //       ),
  //     SurveyQuestionType.multipleChoice => MultipleChoiceSurveyQuestion(
  //         id: id,
  //         surveyId: surveyId,
  //         questionText: LocalizedText.empty(locales),
  //         options: LocalizedTextMap.empty(),
  //       ),
  //     SurveyQuestionType.scale => ScaleSurveyQuestion(
  //         id: id,
  //         surveyId: surveyId,
  //         questionText: LocalizedText.empty(locales),
  //         options: LocalizedTextMap.empty(),
  //       ),
  //   };
  // }
}

@MappableClass()

/// Model for free text survey questions
class FreeTextSurveyQuestion extends SurveyQuestionModel
    with FreeTextSurveyQuestionMappable {
  /// Creates a new FreeTextSurveyQuestion
  const FreeTextSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    super.isRequired,
    this.textType = TextType.any,
  });

  /// The type of text input expected for this question
  final TextType textType;

  /// Creates an answer model for this question
  /// @param answer The text answer provided by the user
  /// @return A FreetextAnswerModel for this question
  FreetextAnswerModel answer({
    required String answer,
  }) {
    return FreetextAnswerModel(
      questionId: id,
      answer: answer,
    );
  }
}

@MappableClass()

/// Model for multiple choice survey questions
class MultipleChoiceSurveyQuestion extends SurveyQuestionModel
    with MultipleChoiceSurveyQuestionMappable {
  /// Creates a new MultipleChoiceSurveyQuestion
  const MultipleChoiceSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    required this.options,
    super.isRequired,
    this.canSelectMultiple = false,
  });

  /// The available options for this question
  final LocalizedTextMap options;

  /// Whether multiple options can be selected
  final bool canSelectMultiple;

  /// Creates an answer model for this question
  /// @param answers List of selected option IDs
  /// @return A MultipleChoiceAnswerModel for this question
  MultipleChoiceAnswerModel answer({
    required List<String> answers,
  }) {
    return MultipleChoiceAnswerModel(
      questionId: id,
      answersIds: answers,
    );
  }
}

@MappableEnum()

/// Defines the different types of scale/rating questions
enum ScaleType {
  /// Traditional numeric scale
  scale,

  /// Slider control for selecting a value
  slider,

  /// Star rating display
  stars,

  /// Emoji-based rating display
  emoji;
}

@MappableClass()

/// Model for scale/rating survey questions
class ScaleSurveyQuestion extends SurveyQuestionModel
    with ScaleSurveyQuestionMappable {
  /// Creates a new ScaleSurveyQuestion
  const ScaleSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    required this.options,
    super.isRequired,
    this.scaleType = ScaleType.scale,
  });

  /// The type of scale/rating display to use
  final ScaleType scaleType;

  /// The available options/labels for the scale points
  final LocalizedTextMap options;

  /// Creates an answer model for this question
  /// @param answer The numeric value selected by the user
  /// @return A ScaleAnswerModel for this question
  ScaleAnswerModel answer({
    required double answer,
  }) {
    return ScaleAnswerModel(
      questionId: id,
      answer: answer,
    );
  }
}
