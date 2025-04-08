import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

class DashCheckbox extends StatelessWidget {
  const DashCheckbox({
    required this.value,
    required this.onChanged,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;

    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: theme.primaryColor,
      checkColor: theme.onPrimaryColor,
      focusNode: focusNode,
      autofocus: autofocus,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      side: BorderSide(width: 2, color: theme.primaryColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
