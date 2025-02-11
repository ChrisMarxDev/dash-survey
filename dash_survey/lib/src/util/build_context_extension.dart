import 'package:flutter/widgets.dart';

extension BuildContextExtension on BuildContext {
  Locale get locale => Localizations.localeOf(this);

  double scale(double size) => MediaQuery.textScalerOf(this).scale(size);
}
