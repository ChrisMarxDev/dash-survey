import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';

/// A card widget that follows the dash survey theme.
///
/// This card uses the interactive element styling from the theme,
/// including background color, shape, and hover effects.
class DashCard extends StatelessWidget {
  /// Creates a new instance of [DashCard].
  const DashCard({
    required this.child,
    super.key,
    this.onTap,
    this.onHover,
  });

  /// The widget to display inside the card.
  final Widget child;

  /// Callback function called when the card is hovered.
  ///
  /// The [isHover] parameter indicates whether the card is being hovered (true)
  /// or the hover has ended (false).
  final void Function(bool isHover)? onHover;

  /// Callback function called when the card is tapped.
  final void Function()? onTap;

  /// Default padding for the card content.
  static const _defaultPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    final theme = context.dashSurveyTheme;
    final shape = theme.interactiveElementShape;
    return Container(
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: theme.interactiveElementBackgroundColor,
        shape: shape,
      ),
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        onHover: onHover,
        child: Padding(
          padding: _defaultPadding,
          child: child,
        ),
      ),
    );
  }
}
