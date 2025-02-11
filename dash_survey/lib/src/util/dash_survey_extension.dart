import 'package:dash_survey/src/survey/dash_survey.dart';
import 'package:flutter/widgets.dart';

/// Use to bind the [BuildContext] to the current [Wiredash] widget
final Expando _expando = Expando();

extension WiredashWithBuildContext on DashSurvey {
  /// The context that is attached to the Wiredash widget using
  /// `Wiredash.of(context)`
  BuildContext? get showBuildContext {
    return _expando[this] as BuildContext?;
  }

  /// Attach a [BuildContext] to the this [Wiredash] widget
  ///
  /// This setter creates a weak reference to the context. It is free for
  /// garbage collection once the [Wiredash] widget gets garbage collected
  set showBuildContext(BuildContext? context) {
    _expando[this] = context;
  }
}