import 'package:dash_survey/src/config.dart';
import 'package:dash_survey/src/survey/dash_survey_theme.dart';
import 'package:dash_survey/src/survey/logic/dash_survey_controller/dash_survey_config.dart';
import 'package:dash_survey/src/survey/logic/dash_survey_controller/dash_survey_controller.dart';
import 'package:dash_survey/src/util/dash_survey_extension.dart';
import 'package:flutter/material.dart';

/// Wrap your app in this widget to enable SurveyDash
///
/// This widget is used to wrap your app in a widget that will provide the
/// [DashSurveyController] to the app.
///
/// You only have to supply a valid [apiKey] to enable SurveyDash. You can
/// get an api key from the SurveyDash dashboard at [https://app.dash-survey.com]
///
/// To view surveys and get a feel of SurveyDash, you can use the [debugMode]
/// flag. This will either show a demo survey or if available, a survey from
/// the server. Answering surveys in demo mode, will not set the survey as
/// answered. So you will see the same survey repeatedly for testing and
/// development purposes.
///
/// If you want to disable SurveyDash, you can set [enabled] to false.
///
/// If you want to customize the look and feel of SurveyDash, you can supply
/// a [theme]. This is currently a Material [ThemeData] object. This is subject
/// to change in the future.
class DashSurvey extends StatefulWidget {
  /// Wrap your app in this widget to enable SurveyDash
  const DashSurvey({
    required this.child,
    required this.apiKey,
    this.enabled = true,
    this.overrideLocale,
    this.debugMode = false,
    this.config,
    this.theme,
    super.key,
  });

  /// The config for the survey dash
  final DashSurveyConfig? config;

  /// The api key for the survey dash api
  /// You can use the api key 'demo' to get a running local demo
  ///  to test out the UI
  final String apiKey;

  /// The child widget that will be wrapped in the SurveyDashProvider
  final Widget child;

  /// Whether survey dash is enabled or not
  /// If false, no surveys will be shown and no logic will be executed
  /// SurveyDash.of(context) will return a stub element that does nothing
  final bool enabled;

  /// Theme for dash survey widgets, if not provided the default will be used
  /// This is useful if you want to customize the look and feel of DashSurvey
  final DashSurveyThemeData? theme;

  /// Override the locale for the survey dash
  /// Normally, SurveyDash will use the locale of the app taken from the context
  /// If you have a special setup or want to override the locale for
  /// the survey dash, you can use this property
  final Locale? overrideLocale;

  /// Enables the demo mode
  /// If true, DashSurvey will always show a survey when called.
  /// This will either be a demo survey or if available, a survey from
  /// the server.
  /// If this is enabled the survey will never be set to 'answered', so it will
  /// pop up repeatedly.
  /// This is useful for testing dash survey. And setting up the UI.
  /// Restart the app to reset finished surveys.
  final bool debugMode;

  /// Get the controller [DashSurveyControllerImplementation] from context
  static DashSurveyController of(BuildContext context) {
    final model =
        context.dependOnInheritedWidgetOfExactType<_DashSurveyInherited>();
    // assert(
    // model != null,
    // 'No DashSurvey found in context, wrap your app in DashSurvey() check our
    //docs $documentationUrl for more info!',
    // );
    if (model == null) {
      throw Exception(
        // ignore: lines_longer_than_80_chars
        'Could not find Dash Survey dependencies in ancestors, wrap your whole app in DashSurvey() or check our docs $documentationUrl for more info!',
      );
    }
    final state = context.findAncestorStateOfType<_DashSurveyState>();
    if (state == null) {
      throw StateError('Could not find _DashSurveyState in ancestors');
    }
    // cache context in a short lived object like the widget
    // it gets later retrieved by the `show()` method to read the theme
    state.widget.showBuildContext = context;
    return model.controller;
  }

  @override
  State<DashSurvey> createState() => _DashSurveyState();
}

class _DashSurveyState extends State<DashSurvey> {
  late final DashSurveyController _controller;
  late final ChangeNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = ChangeNotifier();

    if (!widget.enabled) {
      _controller = DisabledDashSurveyController();
    } else {
      widget.showBuildContext = context;
      _controller = DashSurveyControllerImplementation(
        apiKey: widget.apiKey,
        config: widget.config ?? const DashSurveyConfig(),
        debugMode: widget.debugMode,
        overrideLocale: widget.overrideLocale,
        currentContextGetter: () => widget.showBuildContext!,
      )..init();
      if (widget.debugMode) {
        // ignore: avoid_print
        print('''
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║                   DASH SURVEY DEMO MODE ENABLED                  ║
║                                                                  ║
║  Surveys will appear repeatedly for testing and UI development   ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
''');
      }
    }
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashSurveyTheme(
      theme: widget.theme ?? const DashSurveyThemeData(),
      child: _DashSurveyInherited(
        controller: _controller,
        notifier: _notifier,
        child: widget.child,
      ),
    );
  }
}

class _DashSurveyInherited extends InheritedNotifier<ChangeNotifier> {
  const _DashSurveyInherited({
    required this.controller,
    required super.notifier,
    required super.child,
  });

  final DashSurveyController controller;
}

/// Target view for SurveyDash
/// Use this widget to mark certain parts of your app as a target for surveys
/// These can be controlled with the targetViews property in the SurveyDashboard
//TODO: Implement this
// class SurveyDashTargetView extends StatelessWidget {
//   const SurveyDashTargetView({
//     required this.label,
//     required this.child,
//     super.key,
//   });

//   final String label;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }
