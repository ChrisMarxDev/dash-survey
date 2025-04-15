import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/widgets.dart';

/// A helper widget to create a button that triggers a survey modal bottom sheet.
///
/// example usage:
/// ```dart
/// DashSurveyButtonBuilder(
///   buttonBuilder: (context, onTap) => ElevatedButton(
///     onPressed: onTap,
///     child: child,
///   ),
/// )
class DashSurveyButtonBuilder extends StatefulWidget {
  /// Constructor
  const DashSurveyButtonBuilder({
    required this.buttonBuilder,
    super.key,
  });

  /// A builder that can be used to style the survey widget. Check the
  /// constructor docs for more information.
  final Widget Function(
    BuildContext context,
    VoidCallback openSurvey,
  ) buttonBuilder;

  @override
  State<DashSurveyButtonBuilder> createState() =>
      _DashSurveyButtonBuilderState();
}

class _DashSurveyButtonBuilderState extends State<DashSurveyButtonBuilder> {
  @override
  Widget build(BuildContext context) {
    return DashSurveyBuilder(
      builder: (context, survey, surveyState) {
        if (surveyState == SurveyState.activeSurvey) {
          return widget.buttonBuilder(
            context,
            () {
              DashSurvey.of(context).showNextSurvey();
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
