import 'dart:ui';

import 'package:dash_survey/dash_survey.dart';

extension LocaleCodeUtils on LocaleCode {
  static LocaleCode fromLocale(Locale locale) {
    return LocaleCode(locale.languageCode);
  }
}
