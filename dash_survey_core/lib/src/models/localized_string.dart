import 'dart:collection';
import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:uuid/uuid.dart';

part 'localized_string.mapper.dart';

/// LocaleCode is a two-letter string that represents a locale
/// It is a wrapper around a string that ensures the string is a 2-letter string
extension type const LocaleCode._(String locale) implements String {
  /// Creates a LocaleCode from a string
  /// Throws an assertion error in debug mode if the string is not a 2-letter string
  const LocaleCode(this.locale)
      : assert(
          locale.length == 2,
          'Locale must be a two-letter string, got "$locale"',
        );

  static const LocaleCode en = LocaleCode._('en');
  static const LocaleCode de = LocaleCode._('de');
  static const LocaleCode es = LocaleCode._('es');
  static const LocaleCode fr = LocaleCode._('fr');
  static const LocaleCode it = LocaleCode._('it');
}

extension LocalizationMapFunction<T> on Map<LocaleCode, T> {
  void removeLocale(LocaleCode locale) {
    remove(locale);
  }

  Map<LocaleCode, T> copyWithSetLocale(LocaleCode locale, T value) {
    final newData = {...this};
    newData[locale] = value;
    return newData;
  }
}

extension LocalizationMapStringFunction on Map<LocaleCode, String> {
  void addLocale(LocaleCode locale) {
    this[locale] = '';
  }

  bool isComplete() {
    return values.every((value) => value.trim().isNotEmpty);
  }

  List<LocaleCode> missingLocales() {
    return entries
        .where((entry) => entry.value == '')
        .map((entry) => entry.key)
        .toList();
  }
}

extension LocalizationMapStringListFunction on Map<LocaleCode, List<String>> {
  void addLocale(LocaleCode locale) {
    this[locale] = [];
  }

  bool isComplete() {
    return values.every((value) => value.isNotEmpty);
  }

  bool isCompleteForLocales(List<LocaleCode> locales) {
    return locales.every((locale) => this[locale]?.isNotEmpty ?? false);
  }

  List<LocaleCode> missingLocales() {
    return entries
        .where((entry) => entry.value.isEmpty)
        .map((entry) => entry.key)
        .toList();
  }
}

@MappableClass()
/// general string localization
class LocalizedText with LocalizedTextMappable {
  /// Creates a LocalizedText from a LocalizationHolder<String>
  const LocalizedText(
    this.data,
  );

  final Map<LocaleCode, String> data;

  String get(LocaleCode locale) {
    return data[locale] ?? '';
  }

  static LocalizedText empty(List<LocaleCode> locales) {
    return LocalizedText({
      for (final locale in locales) locale: '',
    });
  }

  LocalizedText copyWithSetLocale(LocaleCode locale, String value) {
    return LocalizedText(data.copyWithSetLocale(locale, value));
  }

  bool isCompleteForLocales(List<LocaleCode> locales) {
    return locales.every((locale) => data[locale]?.isNotEmpty ?? false);
  }

  bool isComplete() {
    return data.isComplete();
  }
}

@MappableClass()

/// list of strings localization
class LocalizedTextList with LocalizedTextListMappable {
  /// Creates a LocalizedTextList from a LocalizationHolder<List<String>>
  const LocalizedTextList(
    this.data,
  );

  final Map<LocaleCode, List<String>> data;

  List<String> get(LocaleCode locale) {
    return data[locale] ?? [];
  }

  static LocalizedTextList empty(List<LocaleCode> locales) {
    return LocalizedTextList({
      for (final locale in locales) locale: [''],
    });
  }

  LocalizedTextList copyWithSetLocale(LocaleCode locale, List<String> value) {
    return LocalizedTextList(data.copyWithSetLocale(locale, value));
  }
}

@MappableClass()
class LocalizedTextMap with LocalizedTextMapMappable {
  /// Creates a LocalizedTextList from a LocalizationHolder<List<String>>
  LocalizedTextMap(
    this.data,
  );
  // keep the order of the keys
  // TODO(chris): refactor to make const

