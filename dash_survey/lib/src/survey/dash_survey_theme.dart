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

  DashSurveyTheme merge(DashSurveyTheme other) {
    return DashSurveyTheme(
      primaryColor: other.primaryColor ?? primaryColor,
      onPrimaryColor: other.onPrimaryColor ?? onPrimaryColor,
      disabledColor: other.disabledColor ?? disabledColor,
      onDisabledColor: other.onDisabledColor ?? onDisabledColor,
      containerShape: other.containerShape ?? containerShape,
      interactiveElementShape:
          other.interactiveElementShape ?? interactiveElementShape,
      interactiveElementShadows:
          other.interactiveElementShadows ?? interactiveElementShadows,
      titleStyle: other.titleStyle ?? titleStyle,
      bodyStyle: other.bodyStyle ?? bodyStyle,
      buttonTextStyle: other.buttonTextStyle ?? buttonTextStyle,
    );
  }

  static DashSurveyTheme of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DashSurveyThemeProvider>()!
        .theme;
  }

  // DashSurveyTheme lerp(DashSurveyTheme other, double t) {
  //   return DashSurveyTheme(
  //     primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
  //     onPrimaryColor: Color.lerp(onPrimaryColor, other.onPrimaryColor, t),
  //     disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
  //     onDisabledColor: Color.lerp(onDisabledColor, other.onDisabledColor, t),
  //     containerShape: ShapeBorder.lerp(containerShape, other.containerShape, t),
  //     titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
  //     bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t),
  //     buttonTextStyle:
  //         TextStyle.lerp(buttonTextStyle, other.buttonTextStyle, t),
  //     interactiveElementShape: ShapeBorder.lerp(
  //       interactiveElementShape,
  //       other.interactiveElementShape,
  //       t,
  //     ),
  //     interactiveElementShadows: [
  //       if (interactiveElementShadows != null &&
  //           interactiveElementShadows!.isNotEmpty &&
  //           other.interactiveElementShadows != null &&
  //           other.interactiveElementShadows!.isNotEmpty)
  //         BoxShadow.lerp(
  //           interactiveElementShadows!.first,
  //           other.interactiveElementShadows!.first,
  //           t,
  //         )!,
  //     ],
  //   );
  // }
}

extension DashSurveyThemeContextExtension on BuildContext {
  double get pXs => 4;
  double get pS => 8;
  double get pM => 16;
  double get pL => 24;
  double get pXl => 32;
  double get pXxl => 40;
  double get pXxxl => 48;
}

class DashSurveyThemeProviderWrapper extends StatelessWidget {
  const DashSurveyThemeProviderWrapper({
    required this.child,
    required this.theme,
    super.key,
    this.useMaterialTheme = true,
  });

  final DashSurveyTheme theme;
  final bool useMaterialTheme;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final mergedTheme = useMaterialTheme
        ? DashSurveyTheme.fromThemeData(
            Theme.of(
              context,
            ),
          ).merge(theme)
        : theme;
    return DashSurveyThemeProvider(
      theme: mergedTheme,
      child: child,
    );
  }
}

/// provides a dash survey theme to the widget tree
class DashSurveyThemeProvider extends InheritedWidget {
  const DashSurveyThemeProvider({
    required super.child,
    required this.theme,
    super.key,
  });

  final DashSurveyTheme theme;

  @override
  bool updateShouldNotify(DashSurveyThemeProvider oldWidget) =>
      theme != oldWidget.theme;
}
