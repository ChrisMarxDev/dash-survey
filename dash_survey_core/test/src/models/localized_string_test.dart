import 'dart:collection';
import 'package:test/test.dart';
import 'package:dash_survey_core/src/models/localized_string.dart';

void main() {
  group('LocaleCode', () {
    test('creates valid locale codes', () {
      expect(const LocaleCode('en'), equals(LocaleCode.en));
      expect(const LocaleCode('de'), equals(LocaleCode.de));
    });

    test('throws assertion error for invalid locale codes', () {
      expect(() => LocaleCode('eng'), throwsA(isA<AssertionError>()));
      expect(() => LocaleCode('d'), throwsA(isA<AssertionError>()));
    });
  });

  group('LocalizedText', () {
    final testData = {
      LocaleCode.en: 'Hello',
      LocaleCode.de: 'Hallo',
    };

    test('creates instance and gets values', () {
      final localizedText = LocalizedText(testData);
      expect(localizedText.get(LocaleCode.en), equals('Hello'));
      expect(localizedText.get(LocaleCode.de), equals('Hallo'));
      expect(localizedText.get(LocaleCode.es), equals(''));
    });

    test('creates empty instance', () {
      final empty = LocalizedText.empty([LocaleCode.en, LocaleCode.de]);
      expect(empty.get(LocaleCode.en), equals(''));
      expect(empty.get(LocaleCode.de), equals(''));
    });

    test('serializes and deserializes correctly', () {
      final original = LocalizedText(testData);
      final json = original.toJson();
      final deserialized = LocalizedTextMapper.fromJson(json);

      expect(deserialized.data, equals(original.data));
    });

    test('checks completeness', () {
      const complete = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: 'Hallo',
      });
      expect(complete.isComplete(), isTrue);

      const incomplete = LocalizedText({
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
      });
      expect(incomplete.isComplete(), isFalse);
    });
  });

  group('LocalizedTextList', () {
    final testData = {
      LocaleCode.en: ['Hello', 'World'],
      LocaleCode.de: ['Hallo', 'Welt'],
    };

    test('creates instance and gets values', () {
      final localizedList = LocalizedTextList(testData);
      expect(localizedList.get(LocaleCode.en), equals(['Hello', 'World']));
      expect(localizedList.get(LocaleCode.de), equals(['Hallo', 'Welt']));
      expect(localizedList.get(LocaleCode.es), equals([]));
    });

    test('serializes and deserializes correctly', () {
      final original = LocalizedTextList(testData);
      final json = original.toJson();
      final deserialized = LocalizedTextListMapper.fromJson(json);

      expect(deserialized.data, equals(original.data));
    });
  });

  group('LocalizedTextMap', () {
    late LocalizedTextMap textMap;

    setUp(() {
      textMap = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
          'key2': const LocalizedText({
            LocaleCode.en: 'World',
            LocaleCode.de: 'Welt',
          }),
        }),
      );
    });

    test('gets values by locale', () {
      expect(textMap.get(LocaleCode.en), equals(['Hello', 'World']));
      expect(textMap.get(LocaleCode.de), equals(['Hallo', 'Welt']));
    });

    test('gets map by locale', () {
      final enMap = textMap.getMap(LocaleCode.en);
      expect(
        enMap,
        equals({
          'key1': 'Hello',
          'key2': 'World',
        }),
      );
    });

    test('gets value by key and locale', () {
      expect(textMap.getByKey('key1', LocaleCode.en), equals('Hello'));
      expect(textMap.getByKey('key2', LocaleCode.de), equals('Welt'));
    });

    test('adds and removes options', () {
      final withNewOption = textMap.addOption();
      expect(withNewOption.data!.length, equals(textMap.data!.length + 1));

      final key = textMap.data!.keys.first;
      final removed = textMap.remove(key);
      expect(removed.data!.length, equals(textMap.data!.length - 1));
      expect(removed.data!.containsKey(key), isFalse);
    });

    test('serializes and deserializes correctly', () {
      final json = textMap.toJson();
      final deserialized = LocalizedTextMapMapper.fromJson(json);

      expect(deserialized.data, equals(textMap.data));
    });

    test('checks completeness', () {
      final complete = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: 'Hallo',
          }),
        }),
      );
      expect(complete.isComplete(), isTrue);

      final incomplete = LocalizedTextMap(
        LinkedHashMap.from({
          'key1': const LocalizedText({
            LocaleCode.en: 'Hello',
            LocaleCode.de: '',
          }),
        }),
      );
      expect(incomplete.isComplete(), isFalse);
    });
  });

  group('Extension Methods', () {
    test('LocalizationMapStringFunction', () {
      final map = <LocaleCode, String>{
        LocaleCode.en: 'Hello',
        LocaleCode.de: '',
      };

      expect(map.isComplete(), isFalse);
      expect(map.missingLocales(), equals([LocaleCode.de]));

      map.addLocale(LocaleCode.es);
      expect(map[LocaleCode.es], equals(''));
    });

    test('LocalizationMapStringListFunction', () {
      final map = <LocaleCode, List<String>>{
        LocaleCode.en: ['Hello', 'World'],
        LocaleCode.de: [],
      };

      expect(map.isComplete(), isFalse);
      expect(map.missingLocales(), equals([LocaleCode.de]));
      expect(
        map.isCompleteForLocales([LocaleCode.en]),
        isTrue,
      );

      map.addLocale(LocaleCode.es);
      expect(map[LocaleCode.es], equals([]));
    });
  });
}
