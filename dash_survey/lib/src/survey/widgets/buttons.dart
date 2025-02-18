import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({required this.child, super.key, this.onPressed});

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
