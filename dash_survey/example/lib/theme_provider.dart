import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  ThemeData _themeData = ThemeHolder.getTheme(AppTheme.modernMinimal);

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

enum AppTheme {
  modernMinimal,
  luxuryClassic,
  playfulBold,
}

class ThemeHolder {
  static ThemeData getTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.modernMinimal:
        return _modernMinimalTheme;
      case AppTheme.luxuryClassic:
        return _luxuryClassicTheme;
      case AppTheme.playfulBold:
        return _playfulBoldTheme;
    }
  }

  // Modern Minimal Theme
  // Characterized by clean lines, subtle shadows, and monochromatic colors
  static final _modernMinimalTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      secondary: Colors.grey[800]!,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.all(8),
      shadowColor: Colors.black.withOpacity(0.1),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: Colors.black, width: 1),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Luxury Classic Theme
  // Rich colors, serif fonts, and elegant shadows
  static final _luxuryClassicTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF2C3E50),
      secondary: Color(0xFFAF8C60),
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.playfairDisplayTextTheme(),
    cardTheme: CardTheme(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Color(0xFFAF8C60), width: 0.5),
      ),
      margin: EdgeInsets.all(12),
      shadowColor: Colors.black.withOpacity(0.2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Color(0xFF2C3E50),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Color(0xFFAF8C60), width: 2),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2C3E50),
      foregroundColor: Colors.white,
      elevation: 4,
      titleTextStyle: GoogleFonts.playfairDisplay(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  // Playful Bold Theme
  // Vibrant colors, rounded corners, and playful typography
  static final _playfulBoldTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: Color(0xFFFF6B6B),
      secondary: Color(0xFF4ECDC4),
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    cardTheme: CardTheme(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: EdgeInsets.all(16),
      color: Colors.white,
      shadowColor: Color(0xFF4ECDC4).withOpacity(0.3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color(0xFFFF6B6B),
        foregroundColor: Colors.white,
        elevation: 3,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(color: Color(0xFF4ECDC4), width: 2),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFF6B6B),
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// widget to toggle through different material themes to showcase dashsurvey
class ToggleThemeButton extends StatefulWidget {
  const ToggleThemeButton({super.key});

  @override
  State<ToggleThemeButton> createState() => _ToggleThemeButtonState();
}

class _ToggleThemeButtonState extends State<ToggleThemeButton> {
  int _currentThemeIndex = 0;

  void _toggleTheme(BuildContext context) {
    setState(() {
      _currentThemeIndex = (_currentThemeIndex + 1) % AppTheme.values.length;
    });
    final provider = ThemeProvider.of(context);
    final nextTheme = ThemeHolder.getTheme(AppTheme.values[_currentThemeIndex]);
    provider.updateTheme(nextTheme);
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => _toggleTheme(context),
      child: Text('Toggle Theme $_currentThemeIndex'),
    );
  }
}
