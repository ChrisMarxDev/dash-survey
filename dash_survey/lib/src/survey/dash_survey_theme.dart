// ignore_for_file: public_member_api_docs

import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/material.dart';

const _defaultPrimaryColor = Color(0xff1c63f2);
const _defaultBorderColor = Color(0xFFe2e8f0);
const _defaultOnPrimaryColor = Colors.white;
const _defaultDisabledColor = Color(0xFFE2E8F0);
const _defaultOnDisabledColor = Color(0xFF94A3B8);
const _defaultBackgroundColor = Colors.white;
const _defaultOnBackgroundColor = Color(0xFF1E293B);
const _defaultInteractiveElementBackgroundColor = Colors.white;
const _defaultInteractiveElementShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  side: BorderSide(color: _defaultBorderColor),
);
const _defaultTitleTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const _defaultBodyTextStyle = TextStyle(
  fontSize: 14,
);

const _defaultLabelTextStyle = TextStyle(
  fontSize: 12,
  color: Color(0xFF64748B),
);

const _defaultButtonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const _defaultTextInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(color: _defaultBorderColor),
);

const _defaultButtonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 8);

const _defaultButtonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  side: BorderSide(color: _defaultBorderColor),
);

/// Theme data for the dash survey package.
///
/// This class provides a comprehensive theming system for the dash survey package,
/// allowing customization of colors, text styles, shapes, and other visual elements.
/// It can either use its own theme values or merge with the Material theme.
class DashSurveyThemeData {
  /// Creates a new instance of [DashSurveyThemeData].
  ///
  /// All parameters are optional and will fall back to default values if not provided.
  /// If [useMaterialTheme] is true, the theme will merge with the Material theme
  /// of the current context, with dash survey theme values taking precedence.
  const DashSurveyThemeData({
    this.useMaterialTheme = true,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? disabledColor,
    Color? onDisabledColor,
    Color? backgroundColor,
    Color? onBackgroundColor,
    Color? interactiveElementBackgroundColor,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? labelStyle,
    TextStyle? buttonTextStyle,
    ShapeBorder? interactiveElementShape,
    List<BoxShadow>? interactiveElementShadows,
    Color? baseBorderColor = _defaultBorderColor,
    OutlinedBorder? buttonShape,
    InputBorder? textInputBorder,
    EdgeInsets? buttonPadding,
  })  : _primaryColor = primaryColor,
        _onPrimaryColor = onPrimaryColor,
        _disabledColor = disabledColor,
        _onDisabledColor = onDisabledColor,
        _backgroundColor = backgroundColor,
        _onBackgroundColor = onBackgroundColor,
        _interactiveElementBackgroundColor = interactiveElementBackgroundColor,
        _titleTextStyle = titleStyle,
        _bodyTextStyle = bodyStyle,
        _labelTextStyle = labelStyle,
        _buttonTextStyle = buttonTextStyle,
        _interactiveElementShape = interactiveElementShape,
        _interactiveElementShadows = interactiveElementShadows,
        _baseBorderColor = baseBorderColor,
        _buttonShape = buttonShape,
        _textInputBorder = textInputBorder,
        _buttonPadding = buttonPadding;

  /// If true, the theme will use the material theme of this context.
  /// When using the material theme, it will use a merged theme of the material
  /// theme and the given dash survey theme.
  /// Any style defined in the dash survey theme will override the material theme.
  final bool useMaterialTheme;

  final Color? _primaryColor;
  final Color? _onPrimaryColor;
  final Color? _disabledColor;
  final Color? _onDisabledColor;
  final Color? _backgroundColor;
  final Color? _onBackgroundColor;
  final Color? _interactiveElementBackgroundColor;
  final TextStyle? _titleTextStyle;
  final TextStyle? _bodyTextStyle;
  final TextStyle? _labelTextStyle;
  final TextStyle? _buttonTextStyle;
  final ShapeBorder? _interactiveElementShape;
  final List<BoxShadow>? _interactiveElementShadows;
  final Color? _baseBorderColor;
  final OutlinedBorder? _buttonShape;
  final InputBorder? _textInputBorder;
  final EdgeInsets? _buttonPadding;

  /// Primary color used for most accentuated components.
  /// Examples include buttons, slider, checkboxes.
  Color get primaryColor => _primaryColor ?? _defaultPrimaryColor;

  /// Text color for primary components.
  Color get onPrimaryColor => _onPrimaryColor ?? _defaultOnPrimaryColor;

