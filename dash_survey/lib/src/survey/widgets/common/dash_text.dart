import 'package:dash_survey/dash_survey.dart';
import 'package:flutter/widgets.dart';

/// Enum defining the different types of text styles available in the survey
enum DashTextType {
  /// Title text style, used for survey and question titles
  title,

  /// Body text style, used for general text content
  body,

  /// Label text style, used for form labels and small text
  label,

  /// Button text style, used for text in buttons
  button,
}

/// A widget that displays text with styling based on the survey theme
///
/// This widget automatically applies the appropriate text style from the
/// [DashSurveyTheme] based on the [type] parameter.
class DashText extends StatelessWidget {
  /// Creates a [DashText] widget with the given text and type
  const DashText._(
    this.text, {
    this.type = DashTextType.body,
    this.color,
  });

  /// Creates a [DashText] widget with title styling
  ///
  /// This factory constructor creates a [DashText] with [DashTextType.title]
  factory DashText.title(String text, {Color? color}) =>
      DashText._(text, type: DashTextType.title, color: color);

  /// Creates a [DashText] widget with body styling
  ///
  /// This factory constructor creates a [DashText] with [DashTextType.body]
  factory DashText.body(String text, {Color? color}) =>
      DashText._(text, color: color);

  /// Creates a [DashText] widget with label styling
  ///
  /// This factory constructor creates a [DashText] with [DashTextType.label]
  factory DashText.label(String text, {Color? color}) =>
      DashText._(text, type: DashTextType.label, color: color);

  /// Creates a [DashText] widget with button styling
  ///
  /// This factory constructor creates a [DashText] with [DashTextType.button]
  factory DashText.button(String text, {Color? color}) =>
      DashText._(text, type: DashTextType.button, color: color);

  /// The text to display
  final String text;

  /// The type of text to display, which determines the style applied
  ///
  /// Defaults to [DashTextType.body]
  final DashTextType type;

  /// Optional color override for the text
  ///
  /// If provided, this color will override the color from the theme text style
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    final textStyle = switch (type) {
      DashTextType.title => theme.titleTextStyle,
      DashTextType.body => theme.bodyTextStyle,
      DashTextType.label => theme.labelTextStyle,
      DashTextType.button => theme.buttonTextStyle,
    };

    return Text(
      text,
      style: textStyle.copyWith(color: color),
    );
  }
}
