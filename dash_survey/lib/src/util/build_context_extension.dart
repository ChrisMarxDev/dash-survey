import 'package:dash_survey/dash_survey.dart';
import 'package:dash_survey/src/util/translations/translation_provider.dart';
import 'package:flutter/widgets.dart';

extension BuildContextExtension on BuildContext {
  Locale get locale => Localizations.localeOf(this);
  LocaleCode get localeCode => LocaleCode(locale.languageCode);

  double scale(double size) => MediaQuery.textScalerOf(this).scale(size);

  String getTranslatedString(String key) {
    return DashSurveyTranslationProvider().getTranslatedString(localeCode, key);
  }
}
