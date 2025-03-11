// ignore_for_file: non_constant_identifier_names

import 'package:dash_survey_core/dash_survey_core.dart';

/// A provider for translations for the dash survey.
class DashSurveyTranslationProvider {
  /// Creates a new [DashSurveyTranslationProvider].
  DashSurveyTranslationProvider({Map<String, Map<String, String>>? overrides})
      : _overrides = overrides ?? {};

  final Map<String, Map<String, String>> _overrides;
  final Map<String, String> _translations_en = {
    'survey_finished': 'Thank you for answering our survey!',
  };
  final Map<String, String> _translations_de = {};
  final Map<String, String> _translations_fr = {};
  final Map<String, String> _translations_es = {};
  final Map<String, String> _translations_it = {};

  /// Get a translated string for the given locale and key.
  String getTranslatedString(
    LocaleCode locale,
    String key,
  ) {
    final override = _overrides[locale.locale]?[key];
    if (override != null) {
      return override;
    }
    final result = switch (locale) {
      LocaleCode.en => _translations_en[key],
      LocaleCode.de => _translations_de[key],
      LocaleCode.fr => _translations_fr[key],
      LocaleCode.es => _translations_es[key],
      LocaleCode.it => _translations_it[key],
      _ => null,
    };
    return result ?? key;
  }
}
