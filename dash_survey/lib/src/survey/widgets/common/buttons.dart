import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

/// Main button, uses and replaces the default [FilledButton]
class MainButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const MainButton({required this.child, super.key, this.onPressed});

  /// The child of the button
  final Widget child;

  /// The onPressed callback
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.onPrimaryColor,
        disabledBackgroundColor: theme.disabledColor,
        disabledForegroundColor: theme.onDisabledColor,
        textStyle: theme.buttonTextStyle,
        shape: theme.buttonShape,
        padding: theme.buttonPadding,
      ),
      child: child,
    );
  }
}

/// Tertiary button, uses and replaces the default [TextButton]
class TertiaryButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const TertiaryButton({required this.child, super.key, this.onPressed});

  /// The child of the button
  final Widget child;

  /// The onPressed callback
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
        disabledBackgroundColor: theme.disabledColor,
        disabledForegroundColor: theme.onDisabledColor,
        textStyle: theme.buttonTextStyle,
        shape: theme.buttonShape,
        padding: theme.buttonPadding,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

/// Secondary button, uses and replaces the default [OutlinedButton]
class SecondaryButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const SecondaryButton({required this.child, super.key, this.onPressed});

  /// The child of the button
  final Widget child;

  /// The onPressed callback
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
        disabledBackgroundColor: theme.disabledColor,
        disabledForegroundColor: theme.onDisabledColor,
        textStyle: theme.buttonTextStyle,
        shape: theme.buttonShape,
        padding: theme.buttonPadding,
        side: BorderSide(color: theme.primaryColor),
      ),
      child: child,
    );
  }
}