  /// Disabled color for most components.
  Color get disabledColor => _disabledColor ?? _defaultDisabledColor;

  /// Text color for disabled components.
  Color get onDisabledColor => _onDisabledColor ?? _defaultOnDisabledColor;

  /// Background color of all survey elements.
  /// This is the background color of the [DashSurveyBuilder] but
  /// also the background color of the [DashSurveyController.showNextSurvey]
  /// modal bottom sheet.
  Color get backgroundColor => _backgroundColor ?? _defaultBackgroundColor;

  /// Neutral color of elements on the background color.
  /// This is the text color of elements on the background color if no text
  /// color is set in the [titleTextStyle] or [bodyStyle].
  /// This is mostly a fallback color.
  Color get onBackgroundColor =>
      _onBackgroundColor ?? _defaultOnBackgroundColor;

  /// Text style for survey and question titles.
  TextStyle get titleTextStyle => _titleTextStyle ?? _defaultTitleTextStyle;

  /// Text style for all body texts in the survey.
  TextStyle get bodyTextStyle => _bodyTextStyle ?? _defaultBodyTextStyle;

  /// Text style for labels and small text.
  TextStyle get labelTextStyle => _labelTextStyle ?? _defaultLabelTextStyle;

  /// Text style for all texts in buttons.
  TextStyle get buttonTextStyle => _buttonTextStyle ?? _defaultButtonTextStyle;

  /// List of box shadows for all interactive elements.
  List<BoxShadow>? get interactiveElementShadows => _interactiveElementShadows;

  /// Shape of most interactive elements.
  /// This is used for selectable list tiles in multiple choice questions.
  ShapeBorder get interactiveElementShape =>
      _interactiveElementShape ?? _defaultInteractiveElementShape;

  /// Shape for buttons.
  OutlinedBorder get buttonShape => _buttonShape ?? _defaultButtonShape;

  /// Background color for interactive elements.
  Color get interactiveElementBackgroundColor =>
      _interactiveElementBackgroundColor ??
      _defaultInteractiveElementBackgroundColor;

  /// Border color for all interactive elements.
  Color get baseBorderColor => _baseBorderColor ?? _defaultBorderColor;

  /// Border for text input fields.
  InputBorder get textInputBorder =>
      _textInputBorder ?? _defaultTextInputBorder;

  /// Padding for buttons.
  EdgeInsets get buttonPadding => _buttonPadding ?? _defaultButtonPadding;

