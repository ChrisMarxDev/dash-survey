// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'survey_questions.dart';

class TextTypeMapper extends EnumMapper<TextType> {
  TextTypeMapper._();

  static TextTypeMapper? _instance;
  static TextTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TextTypeMapper._());
    }
    return _instance!;
  }

  static TextType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TextType decode(dynamic value) {
    switch (value) {
      case 'any':
        return TextType.any;
      case 'float':
        return TextType.float;
      case 'int':
        return TextType.int;
      case 'email':
        return TextType.email;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TextType self) {
    switch (self) {
      case TextType.any:
        return 'any';
      case TextType.float:
        return 'float';
      case TextType.int:
        return 'int';
      case TextType.email:
        return 'email';
    }
  }
}

extension TextTypeMapperExtension on TextType {
  String toValue() {
    TextTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TextType>(this) as String;
  }
}

class SurveyQuestionTypeMapper extends EnumMapper<SurveyQuestionType> {
  SurveyQuestionTypeMapper._();

  static SurveyQuestionTypeMapper? _instance;
  static SurveyQuestionTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyQuestionTypeMapper._());
    }
    return _instance!;
  }

  static SurveyQuestionType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SurveyQuestionType decode(dynamic value) {
    switch (value) {
      case 'freeText':
        return SurveyQuestionType.freeText;
      case 'multipleChoice':
        return SurveyQuestionType.multipleChoice;
      case 'singleChoice':
        return SurveyQuestionType.singleChoice;
      case 'scale':
        return SurveyQuestionType.scale;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SurveyQuestionType self) {
    switch (self) {
      case SurveyQuestionType.freeText:
        return 'freeText';
      case SurveyQuestionType.multipleChoice:
        return 'multipleChoice';
      case SurveyQuestionType.singleChoice:
        return 'singleChoice';
      case SurveyQuestionType.scale:
        return 'scale';
    }
  }
}

extension SurveyQuestionTypeMapperExtension on SurveyQuestionType {
  String toValue() {
    SurveyQuestionTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SurveyQuestionType>(this) as String;
  }
}

class ScaleTypeMapper extends EnumMapper<ScaleType> {
  ScaleTypeMapper._();

  static ScaleTypeMapper? _instance;
  static ScaleTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScaleTypeMapper._());
    }
    return _instance!;
  }

  static ScaleType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ScaleType decode(dynamic value) {
    switch (value) {
      case 'scale':
        return ScaleType.scale;
      case 'slider':
        return ScaleType.slider;
      case 'stars':
        return ScaleType.stars;
      case 'emoji':
        return ScaleType.emoji;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ScaleType self) {
    switch (self) {
      case ScaleType.scale:
        return 'scale';
      case ScaleType.slider:
        return 'slider';
      case ScaleType.stars:
        return 'stars';
      case ScaleType.emoji:
        return 'emoji';
    }
  }
}

extension ScaleTypeMapperExtension on ScaleType {
  String toValue() {
    ScaleTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ScaleType>(this) as String;
  }
}

class SurveyQuestionModelMapper extends ClassMapperBase<SurveyQuestionModel> {
  SurveyQuestionModelMapper._();

  static SurveyQuestionModelMapper? _instance;
  static SurveyQuestionModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyQuestionModelMapper._());
      FreeTextSurveyQuestionMapper.ensureInitialized();
      MultipleChoiceSurveyQuestionMapper.ensureInitialized();
      ScaleSurveyQuestionMapper.ensureInitialized();
      LocalizedTextMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SurveyQuestionModel';

  static LocalizedText _$questionText(SurveyQuestionModel v) => v.questionText;
  static const Field<SurveyQuestionModel, LocalizedText> _f$questionText =
      Field('questionText', _$questionText);
  static String _$id(SurveyQuestionModel v) => v.id;
  static const Field<SurveyQuestionModel, String> _f$id = Field('id', _$id);
  static String _$surveyId(SurveyQuestionModel v) => v.surveyId;
  static const Field<SurveyQuestionModel, String> _f$surveyId =
      Field('surveyId', _$surveyId);
  static bool _$isRequired(SurveyQuestionModel v) => v.isRequired;
  static const Field<SurveyQuestionModel, bool> _f$isRequired =
      Field('isRequired', _$isRequired, opt: true, def: true);

  @override
  final MappableFields<SurveyQuestionModel> fields = const {
    #questionText: _f$questionText,
    #id: _f$id,
    #surveyId: _f$surveyId,
    #isRequired: _f$isRequired,
  };

  static SurveyQuestionModel _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SurveyQuestionModel');
  }

  @override
  final Function instantiate = _instantiate;

  static SurveyQuestionModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SurveyQuestionModel>(map);
  }

  static SurveyQuestionModel fromJson(String json) {
    return ensureInitialized().decodeJson<SurveyQuestionModel>(json);
  }
}