  @MappableField(hook: LinkedHashMapHook())
  LinkedHashMap<String, LocalizedText>? data;

  // utility functions
  List<String> get(LocaleCode locale) {
    final res = data!.entries.map((entry) => entry.value.get(locale)).toList();
    return res;
  }

  Map<String, String> getMap(LocaleCode locale) {
    return Map.fromEntries(
      data!.entries
          .map((entry) => MapEntry(entry.key, entry.value.get(locale))),
    );
  }

  String getByKey(String key, LocaleCode locale) {
    return data![key]!.get(locale);
  }

  static LocalizedTextMap empty() {
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>());
  }

  static LocalizedTextMap emptyWithOption() {
    final empty = LocalizedTextMap(LinkedHashMap<String, LocalizedText>());
    empty.addOption();
    print(empty);
    return empty;
  }

  LocalizedTextMap addLocalizedText({
    required String key,
    required LocaleCode locale,
    required String value,
  }) {
    final newData = {...data!};
    newData[key] = newData[key]!.copyWithSetLocale(locale, value);
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  LocalizedTextMap remove(String key) {
    final newData = {...data!}..remove(key);
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  LocalizedTextMap addOption() {
    final newData = {...data!};
    newData[_createKey()] = const LocalizedText({});
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  String _createKey() {
    const uuid = Uuid();
    return uuid.v4();
  }

  bool isComplete() {
    return data != null &&
        data!.isNotEmpty &&
        data!.values.every((value) => value.isComplete());
  }

  @override
  String toString() {
    return jsonEncode(data);
  }
}

// class LocalizedTextMapHook extends SimpleMapper<LocalizedTextMap> {
//   const LocalizedTextMapHook();
//   @override
//   LocalizedTextMap decode(Object? value) {
//     if (value == null) {
//       return LocalizedTextMap(LinkedHashMap<String, LocalizedText>());
//     }
//     if (value is String) {
//       return decodeMap(jsonDecode(value) as Map<String, dynamic>);
//     }
//     if (value is Map<String, dynamic>) {
//       return decodeMap(value);
//     }
//     throw ArgumentError('Invalid value for LocalizedTextMap: $value');
//   }

//   LocalizedTextMap decodeMap(Map<String, dynamic> value) {
//     final data = <String, LocalizedText>{};
//     for (final entry in value.entries) {
//       data[entry.key] = LocalizedText(entry.value as Map<LocaleCode, String>);
//     }
//     return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(data));
//   }

//   @override
//   Object? encode(LocalizedTextMap? self) {
//     if (self == null) {
//       return null;
//     }
//     return jsonEncode(self.data);
//   }
// }

class LinkedHashMapHook extends MappingHook {
  const LinkedHashMapHook();
  @override
  Object? beforeDecode(Object? value) {
    if (value == null) {
      return <String, LocalizedText>{};
    }
    if (value is String) {
      return decodeMap(jsonDecode(value) as Map<String, dynamic>);
    }
    if (value is Map<String, dynamic>) {
      return decodeMap(value);
    }
    throw ArgumentError('Invalid value for LocalizedTextMap: $value');
  }

  LinkedHashMap<String, LocalizedText> decodeMap(Map<String, dynamic> value) {
    final data = LinkedHashMap<String, LocalizedText>();
    for (final entry in value.entries) {
      final localeMap = (entry.value as Map<String, dynamic>).map(
        (key, value) => MapEntry(LocaleCode(key), value.toString()),
      );
      data[entry.key] = LocalizedText(localeMap);
    }
    return data;
  }

  @override
  Object? beforeEncode(Object? self) {
    if (self == null) {
      return null;
    }
    if (self is LinkedHashMap<String, LocalizedText>) {
      return self.map((key, value) => MapEntry(key, value.data));
    }
    return self;
  }
}
