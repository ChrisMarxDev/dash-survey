import 'dart:collection';
import 'dart:convert';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:uuid/uuid.dart';

part 'localized_string.mapper.dart';

/// LocaleCode is a two-letter string that represents a locale
/// It is a wrapper around a string that ensures the string is a 2-letter string
extension type const LocaleCode._(String locale) implements String {
  /// Creates a LocaleCode from a string
  /// Throws an assertion error in debug mode if the string is not a 2-letter
  /// string
  const LocaleCode(this.locale)
      : assert(
          locale.length == 2,
          'Locale must be a two-letter string, got "$locale"',
        );

  /// Supported locales for convenience
  /// conveniencelocale code for en
  static const LocaleCode en = LocaleCode._('en');

  /// convenience locale code for de
  static const LocaleCode de = LocaleCode._('de');

  /// convenience locale code for es
  static const LocaleCode es = LocaleCode._('es');

  /// convenience locale code for fr
  static const LocaleCode fr = LocaleCode._('fr');

  /// convenience locale code for it
  static const LocaleCode it = LocaleCode._('it');
}

/// extension to add convenience functions to maps of LocalizedText
extension LocalizationMapFunction<T> on Map<LocaleCode, T> {
  /// copy the map with a new locale set to a new value
  Map<LocaleCode, T> copyWithSetLocale(LocaleCode locale, T value) {
    final newData = {...this};
    newData[locale] = value;
    return newData;
  }
}

/// extension to add convenience functions to maps of LocalizedText
extension LocalizationMapStringFunction on Map<LocaleCode, String> {
  /// check if the map is complete
  /// Returns true if all values in the map are non-empty strings
  bool isComplete() {
    return values.every((value) => value.trim().isNotEmpty);
  }
}

@MappableClass()

/// general string localization
class LocalizedText with LocalizedTextMappable {
  /// Creates a LocalizedText from a LocalizationHolder<String>
  const LocalizedText(
    this.data,
  );

  /// Map of locale codes to localized strings
  final Map<LocaleCode, String> data;

  // List<LocaleCode> get missingLocales {
  //   return data.keys.where((locale) => data[locale] == '').toList();
  // }

  /// Gets the localized string for the specified locale
  /// Returns an empty string if the locale is not found
  String get(LocaleCode locale) {
    return data[locale] ?? '';
  }

  /// Creates a copy of this LocalizedText with the specified locale set to the
  /// given value
  /// @param locale The locale to set
  /// @param value The value to set for the locale
  /// @return A new LocalizedText with the updated locale value
  LocalizedText copyWithSetLocale(LocaleCode locale, String value) {
    return LocalizedText(data.copyWithSetLocale(locale, value));
  }

  /// Compares a list of locales with the locales in the LocalizedText
  /// Returns the locales that are not present in the LocalizedText
  List<LocaleCode> missingLocalesForLocaleList(List<LocaleCode> locales) {
    return locales.where((locale) => data[locale]?.isEmpty ?? true).toList();
  }

  /// Checks if the LocalizedText is complete for a list of locales
  /// Returns true if the LocalizedText is complete for all the locales in the
  /// list
  bool isCompleteForLocales(List<LocaleCode> locales) {
    return missingLocalesForLocaleList(locales).isEmpty;
  }

  /// Checks if the LocalizedText is complete
  /// Returns true if the LocalizedText is complete
  bool isComplete() {
    return data.isComplete();
  }
}

@MappableClass()

/// map of strings to LocalizedText
class LocalizedTextMap with LocalizedTextMapMappable {
  /// Creates a LocalizedTextList from a LocalizationHolder<List<String>>
  LocalizedTextMap(
    this.data,
  );

  /// create an empty map with an option
  factory LocalizedTextMap.emptyWithOption() {
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>())
      ..addOption();
  }

  /// create an empty map
  factory LocalizedTextMap.empty() {
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>());
  }

  @MappableField(hook: LinkedHashMapHook())

  /// map of strings to LocalizedText
  LinkedHashMap<String, LocalizedText>? data;

  /// get the list of strings for a locale
  List<String> get(LocaleCode locale) {
    final res = data!.entries.map((entry) => entry.value.get(locale)).toList();
    return res;
  }

  /// get the map of strings for a locale
  Map<String, String> getMap(LocaleCode locale) {
    return Map.fromEntries(
      data!.entries
          .map((entry) => MapEntry(entry.key, entry.value.get(locale))),
    );
  }

  /// get the keys of the map
  List<String> getKeys() {
    return data!.keys.toList();
  }

  /// get the value for a key and locale
  String getByKey(String key, LocaleCode locale) {
    return data![key]!.get(locale);
  }

  /// add a localized text to the map
  LocalizedTextMap addLocalizedText({
    required String key,
    required LocaleCode locale,
    required String value,
  }) {
    final newData = {...data!};
    if (newData[key] == null) {
      newData[key] = const LocalizedText({});
    }
    newData[key] = newData[key]!.copyWithSetLocale(locale, value);
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  /// Removes a key from the map
  /// @param key The key to remove
  /// @return A new LocalizedTextMap with the key removed
  LocalizedTextMap remove(String key) {
    final newData = {...data!}..remove(key);
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  /// Adds a new option to the map with a generated UUID key
  /// @return A new LocalizedTextMap with the added option
  LocalizedTextMap addOption() {
    final newData = {...data!};
    newData[_createKey()] = const LocalizedText({});
    return LocalizedTextMap(LinkedHashMap<String, LocalizedText>.from(newData));
  }

  /// Creates a unique key using UUID v4
  /// @return A new UUID string
  String _createKey() {
    const uuid = Uuid();
    return uuid.v4();
  }

  /// Checks if the LocalizedTextMap is complete
  /// Returns true if the map is not null, not empty, and all values are
  /// complete
  bool isComplete() {
    return data != null &&
        data!.isNotEmpty &&
        data!.values.every((value) => value.isComplete());
  }

  @override
  String toString() {
    return jsonEncode(data);
  }

  /// Compares a list of locales with the locales in the LocalizedTextMap
  /// Returns the locales that are not present in the LocalizedTextMap
  Iterable<LocaleCode> missingLocalesForLocaleList(List<LocaleCode> locales) {
    if (data == null) {
      return locales;
    }

    final missing = data!.values.fold(
      <LocaleCode>[],
      (acc, value) => [
        ...acc,
        ...value.missingLocalesForLocaleList(locales),
      ],
    );

    return missing;
  }
}

/// A mapping hook for LinkedHashMap to handle serialization and deserialization
class LinkedHashMapHook extends MappingHook {
  /// Creates a new LinkedHashMapHook
  const LinkedHashMapHook();

  @override

  /// Converts the input value to a LinkedHashMap before decoding
  /// @param value The value to convert
  /// @return The converted value
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

  /// Decodes a Map<String, dynamic> into a LinkedHashMap<String, LocalizedText>
  /// @param value The map to decode
  /// @return The decoded LinkedHashMap
  LinkedHashMap<String, LocalizedText> decodeMap(Map<String, dynamic> value) {
    // ignore: prefer_collection_literals
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

  /// Prepares the value for encoding
  /// @param self The value to encode
  /// @return The prepared value
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