mixin SurveyQuestionModelMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SurveyQuestionModelCopyWith<SurveyQuestionModel, SurveyQuestionModel,
      SurveyQuestionModel> get copyWith;
}

abstract class SurveyQuestionModelCopyWith<$R, $In extends SurveyQuestionModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText;
  $R call(
      {LocalizedText? questionText,
      String? id,
      String? surveyId,
      bool? isRequired});
  SurveyQuestionModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class FreeTextSurveyQuestionMapper
    extends ClassMapperBase<FreeTextSurveyQuestion> {
  FreeTextSurveyQuestionMapper._();

  static FreeTextSurveyQuestionMapper? _instance;
  static FreeTextSurveyQuestionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FreeTextSurveyQuestionMapper._());
      SurveyQuestionModelMapper.ensureInitialized();
      LocalizedTextMapper.ensureInitialized();
      TextTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FreeTextSurveyQuestion';

  static LocalizedText _$questionText(FreeTextSurveyQuestion v) =>
      v.questionText;
  static const Field<FreeTextSurveyQuestion, LocalizedText> _f$questionText =
      Field('questionText', _$questionText);
  static String _$id(FreeTextSurveyQuestion v) => v.id;
  static const Field<FreeTextSurveyQuestion, String> _f$id = Field('id', _$id);
  static String _$surveyId(FreeTextSurveyQuestion v) => v.surveyId;
  static const Field<FreeTextSurveyQuestion, String> _f$surveyId =
      Field('surveyId', _$surveyId);
  static bool _$isRequired(FreeTextSurveyQuestion v) => v.isRequired;
  static const Field<FreeTextSurveyQuestion, bool> _f$isRequired =
      Field('isRequired', _$isRequired, opt: true, def: true);
  static TextType _$textType(FreeTextSurveyQuestion v) => v.textType;
  static const Field<FreeTextSurveyQuestion, TextType> _f$textType =
      Field('textType', _$textType, opt: true, def: TextType.any);

  @override
  final MappableFields<FreeTextSurveyQuestion> fields = const {
    #questionText: _f$questionText,
    #id: _f$id,
    #surveyId: _f$surveyId,
    #isRequired: _f$isRequired,
    #textType: _f$textType,
  };

  static FreeTextSurveyQuestion _instantiate(DecodingData data) {
    return FreeTextSurveyQuestion(
        questionText: data.dec(_f$questionText),
        id: data.dec(_f$id),
        surveyId: data.dec(_f$surveyId),
        isRequired: data.dec(_f$isRequired),
        textType: data.dec(_f$textType));
  }

  @override
  final Function instantiate = _instantiate;

  static FreeTextSurveyQuestion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FreeTextSurveyQuestion>(map);
  }

  static FreeTextSurveyQuestion fromJson(String json) {
    return ensureInitialized().decodeJson<FreeTextSurveyQuestion>(json);
  }
}

mixin FreeTextSurveyQuestionMappable {
  String toJson() {
    return FreeTextSurveyQuestionMapper.ensureInitialized()
        .encodeJson<FreeTextSurveyQuestion>(this as FreeTextSurveyQuestion);
  }

  Map<String, dynamic> toMap() {
    return FreeTextSurveyQuestionMapper.ensureInitialized()
        .encodeMap<FreeTextSurveyQuestion>(this as FreeTextSurveyQuestion);
  }

  FreeTextSurveyQuestionCopyWith<FreeTextSurveyQuestion, FreeTextSurveyQuestion,
          FreeTextSurveyQuestion>
      get copyWith => _FreeTextSurveyQuestionCopyWithImpl(
          this as FreeTextSurveyQuestion, $identity, $identity);
  @override
  String toString() {
    return FreeTextSurveyQuestionMapper.ensureInitialized()
        .stringifyValue(this as FreeTextSurveyQuestion);
  }

  @override
  bool operator ==(Object other) {
    return FreeTextSurveyQuestionMapper.ensureInitialized()
        .equalsValue(this as FreeTextSurveyQuestion, other);
  }

  @override
  int get hashCode {
    return FreeTextSurveyQuestionMapper.ensureInitialized()
        .hashValue(this as FreeTextSurveyQuestion);
  }
}

extension FreeTextSurveyQuestionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FreeTextSurveyQuestion, $Out> {
  FreeTextSurveyQuestionCopyWith<$R, FreeTextSurveyQuestion, $Out>
      get $asFreeTextSurveyQuestion =>
          $base.as((v, t, t2) => _FreeTextSurveyQuestionCopyWithImpl(v, t, t2));
}

abstract class FreeTextSurveyQuestionCopyWith<
    $R,
    $In extends FreeTextSurveyQuestion,
    $Out> implements SurveyQuestionModelCopyWith<$R, $In, $Out> {
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText;
  @override
  $R call(
      {LocalizedText? questionText,
      String? id,
      String? surveyId,
      bool? isRequired,
      TextType? textType});
  FreeTextSurveyQuestionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FreeTextSurveyQuestionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FreeTextSurveyQuestion, $Out>
    implements
        FreeTextSurveyQuestionCopyWith<$R, FreeTextSurveyQuestion, $Out> {
  _FreeTextSurveyQuestionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FreeTextSurveyQuestion> $mapper =
      FreeTextSurveyQuestionMapper.ensureInitialized();
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText =>
      $value.questionText.copyWith.$chain((v) => call(questionText: v));
  @override
  $R call(
          {LocalizedText? questionText,
          String? id,
          String? surveyId,
          bool? isRequired,
          TextType? textType}) =>
      $apply(FieldCopyWithData({
        if (questionText != null) #questionText: questionText,
        if (id != null) #id: id,
        if (surveyId != null) #surveyId: surveyId,
        if (isRequired != null) #isRequired: isRequired,
        if (textType != null) #textType: textType
      }));
  @override
  FreeTextSurveyQuestion $make(CopyWithData data) => FreeTextSurveyQuestion(
      questionText: data.get(#questionText, or: $value.questionText),
      id: data.get(#id, or: $value.id),
      surveyId: data.get(#surveyId, or: $value.surveyId),
      isRequired: data.get(#isRequired, or: $value.isRequired),
      textType: data.get(#textType, or: $value.textType));

  @override
  FreeTextSurveyQuestionCopyWith<$R2, FreeTextSurveyQuestion, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FreeTextSurveyQuestionCopyWithImpl($value, $cast, t);
}

class MultipleChoiceSurveyQuestionMapper
    extends ClassMapperBase<MultipleChoiceSurveyQuestion> {
  MultipleChoiceSurveyQuestionMapper._();

  static MultipleChoiceSurveyQuestionMapper? _instance;
  static MultipleChoiceSurveyQuestionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultipleChoiceSurveyQuestionMapper._());
      SurveyQuestionModelMapper.ensureInitialized();
      LocalizedTextMapper.ensureInitialized();
      LocalizedTextMapMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultipleChoiceSurveyQuestion';

  static LocalizedText _$questionText(MultipleChoiceSurveyQuestion v) =>
      v.questionText;
  static const Field<MultipleChoiceSurveyQuestion, LocalizedText>
      _f$questionText = Field('questionText', _$questionText);
  static String _$id(MultipleChoiceSurveyQuestion v) => v.id;
  static const Field<MultipleChoiceSurveyQuestion, String> _f$id =
      Field('id', _$id);
  static String _$surveyId(MultipleChoiceSurveyQuestion v) => v.surveyId;
  static const Field<MultipleChoiceSurveyQuestion, String> _f$surveyId =
      Field('surveyId', _$surveyId);
  static LocalizedTextMap _$options(MultipleChoiceSurveyQuestion v) =>
      v.options;
  static const Field<MultipleChoiceSurveyQuestion, LocalizedTextMap>
      _f$options = Field('options', _$options);
  static bool _$isRequired(MultipleChoiceSurveyQuestion v) => v.isRequired;
  static const Field<MultipleChoiceSurveyQuestion, bool> _f$isRequired =
      Field('isRequired', _$isRequired, opt: true, def: true);
  static bool _$canSelectMultiple(MultipleChoiceSurveyQuestion v) =>
      v.canSelectMultiple;
  static const Field<MultipleChoiceSurveyQuestion, bool> _f$canSelectMultiple =
      Field('canSelectMultiple', _$canSelectMultiple, opt: true, def: false);

  @override
  final MappableFields<MultipleChoiceSurveyQuestion> fields = const {
    #questionText: _f$questionText,
    #id: _f$id,
    #surveyId: _f$surveyId,
    #options: _f$options,
    #isRequired: _f$isRequired,
    #canSelectMultiple: _f$canSelectMultiple,
  };

  static MultipleChoiceSurveyQuestion _instantiate(DecodingData data) {
    return MultipleChoiceSurveyQuestion(
        questionText: data.dec(_f$questionText),
        id: data.dec(_f$id),
        surveyId: data.dec(_f$surveyId),
        options: data.dec(_f$options),
        isRequired: data.dec(_f$isRequired),
        canSelectMultiple: data.dec(_f$canSelectMultiple));
  }

  @override
  final Function instantiate = _instantiate;

  static MultipleChoiceSurveyQuestion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultipleChoiceSurveyQuestion>(map);
  }

  static MultipleChoiceSurveyQuestion fromJson(String json) {
    return ensureInitialized().decodeJson<MultipleChoiceSurveyQuestion>(json);
  }
}

mixin MultipleChoiceSurveyQuestionMappable {
  String toJson() {
    return MultipleChoiceSurveyQuestionMapper.ensureInitialized()
        .encodeJson<MultipleChoiceSurveyQuestion>(
            this as MultipleChoiceSurveyQuestion);
  }

  Map<String, dynamic> toMap() {
    return MultipleChoiceSurveyQuestionMapper.ensureInitialized()
        .encodeMap<MultipleChoiceSurveyQuestion>(
            this as MultipleChoiceSurveyQuestion);
  }

  MultipleChoiceSurveyQuestionCopyWith<MultipleChoiceSurveyQuestion,
          MultipleChoiceSurveyQuestion, MultipleChoiceSurveyQuestion>
      get copyWith => _MultipleChoiceSurveyQuestionCopyWithImpl(
          this as MultipleChoiceSurveyQuestion, $identity, $identity);
  @override
  String toString() {
    return MultipleChoiceSurveyQuestionMapper.ensureInitialized()
        .stringifyValue(this as MultipleChoiceSurveyQuestion);
  }

  @override
  bool operator ==(Object other) {
    return MultipleChoiceSurveyQuestionMapper.ensureInitialized()
        .equalsValue(this as MultipleChoiceSurveyQuestion, other);
  }

  @override
  int get hashCode {
    return MultipleChoiceSurveyQuestionMapper.ensureInitialized()
        .hashValue(this as MultipleChoiceSurveyQuestion);
  }
}

extension MultipleChoiceSurveyQuestionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultipleChoiceSurveyQuestion, $Out> {
  MultipleChoiceSurveyQuestionCopyWith<$R, MultipleChoiceSurveyQuestion, $Out>
      get $asMultipleChoiceSurveyQuestion => $base.as(
          (v, t, t2) => _MultipleChoiceSurveyQuestionCopyWithImpl(v, t, t2));
}

abstract class MultipleChoiceSurveyQuestionCopyWith<
    $R,
    $In extends MultipleChoiceSurveyQuestion,
    $Out> implements SurveyQuestionModelCopyWith<$R, $In, $Out> {
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText;
  LocalizedTextMapCopyWith<$R, LocalizedTextMap, LocalizedTextMap> get options;
  @override
  $R call(
      {LocalizedText? questionText,
      String? id,
      String? surveyId,
      LocalizedTextMap? options,
      bool? isRequired,
      bool? canSelectMultiple});
  MultipleChoiceSurveyQuestionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultipleChoiceSurveyQuestionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultipleChoiceSurveyQuestion, $Out>
    implements
        MultipleChoiceSurveyQuestionCopyWith<$R, MultipleChoiceSurveyQuestion,
            $Out> {
  _MultipleChoiceSurveyQuestionCopyWithImpl(
      super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultipleChoiceSurveyQuestion> $mapper =
      MultipleChoiceSurveyQuestionMapper.ensureInitialized();
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText =>
      $value.questionText.copyWith.$chain((v) => call(questionText: v));
  @override
  LocalizedTextMapCopyWith<$R, LocalizedTextMap, LocalizedTextMap>
      get options => $value.options.copyWith.$chain((v) => call(options: v));
  @override
  $R call(
          {LocalizedText? questionText,
          String? id,
          String? surveyId,
          LocalizedTextMap? options,
          bool? isRequired,
          bool? canSelectMultiple}) =>
      $apply(FieldCopyWithData({
        if (questionText != null) #questionText: questionText,
        if (id != null) #id: id,
        if (surveyId != null) #surveyId: surveyId,
        if (options != null) #options: options,
        if (isRequired != null) #isRequired: isRequired,
        if (canSelectMultiple != null) #canSelectMultiple: canSelectMultiple
      }));
  @override
  MultipleChoiceSurveyQuestion $make(CopyWithData data) =>
      MultipleChoiceSurveyQuestion(
          questionText: data.get(#questionText, or: $value.questionText),
          id: data.get(#id, or: $value.id),
          surveyId: data.get(#surveyId, or: $value.surveyId),
          options: data.get(#options, or: $value.options),
          isRequired: data.get(#isRequired, or: $value.isRequired),
          canSelectMultiple:
              data.get(#canSelectMultiple, or: $value.canSelectMultiple));

  @override
  MultipleChoiceSurveyQuestionCopyWith<$R2, MultipleChoiceSurveyQuestion, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultipleChoiceSurveyQuestionCopyWithImpl($value, $cast, t);
}

class ScaleSurveyQuestionMapper extends ClassMapperBase<ScaleSurveyQuestion> {
  ScaleSurveyQuestionMapper._();

  static ScaleSurveyQuestionMapper? _instance;
  static ScaleSurveyQuestionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScaleSurveyQuestionMapper._());
      SurveyQuestionModelMapper.ensureInitialized();
      LocalizedTextMapper.ensureInitialized();
      LocalizedTextMapMapper.ensureInitialized();
      ScaleTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScaleSurveyQuestion';

  static LocalizedText _$questionText(ScaleSurveyQuestion v) => v.questionText;
  static const Field<ScaleSurveyQuestion, LocalizedText> _f$questionText =
      Field('questionText', _$questionText);
  static String _$id(ScaleSurveyQuestion v) => v.id;
  static const Field<ScaleSurveyQuestion, String> _f$id = Field('id', _$id);
  static String _$surveyId(ScaleSurveyQuestion v) => v.surveyId;
  static const Field<ScaleSurveyQuestion, String> _f$surveyId =
      Field('surveyId', _$surveyId);
  static LocalizedTextMap _$options(ScaleSurveyQuestion v) => v.options;
  static const Field<ScaleSurveyQuestion, LocalizedTextMap> _f$options =
      Field('options', _$options);
  static bool _$isRequired(ScaleSurveyQuestion v) => v.isRequired;
  static const Field<ScaleSurveyQuestion, bool> _f$isRequired =
      Field('isRequired', _$isRequired, opt: true, def: true);
  static ScaleType _$scaleType(ScaleSurveyQuestion v) => v.scaleType;
  static const Field<ScaleSurveyQuestion, ScaleType> _f$scaleType =
      Field('scaleType', _$scaleType, opt: true, def: ScaleType.scale);

  @override
  final MappableFields<ScaleSurveyQuestion> fields = const {
    #questionText: _f$questionText,
    #id: _f$id,
    #surveyId: _f$surveyId,
    #options: _f$options,
    #isRequired: _f$isRequired,
    #scaleType: _f$scaleType,
  };

  static ScaleSurveyQuestion _instantiate(DecodingData data) {
    return ScaleSurveyQuestion(
        questionText: data.dec(_f$questionText),
        id: data.dec(_f$id),
        surveyId: data.dec(_f$surveyId),
        options: data.dec(_f$options),
        isRequired: data.dec(_f$isRequired),
        scaleType: data.dec(_f$scaleType));
  }

  @override
  final Function instantiate = _instantiate;

  static ScaleSurveyQuestion fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScaleSurveyQuestion>(map);
  }

  static ScaleSurveyQuestion fromJson(String json) {
    return ensureInitialized().decodeJson<ScaleSurveyQuestion>(json);
  }
}

mixin ScaleSurveyQuestionMappable {
  String toJson() {
    return ScaleSurveyQuestionMapper.ensureInitialized()
        .encodeJson<ScaleSurveyQuestion>(this as ScaleSurveyQuestion);
  }

  Map<String, dynamic> toMap() {
    return ScaleSurveyQuestionMapper.ensureInitialized()
        .encodeMap<ScaleSurveyQuestion>(this as ScaleSurveyQuestion);
  }

  ScaleSurveyQuestionCopyWith<ScaleSurveyQuestion, ScaleSurveyQuestion,
          ScaleSurveyQuestion>
      get copyWith => _ScaleSurveyQuestionCopyWithImpl(
          this as ScaleSurveyQuestion, $identity, $identity);
  @override
  String toString() {
    return ScaleSurveyQuestionMapper.ensureInitialized()
        .stringifyValue(this as ScaleSurveyQuestion);
  }

  @override
  bool operator ==(Object other) {
    return ScaleSurveyQuestionMapper.ensureInitialized()
        .equalsValue(this as ScaleSurveyQuestion, other);
  }

  @override
  int get hashCode {
    return ScaleSurveyQuestionMapper.ensureInitialized()
        .hashValue(this as ScaleSurveyQuestion);
  }
}

extension ScaleSurveyQuestionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScaleSurveyQuestion, $Out> {
  ScaleSurveyQuestionCopyWith<$R, ScaleSurveyQuestion, $Out>
      get $asScaleSurveyQuestion =>
          $base.as((v, t, t2) => _ScaleSurveyQuestionCopyWithImpl(v, t, t2));
}

abstract class ScaleSurveyQuestionCopyWith<$R, $In extends ScaleSurveyQuestion,
    $Out> implements SurveyQuestionModelCopyWith<$R, $In, $Out> {
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText;
  LocalizedTextMapCopyWith<$R, LocalizedTextMap, LocalizedTextMap> get options;
  @override
  $R call(
      {LocalizedText? questionText,
      String? id,
      String? surveyId,
      LocalizedTextMap? options,
      bool? isRequired,
      ScaleType? scaleType});
  ScaleSurveyQuestionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ScaleSurveyQuestionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScaleSurveyQuestion, $Out>
    implements ScaleSurveyQuestionCopyWith<$R, ScaleSurveyQuestion, $Out> {
  _ScaleSurveyQuestionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScaleSurveyQuestion> $mapper =
      ScaleSurveyQuestionMapper.ensureInitialized();
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get questionText =>
      $value.questionText.copyWith.$chain((v) => call(questionText: v));
  @override
  LocalizedTextMapCopyWith<$R, LocalizedTextMap, LocalizedTextMap>
      get options => $value.options.copyWith.$chain((v) => call(options: v));
  @override
  $R call(
          {LocalizedText? questionText,
          String? id,
          String? surveyId,
          LocalizedTextMap? options,
          bool? isRequired,
          ScaleType? scaleType}) =>
      $apply(FieldCopyWithData({
        if (questionText != null) #questionText: questionText,
        if (id != null) #id: id,
        if (surveyId != null) #surveyId: surveyId,
        if (options != null) #options: options,
        if (isRequired != null) #isRequired: isRequired,
        if (scaleType != null) #scaleType: scaleType
      }));
  @override
  ScaleSurveyQuestion $make(CopyWithData data) => ScaleSurveyQuestion(
      questionText: data.get(#questionText, or: $value.questionText),
      id: data.get(#id, or: $value.id),
      surveyId: data.get(#surveyId, or: $value.surveyId),
      options: data.get(#options, or: $value.options),
      isRequired: data.get(#isRequired, or: $value.isRequired),
      scaleType: data.get(#scaleType, or: $value.scaleType));

  @override
  ScaleSurveyQuestionCopyWith<$R2, ScaleSurveyQuestion, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ScaleSurveyQuestionCopyWithImpl($value, $cast, t);
}
