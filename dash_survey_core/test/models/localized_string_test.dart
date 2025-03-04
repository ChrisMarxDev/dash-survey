import 'dart:collection';

import 'package:dash_survey_core/src/models/localized_string.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocaleCode', () {
    test('should create valid LocaleCode', () {
      const locale = LocaleCode('en');
      expect(locale, 'en');
    });

    test('should throw assertion error for invalid locale code', () {
      expect(() => LocaleCode('eng'), throwsA(isA<AssertionError>()));
    });

    test('predefined locales should be valid', () {
      expect(LocaleCode.en, 'en');
      expect(LocaleCode.de, 'de');
      expect(LocaleCode.es, 'es');
      expect(LocaleCode.fr, 'fr');
      expect(LocaleCode.it, 'it');
    });
  });

  group('LocalizationMapFunction', () {
    test('removeLocale should remove the locale from the map', () {
      final map = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      };
      map.removeLocale(LocaleCode.en);
      expect(map, {LocaleCode.de: 'Hallo'});
    });

    test('copyWithSetLocale should return a new map with the locale set', () {
      final map = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      };
      final newMap = map.copyWithSetLocale(LocaleCode.fr, 'Bonjour');
      expect(newMap, {
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
        LocaleCode.fr: 'Bonjour',
      });
      // Original map should be unchanged
      expect(map, {
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      });
    });
  });

  group('LocalizationMapStringFunction', () {
    test('addLocale should add the locale with empty string', () {
      final map = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
      };
      map.addLocale(LocaleCode.fr);
      expect(map, {
        LocaleCode.en: 'Hello',
        LocaleCode.fr: '',
      });
    });

    test('isComplete should return true if all values are non-empty', () {
      final completeMap = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      };
      expect(completeMap.isComplete(), true);

      final incompleteMap = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
      };
      expect(incompleteMap.isComplete(), false);
    });

    test('missingLocales should return locales with empty values', () {
      final map = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
        LocaleCode.fr: '',
        LocaleCode.es: 'Hola',
      };
      expect(map.missingLocales(), [LocaleCode.de, LocaleCode.fr]);
    });
  });

  group('LocalizationMapStringListFunction', () {
    test('addLocale should add the locale with empty list', () {
      final map = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello'],
      };
      map.addLocale(LocaleCode.fr);
      expect(map, {
        LocaleCode.en: ['Hello'],
        LocaleCode.fr: [],
      });
    });

    test('isComplete should return true if all values are non-empty lists', () {
      final completeMap = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello'],
        LocaleCode.de: ['Hallo'],
      };
      expect(completeMap.isComplete(), true);

      final incompleteMap = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello'],
        LocaleCode.de: [],
      };
      expect(incompleteMap.isComplete(), false);
    });

    test('isCompleteForLocales should check only specified locales', () {
      final map = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello'],
        LocaleCode.de: [],
        LocaleCode.fr: ['Bonjour'],
      };
      expect(map.isCompleteForLocales([LocaleCode.en, LocaleCode.fr]), true);
      expect(map.isCompleteForLocales([LocaleCode.en, LocaleCode.de]), false);
    });

    test('missingLocales should return locales with empty lists', () {
      final map = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello'],
        LocaleCode.de: [],
        LocaleCode.fr: [],
        LocaleCode.es: ['Hola'],
      };
      expect(map.missingLocales(), [LocaleCode.de, LocaleCode.fr]);
    });
  });

  group('LocalizedText', () {
    test('get should return the text for the locale or empty string', () {
      const localizedText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      });
      expect(localizedText.get(LocaleCode.en), 'Hello');
      expect(localizedText.get(LocaleCode.fr), '');
    });

    test('empty should create a LocalizedText with empty strings', () {
      final locales = [LocaleCode.en, LocaleCode.de];
      final emptyText = LocalizedText.empty(locales);
      expect(emptyText.data, {
        LocaleCode.en: '',
        LocaleCode.de: '',
      });
    });

    test(
        'copyWithSetLocale should return a new LocalizedText with the locale set',
        () {
      const localizedText = LocalizedText({
        LocaleCode.en: 'Hello',
      });
      final newText = localizedText.copyWithSetLocale(LocaleCode.de, 'Hallo');
      expect(newText.data, {
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      });
      // Original should be unchanged
      expect(localizedText.data, {
        LocaleCode.en: 'Hello',
      });
    });

    test(
        'missingLocalesForLocaleList should return locales not in the LocalizedText',
        () {
      const localizedText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
        LocaleCode.fr: 'Bonjour',
      });
      expect(
        localizedText.missingLocalesForLocaleList([
          LocaleCode.en,
          LocaleCode.de,
          LocaleCode.es,
          LocaleCode.fr,
        ]),
        [LocaleCode.de, LocaleCode.es],
      );
    });

    test(
        'isCompleteForLocales should check if all specified locales are complete',
        () {
      const localizedText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
        LocaleCode.fr: 'Bonjour',
      });
      expect(
        localizedText.isCompleteForLocales([LocaleCode.en, LocaleCode.fr]),
        true,
      );
      expect(
        localizedText.isCompleteForLocales([LocaleCode.en, LocaleCode.de]),
        false,
      );
    });

    test('isComplete should check if all locales are complete', () {
      const completeText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      });
      expect(completeText.isComplete(), true);

      const incompleteText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
      });
      expect(incompleteText.isComplete(), false);
    });

    test('missingLocales should return locales with empty values', () {
      const localizedText = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
        LocaleCode.fr: '',
      });
      expect(localizedText.missingLocales, [LocaleCode.de, LocaleCode.fr]);
    });
  });

  group('LocalizedTextList', () {
    test('get should return the list for the locale or empty list', () {
      const localizedTextList = LocalizedTextList({
        LocaleCode.en: ['Hello', 'Hi'],
        LocaleCode.de: ['Hallo', 'Guten Tag'],
      });
      expect(localizedTextList.get(LocaleCode.en), ['Hello', 'Hi']);
      expect(localizedTextList.get(LocaleCode.fr), []);
    });

    test('empty should create a LocalizedTextList with empty lists', () {
      final locales = [LocaleCode.en, LocaleCode.de];
      final emptyTextList = LocalizedTextList.empty(locales);
      expect(emptyTextList.data, {
        LocaleCode.en: [''],
        LocaleCode.de: [''],
      });
    });

    test(
        'copyWithSetLocale should return a new LocalizedTextList with the locale set',
        () {
      const localizedTextList = LocalizedTextList({
        LocaleCode.en: ['Hello', 'Hi'],
      });
      final newTextList = localizedTextList.copyWithSetLocale(
        LocaleCode.de,
        ['Hallo', 'Guten Tag'],
      );
      expect(newTextList.data, {
        LocaleCode.en: ['Hello', 'Hi'],
        LocaleCode.de: ['Hallo', 'Guten Tag'],
      });
      // Original should be unchanged
      expect(localizedTextList.data, {
        LocaleCode.en: ['Hello', 'Hi'],
      });
    });
  });

  group('LocalizedTextMap', () {
    test('get should return a list of values for the locale', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
          'key2': const LocalizedText({
            LocaleCode.en: 'Goodbye',
            LocaleCode.de: 'Auf Wiedersehen',
          }),
        }),
      );
      expect(localizedTextMap.get(LocaleCode.en), ['Hello', 'Goodbye']);
      expect(localizedTextMap.get(LocaleCode.de), ['Hallo', 'Auf Wiedersehen']);
    });

    test('getMap should return a map of key-value pairs for the locale', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
          'key2': const LocalizedText({
            LocaleCode.en: 'Goodbye',
            LocaleCode.de: 'Auf Wiedersehen',
          }),
        }),
      );
      expect(localizedTextMap.getMap(LocaleCode.en), {
        'key1': 'Hello',
        'key2': 'Goodbye',
      });
    });

    test('getKeys should return all keys', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({}),
          'key2': const LocalizedText({}),
        }),
      );
      expect(localizedTextMap.getKeys(), ['key1', 'key2']);
    });

    test('getByKey should return the value for the key and locale', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
        }),
      );
      expect(localizedTextMap.getByKey('key1', LocaleCode.en), 'Hello');
    });

    test('empty should create an empty LocalizedTextMap', () {
      final emptyMap = LocalizedTextMap.empty();
      expect(emptyMap.data, isEmpty);
    });

    test('addLocalizedText should add or update a key with a localized value',
        () {
      final localizedTextMap = LocalizedTextMap(LinkedHashMap());

      // Add new key
      final updatedMap1 = localizedTextMap.addLocalizedText(
        key: 'key1',
        locale: LocaleCode.en,
        value: 'Hello',
      );

      expect(updatedMap1.data!['key1']!.get(LocaleCode.en), 'Hello');

      // Update existing key
      final updatedMap2 = updatedMap1.addLocalizedText(
        key: 'key1',
        locale: LocaleCode.de,
        value: 'Hallo',
      );

      expect(updatedMap2.data!['key1']!.get(LocaleCode.en), 'Hello');
      expect(updatedMap2.data!['key1']!.get(LocaleCode.de), 'Hallo');
    });

    test('remove should remove a key', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({}),
          'key2': const LocalizedText({}),
        }),
      );

      final updatedMap = localizedTextMap.remove('key1');
      expect(updatedMap.data!.containsKey('key1'), false);
      expect(updatedMap.data!.containsKey('key2'), true);
    });

    test('addOption should add a new key with empty LocalizedText', () {
      final localizedTextMap = LocalizedTextMap(LinkedHashMap());
      final updatedMap = localizedTextMap.addOption();

      expect(updatedMap.data!.length, 1);
      // The key should be a UUID, so we just check that there is one key
      final firstKey = updatedMap.data!.keys.first;
      expect(updatedMap.data![firstKey], isA<LocalizedText>());
    });

    test('isComplete should check if all values are complete', () {
      final completeMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
          'key2': const LocalizedText({
            LocaleCode.en: 'Goodbye',
            LocaleCode.de: 'Auf Wiedersehen',
          }),
        }),
      );
      expect(completeMap.isComplete(), true);

      final incompleteMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: '',
          }),
        }),
      );
      expect(incompleteMap.isComplete(), false);
    });

    test('missingLocalesForLocaleList should return missing locales', () {
      final localizedTextMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: '',
          }),
          'key2': const LocalizedText({
            LocaleCode.en: 'Goodbye',
            LocaleCode.fr: '',
          }),
        }),
      );

      final missing = localizedTextMap.missingLocalesForLocaleList([
        LocaleCode.en,
        LocaleCode.de,
        LocaleCode.fr,
      ]);

      // Should contain de and fr since they're empty in at least one key
      expect(missing, containsAll([LocaleCode.de, LocaleCode.fr]));
    });
  });

  group('LinkedHashMapHook', () {
    test('beforeDecode should handle null', () {
      const hook = LinkedHashMapHook();
      final result = hook.beforeDecode(null);
      expect(result, isA<Map<String, LocalizedText>>());
      expect(result, isEmpty);
    });

    test('beforeDecode should handle JSON string', () {
      const hook = LinkedHashMapHook();
      const jsonString = '{"key1":{"en":"Hello","de":"Hallo"}}';
      final result = hook.beforeDecode(jsonString);

      expect(result, isA<LinkedHashMap<String, LocalizedText>>());
      final map = result! as LinkedHashMap<String, LocalizedText>;
      expect(map['key1']!.get(LocaleCode.en), 'Hello');
      expect(map['key1']!.get(LocaleCode.de), 'Hallo');
    });

    test('beforeDecode should handle Map', () {
      const hook = LinkedHashMapHook();
      final map = {
        'key1': {
          'en': 'Hello',
          'de': 'Hallo',
        },
      };
      final result = hook.beforeDecode(map);

      expect(result, isA<LinkedHashMap<String, LocalizedText>>());
      final resultMap = result! as LinkedHashMap<String, LocalizedText>;
      expect(resultMap['key1']!.get(LocaleCode.en), 'Hello');
      expect(resultMap['key1']!.get(LocaleCode.de), 'Hallo');
    });

    test('beforeEncode should handle null', () {
      const hook = LinkedHashMapHook();
      final result = hook.beforeEncode(null);
      expect(result, isNull);
    });

    test('beforeEncode should convert LinkedHashMap to Map', () {
      const hook = LinkedHashMapHook();
      final map = LinkedHashMap<String, LocalizedText>.from({
        'key1': const LocalizedText({
          LocaleCode.en: 'Hello',
          LocaleCode.de: 'Hallo',
        }),
      });

      final result = hook.beforeEncode(map);
      expect(result, isA<Map>());

      final resultMap = result! as Map;
      expect(resultMap['key1'], isA<Map<LocaleCode, String>>());
      expect(resultMap['key1'][LocaleCode.en], 'Hello');
      expect(resultMap['key1'][LocaleCode.de], 'Hallo');
    });
  });
}
