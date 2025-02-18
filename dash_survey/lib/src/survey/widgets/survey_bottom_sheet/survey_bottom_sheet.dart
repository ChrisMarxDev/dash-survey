import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/survey/widgets/buttons.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:dash_survey/src/util/notifier_builder.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

enum SurveyBottomSheetResult {
  submit,
  cancel,
}

Future<void> showSurveyBottomSheet(
  BuildContext context, {
  required SurveyModel survey,
  required LocaleCode locale,
  void Function(SurveyModel)? onSubmit,
  void Function()? onCancel,
}) async {
  final state = SingleSurveyState(
    survey: survey,
    locale: locale,
  );
  final result = await WoltModalSheet.show<SurveyBottomSheetResult>(
    context: context,
    pageContentDecorator: (child) {
      return StateProvider<SingleSurveyState>(
        state: state,
        child: child,
      );
    },
    pageListBuilder: (context) {
      return [
        WoltModalSheetPage(
          hasTopBarLayer: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
          hasSabGradient: false,
          isTopBarLayerAlwaysVisible: false,
          child: SurveyViewBottomSheet(
            survey: survey,
            // onCancel: () {
            //   onCancel?.call();
            //   Navigator.of(context).pop();
            // },
            // onSubmit: (survey) {
            //   onSubmit?.call(survey);
            //   Navigator.of(context).pop();
            // },
          ),
        ),
      ];
    },
    modalTypeBuilder: (context) {
      return WoltModalType.bottomSheet();
    },
    onModalDismissedWithBarrierTap: () {
      onCancel?.call();
    },
  );
  if (result == SurveyBottomSheetResult.submit) {
    onSubmit?.call(survey);
  } else if (result == SurveyBottomSheetResult.cancel) {
    onCancel?.call();
  }
}

class SurveyViewBottomSheet extends StatelessWidget {
  const SurveyViewBottomSheet({
    required this.survey,
    super.key,
  });

  final SurveyModel survey;

  @override
  Widget build(BuildContext context) {
    const locale = LocaleCode.en;
    return Builder(
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: SurveyIntroView(
                title: survey.name.get(locale),
                onCancel: () {
                  Navigator.of(context).pop(SurveyBottomSheetResult.cancel);
                },
                description: survey.description?.get(locale),
                onStart: () {
                  WoltModalSheet.of(context).pushPage(
                    SurveySheetPage.buildModalPage(
                      context,
                      survey,
                      0,
                      locale,
                      // onSubmit,
                      // onCancel,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class SurveySheetPage extends StatelessWidget {
  const SurveySheetPage({
    required this.survey,
    required this.index,
    required this.locale,
    super.key,
  });

  final SurveyModel survey;
  final int index;
  final LocaleCode locale;

  static SliverWoltModalSheetPage buildModalPage(
    BuildContext context,
    SurveyModel survey,
    int index,
    LocaleCode locale,
    // void Function(SurveyQuestionModel question) onSubmit,
    // void Function() onCancel,
  ) {
    return SliverWoltModalSheetPage(
      hasTopBarLayer: false,
      isTopBarLayerAlwaysVisible: false,
      mainContentSliversBuilder: (context) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 32),
              child: SurveySheetPage(
                survey: survey,
                index: index,
                locale: locale,
              ),
            ),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = survey.questions[index];
    final onNext = index < survey.questions.length - 1
        ? () {
            WoltModalSheet.of(context).pushPage(
              SurveySheetPage.buildModalPage(
                context,
                survey,
                index + 1,
                locale,
              ),
            );
          }
        : () async {
            // onSubmit(question);
            await SingleSurveyState.submitSurvey(context)
                .onError((error, stackTrace) {
              logError('Error submitting survey: $error');
            });
            Navigator.of(context).pop(SurveyBottomSheetResult.submit);
          };
    void onPrevious() {
      WoltModalSheet.of(context).popPage();
    }

    final answer = StateProvider.maybeOf<SingleSurveyState>(context);
    return NullableNotifierBuilder(
      notifier: answer,
      builder: (context, answer) {
        final hasAnswer = answer?.answers.containsKey(question.id) ?? false;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 16,
                top: 8,
              ),
              child: SurveyQuestionView(
                question: question,
                locale: locale,
              ),
            ),
            SurveyActionButtons(
              onPrevious: onPrevious,
              onNext: hasAnswer ? onNext : null,
              isSubmit: index == survey.questions.length - 1,
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}

class SurveyActionButtons extends StatelessWidget {
  const SurveyActionButtons({
    super.key,
    this.onPrevious,
    this.onNext,
    this.isSubmit = false,
  });

  final void Function()? onPrevious;
  final void Function()? onNext;
  final bool isSubmit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: onPrevious,
          child: const Text('Previous'),
        ),
        MainButton(
          onPressed: onNext,
          child: isSubmit ? const Text('Submit') : const Text('Next'),
        ),
      ],
    );
  }
}
