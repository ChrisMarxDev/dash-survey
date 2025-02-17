import 'package:dash_survey/src/survey/logic/dash_survey_controller/dash_survey_controller.dart';
import 'package:dash_survey/src/util/dash_survey_extension.dart';
import 'package:flutter/material.dart';

/// Wrap your app in this widget to enable SurveyDash
class DashSurvey extends StatefulWidget {
  /// Wrap your app in this widget to enable SurveyDash
  const DashSurvey({
    required this.child,
    required this.apiKey,
    this.baseUrl,
    this.enabled = true,
    this.theme,
    this.overrideLocale,
    this.demoMode = false,
    super.key,
  });

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

  /// Theme for the survey dash, if not provided the default will be used
  /// This is useful if you want to customize the look and feel of DashSurvey
  final ThemeData? theme;

  /// Base url or the survey dash api, if not provided the default will be used
  /// Should only be used for self hosted or enterprise customers
  final String? baseUrl;

  /// Override the locale for the survey dash
  /// Normally, SurveyDash will use the locale of the app taken from the context
  /// If you have a special setup or want to override the locale for
  /// the survey dash, you can use this property
  final Locale? overrideLocale;

  /// Enables the demo mode
  /// If true, DashSurvey will always show a survey when called.
  /// This will either be a demo survey or if available, a survey from
  /// the server.
  /// If this is enabled the survey will never be set to 'answered', so it will pop up repeatedly.
  /// This is useful for testing dash survey. And setting up the UI.
  final bool demoMode;

  /// Get the controller [DashSurveyController] from context
  static DashSurveyController of(BuildContext context) {
    final model =
        context.dependOnInheritedWidgetOfExactType<_DashSurveyInherited>();
    assert(
      model != null,
      'No DashSurvey found in context, wrap your app in DashSurvey() check our docs for more info!',
    );
    // model!.controller.showBuildContext = context;
    final state = context.findAncestorStateOfType<DashSurveyState>();
    if (state == null) {
      throw StateError('Could not find _DashSurveyState in ancestors');
    }
    // cache context in a short lived object like the widget
    // it gets later retrieved by the `show()` method to read the theme
    state.widget.showBuildContext = context;
    return model!.controller;
  }

  static void showDemo({required BuildContext context}) {
    showDemoSurvey(context: context);
  }

  @override
  State<DashSurvey> createState() => DashSurveyState();
}

class DashSurveyState extends State<DashSurvey> {
  late final DashSurveyController _controller;
  late final ChangeNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _controller = DashSurveyController(
      apiKey: widget.apiKey,
      currentContextGetter: () => widget.showBuildContext!,
    )..init();
    _notifier = ChangeNotifier();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DashSurveyInherited(
      controller: _controller,
      notifier: _notifier,
      child: widget.child,
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
class SurveyDashTargetView extends StatelessWidget {
  const SurveyDashTargetView({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
