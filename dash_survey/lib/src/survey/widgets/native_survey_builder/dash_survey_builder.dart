import 'dart:async';
import 'dart:developer';

import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/dash_survey_logger.dart';
import 'package:dash_survey/src/util/inherited_widget_provider.dart';
import 'package:dash_survey/src/util/notifier_builder.dart';
import 'package:flutter/material.dart';

/// A builder that is used to style the transition between the survey pages
///
/// The [isNext] parameter is used to determine if the transition is for a
/// next or previous page. E.g. if [isNext] is true, the transition is for a
/// next page, otherwise it is for a previous page.
///
/// The [animation] parameter is used to animate the transition.
///
/// The [child] parameter is the widget that is being animated.
typedef AnimatedPageSwitcherTransitionBuilder = Widget Function({
  required Widget child,
  required bool isNext,
  required Animation<double> animation,
});

/// Builder widget that automatically show the next survey, if it is available.
/// You can use use the widget like the following as is to get full survey functionality.
/// E.g.
/// ```dart
/// DashSurveyBuilder(
/// );
/// ```
///
/// For the states [SurveyState.loading], [SurveyState.noSurveyAvailable] the
///  default builder will return a [SizedBox.shrink()].
///
/// For the state [SurveyState.activeSurvey] the builder will return the
/// survey widget.
///
/// For the state [SurveyState.surveySubmitted] the builder will return a
/// SurveyCompleted Message.
///
/// If you want to include the survey natively into your app you can customize
/// the builder to return a widget that fits your app.
/// E.g.
/// ```dart
/// DashSurveyBuilder(
///   surveyFrameBuilder: (BuildContext context, Widget surveyWidget, SurveyState surveyState) {
///     if(surveyState == SurveyState.showingSurvey) {
///       return Container(
///         decoration: BoxDecoration(
///           ...
///         ),
///         child: surveyWidget,
///       );
///     }
///     if(surveyState == SurveyState.loading)
///       return CircularLoadingIndicator();
///     return SizedBox.shrink();
///   },
/// );
/// ```
class DashSurveyBuilder extends StatefulWidget {
  /// Constructor
  const DashSurveyBuilder({
    this.builder,
    super.key,
    this.onSubmit,
    this.onCancel,
    this.transitionBuilder,
    this.transitionDuration,
    // this.viewId,
  });

  /// A builder that can be used to style the survey widget. Check the
  /// constructor docs for more information.
  final Widget Function(
    BuildContext context,
    Widget child,
    SurveyState surveyState,
  )? builder;

  /// A callback that is called when the survey is submitted.
  final void Function(SurveyModel survey)? onSubmit;

  /// A callback that is called when the survey is cancelled.
  /// Contains all answers that were given by the user until the survey was
  /// cancelled.
  final void Function(SurveyModel survey)? onCancel;

  /// A builder that is used to style the transition between the survey pages
  final AnimatedPageSwitcherTransitionBuilder? transitionBuilder;

  /// The duration of the transition between the survey pages
  final Duration? transitionDuration;

  @override
  State<DashSurveyBuilder> createState() => _DashSurveyBuilderState();
}

class _DashSurveyBuilderState extends State<DashSurveyBuilder> {
  /// Optional ID of the current view.
  /// This is used to display surveys in specific parts of your app.
  /// E.g. if you have a survey in a specific feature and only want to show it
  /// to users who are in that feature.
  ///
  /// If left empty, all surveys without a specified view id can be shown here.
  // final String? viewId;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      DashSurvey.of(context).getNextSurvey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = DashSurvey.of(context);
    // If the controller is disabled, return a SizedBox.shrink()
    if (controller is DisabledDashSurveyController) {
      return const SizedBox.shrink();
    }
    try {
      final surveyState = SurveyHolderState.of(context);

      return NotifierBuilder(
        notifier: surveyState,
        builder: (BuildContext context, SurveyHolderState notifier) {
          return widget.builder?.call(
                context,
                _SurveyBuilder(
                  surveyState: notifier,
                  transitionBuilder: widget.transitionBuilder,
                  transitionDuration: widget.transitionDuration,
                ),
                notifier.surveyState,
              ) ??
              _SurveyBuilder(
                surveyState: notifier,
                transitionBuilder: widget.transitionBuilder,
              );
        },
      );
    } catch (e) {
      log('Error in DashSurveyBuilder: $e');
      return const SizedBox.shrink();
    }
  }
}

class _SurveyBuilder extends StatefulWidget {
  const _SurveyBuilder({
    required this.surveyState,
    this.transitionBuilder,
    this.transitionDuration,
  });

  final SurveyHolderState surveyState;
  final AnimatedPageSwitcherTransitionBuilder? transitionBuilder;
  final Duration? transitionDuration;
  @override
  State<_SurveyBuilder> createState() => _SurveyBuilderState();
}

class _SurveyBuilderState extends State<_SurveyBuilder> {
  @override
  Widget build(BuildContext context) {
    switch (widget.surveyState.surveyState) {
      case SurveyState.loading:
        return const SizedBox.shrink();
      case SurveyState.noSurveyAvailable:
        return const SizedBox.shrink();
      case SurveyState.activeSurvey:
        if (widget.surveyState.survey == null) {
          return const SizedBox.shrink();
        }
        return SurveyPagerWrapper(
          survey: widget.surveyState.survey!,
          transitionBuilder: widget.transitionBuilder,
          transitionDuration: widget.transitionDuration,
        );
      case SurveyState.surveySubmitted:
        return SurveyPagerWrapper(
          survey: widget.surveyState.survey!,
          transitionBuilder: widget.transitionBuilder,
          transitionDuration: widget.transitionDuration,
        );
      case SurveyState.surveyClosed:
        return const SizedBox.shrink();
    }
  }
}

class SurveyPagerWrapper extends StatelessWidget {
  const SurveyPagerWrapper({
    required this.survey,
    this.transitionBuilder,
    this.transitionDuration,
    super.key,
  });

  final SurveyModel survey;
  final AnimatedPageSwitcherTransitionBuilder? transitionBuilder;
  final Duration? transitionDuration;

  @override
  Widget build(BuildContext context) {
    final locale =
        DashSurveyControllerImplementation.of(context).getLocaleCode();
    final state = SingleSurveyState(
      survey: survey,
      locale: locale,
    );
    return StateProvider<SingleSurveyState>(
      state: state,
      child: SurveyPager(
        survey: survey,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
      ),
    );
  }
}

class SurveyPager extends StatefulWidget {
  const SurveyPager({
    required this.survey,
    this.transitionBuilder,
    this.transitionDuration,
    super.key,
  });

  final SurveyModel survey;
  final AnimatedPageSwitcherTransitionBuilder? transitionBuilder;
  final Duration? transitionDuration;
  @override
  State<SurveyPager> createState() => _SurveyPagerState();
}

class _SurveyPagerState extends State<SurveyPager> {
  int pageIndex = 0;
  int previousPageIndex = 0;

  static Widget defaultTransitionBuilder(
    Widget child,
    bool isNext,
    Animation<double> animation,
  ) {
    // Create a custom curve that fades in faster than it slides
    final fadeAnimation = CurvedAnimation(
      parent: animation,
      // Using fastOutSlowIn for a quicker fade-in
      curve: Curves.fastOutSlowIn,
    );

    final slideAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(fadeAnimation),
      child: SlideTransition(
        position: Tween<Offset>(
          // Reduce the slide distance for a subtler effect
          begin: isNext ? const Offset(0.3, 0) : const Offset(-0.3, 0),
          end: Offset.zero,
        ).animate(slideAnimation),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final singleSurveyAnswerState =
        StateProvider.of<SingleSurveyState>(context);
    final locale = singleSurveyAnswerState.locale;
    final survey = singleSurveyAnswerState.survey;
    final lastQuestionIndex = survey.questions.length;
    return NotifierBuilder(
      notifier: singleSurveyAnswerState,
      builder: (context, notifier) {
        return AnimatedSwitcher(
          layoutBuilder: (currentChild, previousChildren) {
            return AnimatedSize(
              alignment: Alignment.topCenter,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              child: currentChild,
            );
          },
          transitionBuilder: (child, animation) {
            final isNext = pageIndex >= previousPageIndex;
            dashLogInfo(
              // ignore: lines_longer_than_80_chars
              'transitionBuilder: $widget.transitionBuilder, pageIndex: $pageIndex, previousPageIndex: $previousPageIndex, isNext: $isNext',
            );
            return widget.transitionBuilder?.call(
                  child: child,
                  isNext: isNext,
                  animation: animation,
                ) ??
                defaultTransitionBuilder(
                  child,
                  isNext,
                  animation,
                );
          },
          duration:
              widget.transitionDuration ?? const Duration(milliseconds: 380),
          child: pageIndex == 0
              ? SurveyIntroView(
                  key: const Key('page_0'),
                  title: survey.name.get(locale),
                  hasSkipButton: false,
                  description: survey.description?.get(locale),
                  onStart: () {
                    setState(() {
                      previousPageIndex = pageIndex;
                      pageIndex = 1;
                    });
                  },
                  onCancel: () {},
                )
              : pageIndex == lastQuestionIndex + 1
                  ? SurveyThankYouView(
                      key: Key('page_$pageIndex'),
                      survey: survey,
                      locale: locale,
                    )
                  : Align(
                      key: Key('page_$pageIndex'),
                      alignment: Alignment.topCenter,
                      child: SurveyQuestionPageView(
                        question: survey.questions[pageIndex - 1],
                        locale: locale,
                        onNext: () {
                          if (pageIndex == lastQuestionIndex) {
                            SingleSurveyState.submitSurvey(context);
                          }
                          setState(() {
                            previousPageIndex = pageIndex;
                            pageIndex++;
                          });
                        },
                        onPrevious: () {
                          setState(() {
                            previousPageIndex = pageIndex;
                            pageIndex--;
                          });
                        },
                      ),
                    ),
        );
      },
    );
  }
}
