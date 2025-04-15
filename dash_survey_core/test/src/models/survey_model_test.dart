import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_survey_core/dash_survey_core.dart';
import 'package:test/test.dart';

void main() {
  group('SurveyModel Serialization', () {
    test('should correctly serialize and deserialize SurveyModel', () {
      final model = SurveyModel(
        id: 'test-survey-1',
        name: const LocalizedText({LocaleCode.en: 'Test Survey'}),
        description:
            const LocalizedText({LocaleCode.en: 'A test survey description'}),
        questions: const [],
        createdAt: DateTime.utc(2024),
        displayOptions: const SurveyDisplayOptionsModel(),
      );

      final json = model.toJson();
      final deserialized = SurveyModelMapper.fromJson(json);

      expect(deserialized.id, equals(model.id));
      expect(deserialized.name.data, equals(model.name.data));
      expect(deserialized.description?.data, equals(model.description?.data));
      expect(deserialized.questions, equals(model.questions));
      expect(deserialized.createdAt, equals(model.createdAt));
      expect(deserialized.displayOptions, equals(model.displayOptions));
    });

    test('should correctly serialize and deserialize without optional fields',
        () {
      final model = SurveyModel(
        id: 'test-survey-2',
        name: const LocalizedText({LocaleCode.en: 'Test Survey'}),
        questions: const [],
        createdAt: DateTime.utc(2024),
      );

      final json = model.toJson();
      final deserialized = SurveyModelMapper.fromJson(json);

      expect(deserialized.id, equals(model.id));
      expect(deserialized.name.data, equals(model.name.data));
      expect(deserialized.description, isNull);
      expect(deserialized.questions, equals(model.questions));
      expect(deserialized.displayOptions, isNull);
    });
  });

  group('SurveyDisplayOptionsModel Serialization', () {
    test('should correctly serialize and deserialize with default values', () {
      const model = SurveyDisplayOptionsModel();

      final json = model.toJson();
      final deserialized = SurveyDisplayOptionsModelMapper.fromJson(json);

      expect(deserialized.showProgressBar, isTrue);
      expect(deserialized.showQuestionNumber, isTrue);
      expect(deserialized.displayType, equals(SurveyDisplayType.bottomSheet));
      expect(
        deserialized.indicationType,
        equals(SurveyIndicationType.floatingButton),
      );
    });

    test('should correctly serialize and deserialize with custom values', () {
      const model = SurveyDisplayOptionsModel(
        showProgressBar: false,
        showQuestionNumber: false,
        indicationType: SurveyIndicationType.popupDialog,
      );

      final json = model.toJson();
      final deserialized = SurveyDisplayOptionsModelMapper.fromJson(json);

      expect(deserialized.showProgressBar, isFalse);
      expect(deserialized.showQuestionNumber, isFalse);
      expect(deserialized.displayType, equals(SurveyDisplayType.bottomSheet));
      expect(
        deserialized.indicationType,
        equals(SurveyIndicationType.popupDialog),
      );
    });
  });

  group('Enum Serialization', () {
    test('should correctly serialize and deserialize SurveyDisplayType', () {
      for (final type in SurveyDisplayType.values) {
        final json = MapperContainer.globals.toJson<SurveyDisplayType>(type);
        final deserialized =
            MapperContainer.globals.fromJson<SurveyDisplayType>(json);
        expect(deserialized, equals(type));
      }
    });

    test('should correctly serialize and deserialize SurveyIndicationType', () {
      for (final type in SurveyIndicationType.values) {
        final json = MapperContainer.globals.toJson<SurveyIndicationType>(type);
        final deserialized =
            MapperContainer.globals.fromJson<SurveyIndicationType>(json);
        expect(deserialized, equals(type));
      }
    });
  });
}
