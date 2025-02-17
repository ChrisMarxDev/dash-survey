// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// general theming for dash survey widgets
class DashSurveyTheme {
  const DashSurveyTheme({
    this.primaryColor,
    this.onPrimaryColor,
    this.disabledColor,
    this.onDisabledColor,
    this.containerShape,
    this.titleStyle,
    this.bodyStyle,
    this.buttonTextStyle,
    this.interactiveElementShape,
    this.interactiveElementShadows,
  });

  /// primary color used for most accentuated componenets
  /// examples include buttons, slider, checkboxes
  final Color? primaryColor;

  /// text color for primary components
  final Color? onPrimaryColor;

  /// disabled color for most components
  final Color? disabledColor;

  /// text color for disabled components
  final Color? onDisabledColor;

  /// border radius for most buttons
  final ShapeBorder? interactiveElementShape;

  /// border radius for most cards and containers
  final ShapeBorder? containerShape;

  /// text style for survey and question titles
  final TextStyle? titleStyle;

  /// text style for all body texts in the survey
  final TextStyle? bodyStyle;

  /// text style for all texts in buttons
  final TextStyle? buttonTextStyle;

  /// list of box shadows for all interactive elements
  final List<BoxShadow>? interactiveElementShadows;

  /// create a dash survey theme from a theme data
  static DashSurveyTheme fromThemeData(ThemeData theme) {
    return DashSurveyTheme(
      primaryColor: theme.colorScheme.primary,
      onPrimaryColor: theme.colorScheme.onPrimary,
      disabledColor: theme.colorScheme.onSurface,
      onDisabledColor: theme.colorScheme.onSurface,
      containerShape: theme.cardTheme.shape,
      interactiveElementShape:
          theme.elevatedButtonTheme.style?.shape?.resolve({}),
      titleStyle: theme.textTheme.titleLarge,
      bodyStyle: theme.textTheme.bodyMedium,
      buttonTextStyle: theme.textTheme.labelLarge,
      interactiveElementShadows: [
        BoxShadow(
          color: theme.shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  DashSurveyTheme copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    BorderRadius? containerRadius,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? buttonStyle,
    ShapeBorder? interactiveElementShape,
    List<BoxShadow>? interactiveElementShadows,
  }) {
    return DashSurveyTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? onPrimaryColor,
      disabledColor: disabledColor ?? disabledColor,
      onDisabledColor: onDisabledColor ?? onDisabledColor,
      containerShape: containerShape ?? containerShape,
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      buttonTextStyle: buttonStyle ?? buttonTextStyle,
      interactiveElementShape:
          interactiveElementShape ?? this.interactiveElementShape,
      interactiveElementShadows:
          interactiveElementShadows ?? this.interactiveElementShadows,
    );
  }
}
