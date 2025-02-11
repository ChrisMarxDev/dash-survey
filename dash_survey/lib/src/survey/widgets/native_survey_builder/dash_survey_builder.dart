import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/survey/logic/dash_survey_controller/dash_survey_controller.dart';
import 'package:flutter/material.dart';

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
/// For the state [SurveyState.showingSurvey] the builder will return the
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
class DashSurveyBuilder extends StatelessWidget {
  /// Constructor
  const DashSurveyBuilder({
    this.surveyFrameBuilder,
    super.key,
    this.onSubmit,
    this.onCancel,
    this.demoMode = false,
  });

  /// A builder that can be used to style the survey widget. Check the
  /// constructor docs for more information.
  final Widget Function(
    BuildContext context,
    Widget surveyWidget,
    SurveyState surveyState,
  )? surveyFrameBuilder;

  /// A callback that is called when the survey is submitted.
  final void Function(SurveyModel survey)? onSubmit;

  /// A callback that is called when the survey is cancelled.
  /// Contains all answers that were given by the user until the survey was
  /// cancelled.
  final void Function(SurveyModel survey)? onCancel;

  /// If true, a demo survey will be shown.
  /// Use this to style and test the survey builder without having to create a
  /// survey.
  final bool demoMode;

  @override
  Widget build(BuildContext context) {
    final surveyState = DashSurvey.of(context).surveyState;

    return surveyFrameBuilder?.call(
          context,
          _SurveyBuilder(surveyState: surveyState),
          surveyState,
        ) ??
        _SurveyBuilder(surveyState: surveyState);
  }
}

class _SurveyBuilder extends StatefulWidget {
  const _SurveyBuilder({
    required this.surveyState,
    super.key,
  });

  final SurveyState surveyState;

  @override
  State<_SurveyBuilder> createState() => _SurveyBuilderState();
}

class _SurveyBuilderState extends State<_SurveyBuilder> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
