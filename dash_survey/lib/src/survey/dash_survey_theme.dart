// ignore_for_file: public_member_api_docs

import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

const _defaultPrimaryColor = Color(0xff1c63f2);
const _defaultBorderColor = Color(0xFFe2e8f0);

/// general theming for dash survey widgets
class DashSurveyThemeData {
  const DashSurveyThemeData({
    Color? primaryColor,
    this.onPrimaryColor,
    this.disabledColor,
    this.onDisabledColor,
    this.backgroundColor,
    this.onBackgroundColor,
    this.cardElementBackgroundColor,
    this.titleStyle,
    this.bodyStyle,
    this.buttonTextStyle,
    this.cardElementShape,
    this.cardElementShadows,
    this.baseBorderColor = _defaultBorderColor,
    this.useMaterialTheme = true,
  }) : _primaryColor = primaryColor;

  /// if true, the theme will use the material theme of this context
  /// when using the material theme, it will use a merged theme of the material
  /// theme and the given dash survey theme
  /// any style defined in the dash survey theme will override the material theme
  final bool useMaterialTheme;

  /// primary color used for most accentuated componenets
  /// examples include buttons, slider, checkboxes
  final Color? _primaryColor;

  Color get primaryColor => _primaryColor ?? _defaultPrimaryColor;

  /// text color for primary components
  final Color? onPrimaryColor;

  /// disabled color for most components
  final Color? disabledColor;

  /// text color for disabled components
  final Color? onDisabledColor;

  /// background color of all survey elements
  /// this is the background color of the [DashSurveyBuilder] but
  /// also the background color of the [DashSurveyController.showNextSurvey]
  /// modal bottom sheet
  final Color? backgroundColor;

  /// neutral color of elements on the background color
  /// this is the text color of elements on the background color if no text
  /// color is set in the [titleStyle] or [bodyStyle]
  /// this is mostly a fallback color
  final Color? onBackgroundColor;

  /// text style for survey and question titles
  final TextStyle? titleStyle;

  /// text style for all body texts in the survey
  final TextStyle? bodyStyle;

  /// text style for all texts in buttons
  final TextStyle? buttonTextStyle;

  /// list of box shadows for all interactive card elements
  final List<BoxShadow>? cardElementShadows;

  /// shape of most interactive card elements
  /// this is used for selectable list tiles in multiple choice questions
  final ShapeBorder? cardElementShape;

  /// background color for interactive card elements
  final Color? cardElementBackgroundColor;

  /// border color for all interactive elements
  final Color? baseBorderColor;

  /// create a dash survey theme from a theme data
  static DashSurveyThemeData fromThemeData(ThemeData theme) {
    return DashSurveyThemeData(
      primaryColor: theme.colorScheme.primary,
      onPrimaryColor: theme.colorScheme.onPrimary,
      disabledColor: theme.colorScheme.onSurface,
      onDisabledColor: theme.colorScheme.onSurface,
      cardElementShape: theme.cardTheme.shape,
      cardElementBackgroundColor: theme.cardTheme.color,
      titleStyle: theme.textTheme.titleMedium,
      bodyStyle: theme.textTheme.bodyMedium,
      buttonTextStyle: theme.textTheme.labelLarge,
      backgroundColor: theme.colorScheme.surface,
      onBackgroundColor: theme.colorScheme.onSurface,
      cardElementShadows: [
        BoxShadow(
          color: theme.shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  DashSurveyThemeData copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    BorderRadius? containerRadius,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? buttonStyle,
    ShapeBorder? interactiveElementShape,
    List<BoxShadow>? interactiveElementShadows,
  }) {
    return DashSurveyThemeData(
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimaryColor: onPrimaryColor ?? onPrimaryColor,
      disabledColor: disabledColor ?? disabledColor,
      onDisabledColor: onDisabledColor ?? onDisabledColor,
      titleStyle: titleStyle ?? this.titleStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      buttonTextStyle: buttonStyle ?? buttonTextStyle,
      cardElementShape: interactiveElementShape ?? cardElementShape,
      cardElementShadows: interactiveElementShadows ?? cardElementShadows,
    );
  }

  DashSurveyThemeData merge(DashSurveyThemeData other) {
    return DashSurveyThemeData(
      primaryColor: other.primaryColor,
      onPrimaryColor: other.onPrimaryColor ?? onPrimaryColor,
      disabledColor: other.disabledColor ?? disabledColor,
      onDisabledColor: other.onDisabledColor ?? onDisabledColor,
      cardElementShape: other.cardElementShape ?? cardElementShape,
      cardElementShadows: other.cardElementShadows ?? cardElementShadows,
      titleStyle: other.titleStyle ?? titleStyle,
      bodyStyle: other.bodyStyle ?? bodyStyle,
      buttonTextStyle: other.buttonTextStyle ?? buttonTextStyle,
    );
  }
}

extension DashSurveyThemeContextExtension on BuildContext {
  double get pXs => 4;
  double get pS => 8;
  double get pM => 16;
  double get pL => 24;
  double get pXl => 32;
  double get pXxl => 40;
  double get pXxxl => 48;

  Color get transparentColor => Colors.transparent;

  DashSurveyThemeData get theme => DashSurveyTheme.of(this);
}

/// provides a dash survey theme to the widget tree
class DashSurveyTheme extends InheritedWidget {
  const DashSurveyTheme({
    required super.child,
    required this.theme,
    super.key,
  });

  final DashSurveyThemeData theme;

  @override
  bool updateShouldNotify(DashSurveyTheme oldWidget) =>
      theme != oldWidget.theme;

  static DashSurveyThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<DashSurveyTheme>()!.theme;
    if (theme.useMaterialTheme) {
      return DashSurveyThemeData.fromThemeData(Theme.of(context)).merge(theme);
    }
    return theme;
  }
}
