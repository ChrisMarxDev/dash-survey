import 'package:flutter/material.dart';

class StateProvider<T extends ChangeNotifier> extends StatefulWidget {
  const StateProvider({
    required this.child,
    required this.state,
    super.key,
  });

  final Widget child;
  final T state;

  @override
  _StateProviderState<T> createState() => _StateProviderState<T>();

  /// Method to access the state
  static T of<T extends ChangeNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_InheritedState<T>>();
    assert(provider != null, 'No StateProvider found in context for type $T');
    return provider!.state;
  }

  /// Method to access the state
  static T? maybeOf<T extends ChangeNotifier>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_InheritedState<T>>();
    return provider?.state;
  }
}

class _StateProviderState<T extends ChangeNotifier>
    extends State<StateProvider<T>> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_onStateChange);
  }

  @override
  void dispose() {
    widget.state.removeListener(_onStateChange);
    widget.state.dispose();
    super.dispose();
  }

  void _onStateChange() {
    setState(() {}); // Trigger rebuilds for dependents
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedState<T>(
      state: widget.state,
      child: widget.child,
    );
  }
}

class _InheritedState<T extends ChangeNotifier> extends InheritedWidget {
  const _InheritedState({
    required super.child,
    required this.state,
    super.key,
  });

  final T state;

  @override
  bool updateShouldNotify(_InheritedState<T> oldWidget) {
    return oldWidget.state != state;
  }
}
