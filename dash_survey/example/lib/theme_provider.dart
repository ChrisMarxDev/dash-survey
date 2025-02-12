import 'package:flutter/material.dart';

/// Provider widget that holds the current theme data
class ThemeProvider extends InheritedWidget {
  const ThemeProvider({
    required super.child,
    required this.themeData,
    required this.updateTheme,
    super.key,
  });

  /// The current theme data
  final ThemeData themeData;

  /// Callback to update the theme
  final ValueChanged<ThemeData> updateTheme;

  /// Get the current theme provider from the context
  static ThemeProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    assert(
      provider != null,
      'No ThemeProvider found in context',
    );
    return provider!;
  }

  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return oldWidget.themeData != themeData;
  }
}

/// A widget that rebuilds when the theme changes
class ThemeConsumer extends StatelessWidget {
  const ThemeConsumer({
    required this.builder,
    super.key,
  });

  /// Builder function that provides the current theme data
  final Widget Function(BuildContext context, ThemeData theme) builder;

  @override
  Widget build(BuildContext context) {
    final provider = ThemeProvider.of(context);
    return builder(context, provider.themeData);
  }
}

/// Example usage of how to set up the theme provider at the root
class ThemeRoot extends StatefulWidget {
  const ThemeRoot({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<ThemeRoot> createState() => _ThemeRootState();
}

class _ThemeRootState extends State<ThemeRoot> {
  ThemeData _themeData = ThemeData.light();

  void _updateTheme(ThemeData newTheme) {
    setState(() {
      _themeData = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      themeData: _themeData,
      updateTheme: _updateTheme,
      child: widget.child,
    );
  }
}
