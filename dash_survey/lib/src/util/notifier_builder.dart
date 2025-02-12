import 'package:flutter/widgets.dart';

class NullableNotifierBuilder<T extends ChangeNotifier>
    extends StatelessWidget {
  const NullableNotifierBuilder({
    required this.notifier,
    required this.builder,
    super.key,
  });

  final T? notifier;
  final Widget Function(BuildContext context, T? notifier) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier ?? ValueNotifier(null),
      builder: (context, child) {
        return builder(context, notifier);
      },
    );
  }
}

class NotifierBuilder<T extends ChangeNotifier> extends StatelessWidget {
  const NotifierBuilder({
    required this.notifier,
    required this.builder,
    super.key,
  });

  final T notifier;
  final Widget Function(BuildContext context, T notifier) builder;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: notifier,
      builder: (context, child) {
        return builder(context, notifier);
      },
    );
  }
}
