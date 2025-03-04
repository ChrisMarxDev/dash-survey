import 'package:dash_survey/src/survey/logic/dash_survey_controller/dash_survey_controller.dart';
import 'package:dash_survey/src/survey/widgets/buttons.dart';
import 'package:dash_survey/src/survey/widgets/widgets.dart';
import 'package:dash_survey/src/util/build_context_extension.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:dash_survey/src/util/notifier_builder.dart';
import 'package:dash_survey/src/util/object_extension.dart';
import 'package:dash_survey_core/dash_survey_core.dart';
import 'package:flutter/material.dart';

// class SurveyView extends StatelessWidget {
//   const SurveyView({
//     required this.survey,
//     required this.onClose,
//     required this.onSubmit,
//     required this.locale,
//     this.scrollController,
//     super.key,
//   });

//   final SurveyModel survey;
//   final VoidCallback onClose;
//   final void Function(SurveyModel) onSubmit;
//   final ScrollController? scrollController;
//   final LocaleCode locale;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(survey.name.get(locale)),
//         const SizedBox(height: 16),
//         Text(survey.description?.get(locale) ?? ''),
//         const SizedBox(height: 16),
//         QuestionPager(
//           scrollController: scrollController,
//           survey: survey,
//           onSubmit: onSubmit,
//           onCancel: () {},
//           locale: locale,
//         ),
//       ],
//     );
//   }
// }

// class QuestionPager extends StatefulWidget {
//   const QuestionPager({
//     required this.survey,
//     required this.onSubmit,
//     required this.onCancel,
//     required this.locale,
//     this.scrollController,
//     super.key,
//   });

//   final SurveyModel survey;
//   final void Function(SurveyModel) onSubmit;
//   final VoidCallback onCancel;
//   final ScrollController? scrollController;
//   final LocaleCode locale;
//   @override
//   State<QuestionPager> createState() => _QuestionPagerState();
// }

// class _QuestionPagerState extends State<QuestionPager> {
//   int _currentQuestionIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       controller: widget.scrollController,
//       child: Column(
//         children: [
//           SurveyQuestionView(
//             question: widget.survey.questions[_currentQuestionIndex],
//             locale: widget.locale,
//           ),
//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Text(
//                 '${_currentQuestionIndex + 1} / ${widget.survey.questions.length}',
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               MainButton(
//                 onPressed: () {
//                   setState(() {
//                     if (_currentQuestionIndex <
//                         widget.survey.questions.length - 1) {
//                       _currentQuestionIndex++;
//                     } else {
//                       widget.onSubmit(widget.survey);
//                     }
//                   });
//                 },
//                 child: const Text('Next'),
//               ),
//               MainButton(
//                 onPressed: () {
//                   setState(() {
//                     if (_currentQuestionIndex > 0) {
//                       _currentQuestionIndex--;
//                     }
//                   });
//                 },
//                 child: const Text('Previous'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class SurveyIntroView extends StatelessWidget {
  const SurveyIntroView({
    required this.title,
    required this.onStart,
    required this.onCancel,
    this.description,
    this.startButtonText = 'Start Survey',
    this.hasSkipButton = true,
    this.skipButtonText = 'Skip',
    super.key,
  });

  final String title;
  final String? description;
  final VoidCallback onStart;
  final VoidCallback onCancel;
  final String startButtonText;
  final String skipButtonText;
  final bool hasSkipButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        if (description != null) ...[
          Text(description ?? ''),
        ],
        const SizedBox(height: 24),
        SurveyButtonRow(
          hasPrevious: hasSkipButton,
          onPrevious: onCancel,
          previousButtonText: skipButtonText,
          onNext: onStart,
          nextButtonText: startButtonText,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SurveyThankYouView extends StatelessWidget {
  const SurveyThankYouView({
    required this.survey,
    required this.locale,
    super.key,
  });

  final SurveyModel survey;
  final LocaleCode locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            survey.finishedMessage?.get(locale) ??
                context.getTranslatedString('survey_finished'),
          ),
        ),
      ],
    );
  }
}

