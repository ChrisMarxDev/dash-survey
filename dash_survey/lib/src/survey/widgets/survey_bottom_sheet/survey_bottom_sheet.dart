import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:dash_survey/src/survey/widgets/common/buttons.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:dash_survey/src/util/notifier_builder.dart';
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

/// The result of the survey bottom sheet
/// either successfully submitted or cancelled
enum SurveyBottomSheetResult {
  /// The survey was successfully submitted
  submit,

  /// The survey was cancelled
  cancel,
}

/// Shows a survey bottom sheet
///
/// The bottom sheet will display a survey question and a button row
///
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
  final theme = DashSurveyTheme.of(context);

  final hasIntroPage = survey.hasIntroPage;
  // final hasOutroPage = survey.hasOutroPage;
  final result = await WoltModalSheet.show<SurveyBottomSheetResult>(
    context: context,
    pageContentDecorator: (child) {
      return DashSurveyTheme(
        theme: theme,
        child: StateProvider<SingleSurveyState>(
          state: state,
          child: child,
        ),
      );
    },
    pageListBuilder: (context) {
      return [
        if (hasIntroPage)
          WoltModalSheetPage(
            hasTopBarLayer: false,
            backgroundColor: theme.backgroundColor,
            // for now we ignore surface tint in our designs
            surfaceTintColor: context.transparentColor,
            hasSabGradient: false,
            isTopBarLayerAlwaysVisible: false,
            child: SurveyViewBottomSheet(
              survey: survey,
            ),
          ),
        if (!hasIntroPage)
          SurveySheetPage.buildModalPage(
            context,
            survey,
            0,
            locale,
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

/// A widget that displays a survey modal bottom sheet
///
/// The bottom sheet will display a survey question and a button row
///
class SurveyViewBottomSheet extends StatelessWidget {
  /// A widget that displays a survey bottom sheet
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
            const SizedBox(height: 16),
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

/// A page that displays a survey question and a button row
///
class SurveySheetPage extends StatelessWidget {
  /// A page that displays a survey question and a button row
  const SurveySheetPage({
    required this.survey,
    required this.index,
    required this.locale,
    super.key,
  });

  /// The survey model
  final SurveyModel survey;

  /// The index of the question
  final int index;

  /// The locale
  final LocaleCode locale;

  /// Builds a modal page
  static SliverWoltModalSheetPage buildModalPage(
    BuildContext context,
    SurveyModel survey,
    int index,
    LocaleCode locale,
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
              dashLogError('Error submitting survey: $error');
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
            const SizedBox(height: 16),
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
        TertiaryButton(
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
