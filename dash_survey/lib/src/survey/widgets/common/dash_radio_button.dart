import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

class DashRadioButton<T> extends StatelessWidget {
  const DashRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.focusNode,
    this.autofocus = false,
    this.fillColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final FocusNode? focusNode;
  final bool autofocus;
  final WidgetStateProperty<Color?>? fillColor;
  final WidgetStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final MaterialTapTargetSize? materialTapTargetSize;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;

    final effectiveFillColor = fillColor ??
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return activeColor ?? theme.primaryColor;
          }
          if (states.contains(WidgetState.disabled)) {
            return theme.disabledColor;
          }
          return theme.primaryColor;
        });

    final effectiveOverlayColor = overlayColor ??
        WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return theme.primaryColor.withValues(alpha: .12);
          }
          if (states.contains(WidgetState.hovered)) {
            return theme.primaryColor.withValues(alpha: .08);
          }
          return null;
        });

    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor ?? theme.primaryColor,
      focusNode: focusNode,
      autofocus: autofocus,
      fillColor: effectiveFillColor,
      overlayColor: effectiveOverlayColor,
      splashRadius: splashRadius ?? 24,
      materialTapTargetSize:
          materialTapTargetSize ?? MaterialTapTargetSize.shrinkWrap,
      visualDensity: visualDensity ?? VisualDensity.compact,
    );
  }
}