class SurveyButtonRow extends StatelessWidget {
  const SurveyButtonRow({
    required this.onPrevious,
    required this.previousButtonText,
    required this.onNext,
    required this.nextButtonText,
    this.hasPrevious = true,
    super.key,
  });

  final VoidCallback onPrevious;
  final String previousButtonText;
  final VoidCallback? onNext;
  final String nextButtonText;
  final bool hasPrevious;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasPrevious) ...[
          TextButton(onPressed: onPrevious, child: Text(previousButtonText)),
          const SizedBox(width: 16),
        ],
        MainButton(onPressed: onNext, child: Text(nextButtonText)),
      ],
    );
  }
}

class SurveyQuestionPageView extends StatelessWidget {
  const SurveyQuestionPageView({
    required this.question,
    required this.locale,
    required this.onNext,
    required this.onPrevious,
    super.key,
  });

  final SurveyQuestionModel question;
  final LocaleCode locale;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  @override
  Widget build(BuildContext context) {
    final answer = StateProvider.maybeOf<SingleSurveyState>(context);
    final currentAnswer = answer?.answers[question.id];
    return Column(
      children: [
        SurveyQuestionView(
          question: question,
          locale: locale,
        ),
        const SizedBox(height: 24),
        SurveyButtonRow(
          onPrevious: onPrevious,
          previousButtonText: 'Previous',
          onNext: currentAnswer != null ? onNext : null,
          nextButtonText: 'Next',
        ),
      ],
    );
  }
}

class SurveyQuestionView extends StatefulWidget {
  const SurveyQuestionView({
    required this.question,
    required this.locale,
    super.key,
  });

  final SurveyQuestionModel question;
  final LocaleCode locale;
  @override
  State<SurveyQuestionView> createState() => _SurveyQuestionViewState();
}

class _SurveyQuestionViewState extends State<SurveyQuestionView> {
  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final answer = StateProvider.maybeOf<SingleSurveyState>(context);
    return Column(
      children: [
        Text(
          question.questionText.get(widget.locale),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),
        NullableNotifierBuilder(
          notifier: answer,
          builder: (context, child) {
            return _QuestionTypeWidget(
              initQuestion: question,
              locale: widget.locale,
              answer: answer?.answers[question.id],
              onChangeAnswer: (value) {
                StateProvider.maybeOf<SingleSurveyState>(context)
                    ?.updateAnswer(question.id, value);
              },
            );
          },
        ),
      ],
    );
  }
}

class _QuestionTypeWidget extends StatelessWidget {
  const _QuestionTypeWidget({
    required this.initQuestion,
    required this.locale,
    required this.onChangeAnswer,
    this.answer,
  });

  final SurveyQuestionModel initQuestion;
  final LocaleCode locale;
  final SurveyAnswerModel? answer;
  final void Function(SurveyAnswerModel) onChangeAnswer;
  @override
  Widget build(BuildContext context) {
    final surveyState = StateProvider.maybeOf<SingleSurveyState>(context);
    dashLogInfo('surveyState: $surveyState');

    final question = initQuestion;
    return switch (question) {
      FreeTextSurveyQuestion() => FreeTextSurveyWidget(
          locale: locale,
          onChangeAnswer: (value) {
            onChangeAnswer.call(
              question.answer(
                answer: value,
              ),
            );
          },
          answer: answer?.asTypeOrNull<FreetextAnswerModel>(),
          question: question,
        ),
      MultipleChoiceSurveyQuestion() => MultipleChoiceSurveyWidget(
          locale: locale,
          isMultiSelect: question.canSelectMultiple,
          answer: answer?.asTypeOrNull<MultipleChoiceAnswerModel>(),
          onChangeAnswer: (List<String> value) {
            onChangeAnswer.call(
              question.answer(
                answers: value,
              ),
            );
          },
          question: question,
        ),
      ScaleSurveyQuestion() => ScaleSurveyWidget(
          locale: locale,
          onChangeAnswer: (double value) {
            onChangeAnswer.call(
              question.answer(
                answer: value,
              ),
            );
          },
          answer: answer?.asTypeOrNull<ScaleAnswerModel>(),
          question: question,
        ),
    };
  }
}
