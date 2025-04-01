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
    return FilledButton(
      onPressed: onPressed,
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
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: context.theme.backgroundColor,
        foregroundColor: context.theme.onBackgroundColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
