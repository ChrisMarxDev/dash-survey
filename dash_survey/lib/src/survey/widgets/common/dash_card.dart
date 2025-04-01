import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashCard extends StatelessWidget {
  const DashCard({required this.child, super.key, this.onTap, this.onHover});

  final Widget child;
  final void Function(bool isHover)? onHover;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final shape = theme.cardElementShape ??
        const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
          ),
        );
    return Container(
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: theme.cardElementBackgroundColor,
        shape: shape,
      ),
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        onHover: onHover,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