  /// Creates a dash survey theme from a Material theme data.
  static DashSurveyThemeData fromThemeData(ThemeData theme) {
    return DashSurveyThemeData(
      primaryColor: theme.colorScheme.primary,
      onPrimaryColor: theme.colorScheme.onPrimary,
      disabledColor: theme.colorScheme.onSurface,
      onDisabledColor: theme.colorScheme.onSurface,
      interactiveElementShape: theme.cardTheme.shape,
      interactiveElementBackgroundColor: theme.cardTheme.color,
      titleStyle: theme.textTheme.titleMedium,
      bodyStyle: theme.textTheme.bodyMedium,
      labelStyle: theme.textTheme.labelSmall,
      buttonTextStyle: theme.textTheme.labelLarge,
      backgroundColor: theme.colorScheme.surface,
      onBackgroundColor: theme.colorScheme.onSurface,
      buttonShape: theme.filledButtonTheme.style?.shape?.resolve({}),
      textInputBorder: theme.inputDecorationTheme.border,
      interactiveElementShadows: [
        BoxShadow(
          color: theme.shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  /// Creates a copy of this theme with the given fields replaced with the new values.
  DashSurveyThemeData copyWith({
    bool? useMaterialTheme,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? disabledColor,
    Color? onDisabledColor,
    Color? backgroundColor,
    Color? onBackgroundColor,
    Color? interactiveElementBackgroundColor,
    TextStyle? titleStyle,
    TextStyle? bodyStyle,
    TextStyle? labelStyle,
    TextStyle? buttonTextStyle,
    ShapeBorder? interactiveElementShape,
    List<BoxShadow>? interactiveElementShadows,
    Color? baseBorderColor,
    OutlinedBorder? buttonShape,
    InputBorder? textInputBorder,
    EdgeInsets? buttonPadding,
  }) {
    return DashSurveyThemeData(
      useMaterialTheme: useMaterialTheme ?? this.useMaterialTheme,
      primaryColor: primaryColor ?? _primaryColor,
      onPrimaryColor: onPrimaryColor ?? _onPrimaryColor,
      disabledColor: disabledColor ?? _disabledColor,
      onDisabledColor: onDisabledColor ?? _onDisabledColor,
      backgroundColor: backgroundColor ?? _backgroundColor,
      onBackgroundColor: onBackgroundColor ?? _onBackgroundColor,
      interactiveElementBackgroundColor: interactiveElementBackgroundColor ??
          _interactiveElementBackgroundColor,
      titleStyle: titleStyle ?? _titleTextStyle,
      bodyStyle: bodyStyle ?? _bodyTextStyle,
      labelStyle: labelStyle ?? _labelTextStyle,
      buttonTextStyle: buttonTextStyle ?? _buttonTextStyle,
      interactiveElementShape:
          interactiveElementShape ?? _interactiveElementShape,
      interactiveElementShadows:
          interactiveElementShadows ?? _interactiveElementShadows,
      baseBorderColor: baseBorderColor ?? _baseBorderColor,
      buttonShape: buttonShape ?? _buttonShape,
      textInputBorder: textInputBorder ?? _textInputBorder,
      buttonPadding: buttonPadding ?? _buttonPadding,
    );
  }

  /// Merges this theme with another theme.
  /// Values from the other theme take precedence over this theme's values.
  DashSurveyThemeData merge(DashSurveyThemeData other) {
    return DashSurveyThemeData(
      useMaterialTheme: other.useMaterialTheme,
      primaryColor: other._primaryColor ?? _primaryColor,
      onPrimaryColor: other._onPrimaryColor ?? _onPrimaryColor,
      disabledColor: other._disabledColor ?? _disabledColor,
      onDisabledColor: other._onDisabledColor ?? _onDisabledColor,
      backgroundColor: other._backgroundColor ?? _backgroundColor,
      onBackgroundColor: other._onBackgroundColor ?? _onBackgroundColor,
      interactiveElementBackgroundColor:
          other._interactiveElementBackgroundColor ??
              _interactiveElementBackgroundColor,
      titleStyle: other._titleTextStyle ?? _titleTextStyle,
      bodyStyle: other._bodyTextStyle ?? _bodyTextStyle,
      labelStyle: other._labelTextStyle ?? _labelTextStyle,
      buttonTextStyle: other._buttonTextStyle ?? _buttonTextStyle,
      interactiveElementShape:
          other._interactiveElementShape ?? _interactiveElementShape,
      interactiveElementShadows:
          other._interactiveElementShadows ?? _interactiveElementShadows,
      baseBorderColor: other._baseBorderColor ?? _baseBorderColor,
      buttonShape: other._buttonShape ?? _buttonShape,
      textInputBorder: other._textInputBorder ?? _textInputBorder,
      buttonPadding: other._buttonPadding ?? _buttonPadding,
    );
  }
}

/// Extension on BuildContext to provide easy access to dash survey theme values.
extension DashSurveyThemeContextExtension on BuildContext {
  /// Extra small padding (4 logical pixels).
  double get pXs => 4;

  /// Small padding (8 logical pixels).
  double get pS => 8;

  /// Medium padding (16 logical pixels).
  double get pM => 16;

  /// Large padding (24 logical pixels).
  double get pL => 24;

  /// Extra large padding (32 logical pixels).
  double get pXl => 32;

  /// Double extra large padding (40 logical pixels).
  double get pXxl => 40;

  /// Triple extra large padding (48 logical pixels).
  double get pXxxl => 48;

  /// Transparent color.
  Color get transparentColor => Colors.transparent;

  /// The dash survey theme data for this context.
  DashSurveyThemeData get dashSurveyTheme => DashSurveyTheme.of(this);
}

/// Provides a dash survey theme to the widget tree.
class DashSurveyTheme extends InheritedWidget {
  /// Creates a new instance of [DashSurveyTheme].
  const DashSurveyTheme({
    required super.child,
    required this.theme,
    super.key,
  });

  /// The theme data to provide to the widget tree.
  final DashSurveyThemeData theme;

  @override
  bool updateShouldNotify(DashSurveyTheme oldWidget) =>
      theme != oldWidget.theme;

  /// Returns the dash survey theme data from the closest [DashSurveyTheme] ancestor.
  static DashSurveyThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<DashSurveyTheme>()!.theme;
    if (theme.useMaterialTheme) {
      return DashSurveyThemeData.fromThemeData(Theme.of(context)).merge(theme);
    }
    return theme;
  }
}
