import 'package:dash_survey_core/dash_survey_core.dart';
import 'package:dash_survey_core/src/util/map_util.dart';
import 'package:uuid/uuid.dart';

/// example survey data for demo purposes
final exampleSurvey = SurveyModel(
  createdAt: DateTime.now(),
  id: 'example_survey',
  name: const LocalizedText(
    {
      LocaleCode.en: 'Demo Survey',
    },
  ),
  description: const LocalizedText(
    {
      LocaleCode.en: 'This is a demo survey',
    },
  ),
  questions: exampleQuestions,
);

/// example questions for demo purposes
final exampleQuestions = [
  MultipleChoiceSurveyQuestion(
    surveyId: 'demo',
    questionText: const LocalizedText(
      {
        LocaleCode.en: 'How old are you?',
      },
    ),
    id: 'example_question_1',
    options: LocalizedTextMap(
      {
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: '18-25',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: '26-35',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: '36-45',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: '46-55',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: '56+',
          },
        ),
      }.toLinkedHashMap(),
    ),
  ),
  MultipleChoiceSurveyQuestion(
    surveyId: 'demo',
    questionText: const LocalizedText(
      {
        LocaleCode.en: 'What is your favorite color?',
      },
    ),
    id: 'example_question_2',
    options: LocalizedTextMap(
      {
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Red',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Blue',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Green',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Yellow',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Purple',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Orange',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Black',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'White',
          },
        ),
      }.toLinkedHashMap(),
    ),
    canSelectMultiple: true,
  ),
  ScaleSurveyQuestion(
    surveyId: 'demo',
    questionText: const LocalizedText(
      {
        LocaleCode.en: 'How satisfied are you with our app?',
      },
    ),
    id: 'example_question_3',
    options: LocalizedTextMap(
      {
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Bad',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Neutral',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Good',
          },
        ),
        const Uuid().v7(): const LocalizedText(
          {
            LocaleCode.en: 'Excellent',
          },
        ),
      }.toLinkedHashMap(),
    ),
  ),
  const FreeTextSurveyQuestion(
    surveyId: 'demo',
    questionText: LocalizedText(
      {
        LocaleCode.en: 'Do you have any feedback for us?',
      },
    ),
    id: 'example_question_4',
  ),
];
