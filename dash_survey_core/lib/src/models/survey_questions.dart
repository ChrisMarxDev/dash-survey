import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';

part 'survey_questions.mapper.dart';

@MappableClass()
sealed class SurveyQuestionModel with SurveyQuestionModelMappable {
  const SurveyQuestionModel({
    required this.questionText,
    required this.id,
    required this.surveyId,
  });

  final LocalizedText questionText;
  final String id;
  final String surveyId;
}

@MappableEnum()
enum TextType {
  any,
  float,
  int,
  email,
}

@MappableEnum()
enum SurveyQuestionType {
  freeText,
  multipleChoice,
  singleChoice,
  scale;

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
class FreeTextSurveyQuestion extends SurveyQuestionModel
    with FreeTextSurveyQuestionMappable {
  const FreeTextSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    this.textType = TextType.any,
  });

  final TextType textType;

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
class MultipleChoiceSurveyQuestion extends SurveyQuestionModel
    with MultipleChoiceSurveyQuestionMappable {
  const MultipleChoiceSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    required this.options,
    this.canSelectMultiple = false,
  });

  final LocalizedTextMap options;
  final bool canSelectMultiple;

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
enum ScaleType {
  scale,
  slider,
  stars,
  emoji;
}

@MappableClass()
class ScaleSurveyQuestion extends SurveyQuestionModel
    with ScaleSurveyQuestionMappable {
  const ScaleSurveyQuestion({
    required super.questionText,
    required super.id,
    required super.surveyId,
    required this.options,
    this.scaleType = ScaleType.scale,
  });

  final ScaleType scaleType;
  final LocalizedTextMap options;

  ScaleAnswerModel answer({
    required double answer,
  }) {
    return ScaleAnswerModel(
      questionId: id,
      answer: answer,
    );
  }
}
