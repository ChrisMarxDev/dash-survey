import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

class DashCheckbox extends StatelessWidget {
  const DashCheckbox({
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    super.key,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlinedBorder? shape;
  final BorderSide? side;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: activeColor ?? theme.primaryColor,
      checkColor: checkColor ?? theme.onPrimaryColor,
      focusNode: focusNode,
      autofocus: autofocus,
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: side,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
