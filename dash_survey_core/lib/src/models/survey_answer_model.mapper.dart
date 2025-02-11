// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'survey_answer_model.dart';

class SubmitSurveyAnswerModelMapper
    extends ClassMapperBase<SubmitSurveyAnswerModel> {
  SubmitSurveyAnswerModelMapper._();

  static SubmitSurveyAnswerModelMapper? _instance;
  static SubmitSurveyAnswerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = SubmitSurveyAnswerModelMapper._());
      SurveyAnswerModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SubmitSurveyAnswerModel';

  static List<SurveyAnswerModel> _$answers(SubmitSurveyAnswerModel v) =>
      v.answers;
  static const Field<SubmitSurveyAnswerModel, List<SurveyAnswerModel>>
      _f$answers = Field('answers', _$answers);
  static String _$surveyId(SubmitSurveyAnswerModel v) => v.surveyId;
  static const Field<SubmitSurveyAnswerModel, String> _f$surveyId =
      Field('surveyId', _$surveyId);
  static String _$userId(SubmitSurveyAnswerModel v) => v.userId;
  static const Field<SubmitSurveyAnswerModel, String> _f$userId =
      Field('userId', _$userId);

  @override
  final MappableFields<SubmitSurveyAnswerModel> fields = const {
    #answers: _f$answers,
    #surveyId: _f$surveyId,
    #userId: _f$userId,
  };

  static SubmitSurveyAnswerModel _instantiate(DecodingData data) {
    return SubmitSurveyAnswerModel(
        answers: data.dec(_f$answers),
        surveyId: data.dec(_f$surveyId),
        userId: data.dec(_f$userId));
  }

  @override
  final Function instantiate = _instantiate;

  static SubmitSurveyAnswerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SubmitSurveyAnswerModel>(map);
  }

  static SubmitSurveyAnswerModel fromJson(String json) {
    return ensureInitialized().decodeJson<SubmitSurveyAnswerModel>(json);
  }
}

mixin SubmitSurveyAnswerModelMappable {
  String toJson() {
    return SubmitSurveyAnswerModelMapper.ensureInitialized()
        .encodeJson<SubmitSurveyAnswerModel>(this as SubmitSurveyAnswerModel);
  }

  Map<String, dynamic> toMap() {
    return SubmitSurveyAnswerModelMapper.ensureInitialized()
        .encodeMap<SubmitSurveyAnswerModel>(this as SubmitSurveyAnswerModel);
  }

  SubmitSurveyAnswerModelCopyWith<SubmitSurveyAnswerModel,
          SubmitSurveyAnswerModel, SubmitSurveyAnswerModel>
      get copyWith => _SubmitSurveyAnswerModelCopyWithImpl(
          this as SubmitSurveyAnswerModel, $identity, $identity);
  @override
  String toString() {
    return SubmitSurveyAnswerModelMapper.ensureInitialized()
        .stringifyValue(this as SubmitSurveyAnswerModel);
  }

  @override
  bool operator ==(Object other) {
    return SubmitSurveyAnswerModelMapper.ensureInitialized()
        .equalsValue(this as SubmitSurveyAnswerModel, other);
  }

  @override
  int get hashCode {
    return SubmitSurveyAnswerModelMapper.ensureInitialized()
        .hashValue(this as SubmitSurveyAnswerModel);
  }
}

extension SubmitSurveyAnswerModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SubmitSurveyAnswerModel, $Out> {
  SubmitSurveyAnswerModelCopyWith<$R, SubmitSurveyAnswerModel, $Out>
      get $asSubmitSurveyAnswerModel => $base
          .as((v, t, t2) => _SubmitSurveyAnswerModelCopyWithImpl(v, t, t2));
}

abstract class SubmitSurveyAnswerModelCopyWith<
    $R,
    $In extends SubmitSurveyAnswerModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SurveyAnswerModel,
          SurveyAnswerModelCopyWith<$R, SurveyAnswerModel, SurveyAnswerModel>>
      get answers;
  $R call({List<SurveyAnswerModel>? answers, String? surveyId, String? userId});
  SubmitSurveyAnswerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SubmitSurveyAnswerModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SubmitSurveyAnswerModel, $Out>
    implements
        SubmitSurveyAnswerModelCopyWith<$R, SubmitSurveyAnswerModel, $Out> {
  _SubmitSurveyAnswerModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SubmitSurveyAnswerModel> $mapper =
      SubmitSurveyAnswerModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SurveyAnswerModel,
          SurveyAnswerModelCopyWith<$R, SurveyAnswerModel, SurveyAnswerModel>>
      get answers => ListCopyWith($value.answers,
          (v, t) => v.copyWith.$chain(t), (v) => call(answers: v));
  @override
  $R call(
          {List<SurveyAnswerModel>? answers,
          String? surveyId,
          String? userId}) =>
      $apply(FieldCopyWithData({
        if (answers != null) #answers: answers,
        if (surveyId != null) #surveyId: surveyId,
        if (userId != null) #userId: userId
      }));
  @override
  SubmitSurveyAnswerModel $make(CopyWithData data) => SubmitSurveyAnswerModel(
      answers: data.get(#answers, or: $value.answers),
      surveyId: data.get(#surveyId, or: $value.surveyId),
      userId: data.get(#userId, or: $value.userId));

  @override
  SubmitSurveyAnswerModelCopyWith<$R2, SubmitSurveyAnswerModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SubmitSurveyAnswerModelCopyWithImpl($value, $cast, t);
}

class SurveyAnswerModelMapper extends ClassMapperBase<SurveyAnswerModel> {
  SurveyAnswerModelMapper._();

  static SurveyAnswerModelMapper? _instance;
  static SurveyAnswerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyAnswerModelMapper._());
      FreetextAnswerModelMapper.ensureInitialized();
      MultipleChoiceAnswerModelMapper.ensureInitialized();
      ScaleAnswerModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SurveyAnswerModel';

  static String _$questionId(SurveyAnswerModel v) => v.questionId;
  static const Field<SurveyAnswerModel, String> _f$questionId =
      Field('questionId', _$questionId);

  @override
  final MappableFields<SurveyAnswerModel> fields = const {
    #questionId: _f$questionId,
  };

  static SurveyAnswerModel _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SurveyAnswerModel');
  }

  @override
  final Function instantiate = _instantiate;

  static SurveyAnswerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SurveyAnswerModel>(map);
  }

  static SurveyAnswerModel fromJson(String json) {
    return ensureInitialized().decodeJson<SurveyAnswerModel>(json);
  }
}

mixin SurveyAnswerModelMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SurveyAnswerModelCopyWith<SurveyAnswerModel, SurveyAnswerModel,
      SurveyAnswerModel> get copyWith;
}

abstract class SurveyAnswerModelCopyWith<$R, $In extends SurveyAnswerModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? questionId});
  SurveyAnswerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class FreetextAnswerModelMapper extends ClassMapperBase<FreetextAnswerModel> {
  FreetextAnswerModelMapper._();

  static FreetextAnswerModelMapper? _instance;
  static FreetextAnswerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FreetextAnswerModelMapper._());
      SurveyAnswerModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'FreetextAnswerModel';

  static String _$questionId(FreetextAnswerModel v) => v.questionId;
  static const Field<FreetextAnswerModel, String> _f$questionId =
      Field('questionId', _$questionId);
  static String _$answer(FreetextAnswerModel v) => v.answer;
  static const Field<FreetextAnswerModel, String> _f$answer =
      Field('answer', _$answer);
  static LocaleCode? _$locale(FreetextAnswerModel v) => v.locale;
  static const Field<FreetextAnswerModel, LocaleCode> _f$locale =
      Field('locale', _$locale, opt: true);

  @override
  final MappableFields<FreetextAnswerModel> fields = const {
    #questionId: _f$questionId,
    #answer: _f$answer,
    #locale: _f$locale,
  };

  static FreetextAnswerModel _instantiate(DecodingData data) {
    return FreetextAnswerModel(
        questionId: data.dec(_f$questionId),
        answer: data.dec(_f$answer),
        locale: data.dec(_f$locale));
  }

  @override
  final Function instantiate = _instantiate;

  static FreetextAnswerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<FreetextAnswerModel>(map);
  }

  static FreetextAnswerModel fromJson(String json) {
    return ensureInitialized().decodeJson<FreetextAnswerModel>(json);
  }
}

mixin FreetextAnswerModelMappable {
  String toJson() {
    return FreetextAnswerModelMapper.ensureInitialized()
        .encodeJson<FreetextAnswerModel>(this as FreetextAnswerModel);
  }

  Map<String, dynamic> toMap() {
    return FreetextAnswerModelMapper.ensureInitialized()
        .encodeMap<FreetextAnswerModel>(this as FreetextAnswerModel);
  }

  FreetextAnswerModelCopyWith<FreetextAnswerModel, FreetextAnswerModel,
          FreetextAnswerModel>
      get copyWith => _FreetextAnswerModelCopyWithImpl(
          this as FreetextAnswerModel, $identity, $identity);
  @override
  String toString() {
    return FreetextAnswerModelMapper.ensureInitialized()
        .stringifyValue(this as FreetextAnswerModel);
  }

  @override
  bool operator ==(Object other) {
    return FreetextAnswerModelMapper.ensureInitialized()
        .equalsValue(this as FreetextAnswerModel, other);
  }

  @override
  int get hashCode {
    return FreetextAnswerModelMapper.ensureInitialized()
        .hashValue(this as FreetextAnswerModel);
  }
}

extension FreetextAnswerModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, FreetextAnswerModel, $Out> {
  FreetextAnswerModelCopyWith<$R, FreetextAnswerModel, $Out>
      get $asFreetextAnswerModel =>
          $base.as((v, t, t2) => _FreetextAnswerModelCopyWithImpl(v, t, t2));
}

abstract class FreetextAnswerModelCopyWith<$R, $In extends FreetextAnswerModel,
    $Out> implements SurveyAnswerModelCopyWith<$R, $In, $Out> {
  @override
  $R call({String? questionId, String? answer, LocaleCode? locale});
  FreetextAnswerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _FreetextAnswerModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, FreetextAnswerModel, $Out>
    implements FreetextAnswerModelCopyWith<$R, FreetextAnswerModel, $Out> {
  _FreetextAnswerModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<FreetextAnswerModel> $mapper =
      FreetextAnswerModelMapper.ensureInitialized();
  @override
  $R call({String? questionId, String? answer, Object? locale = $none}) =>
      $apply(FieldCopyWithData({
        if (questionId != null) #questionId: questionId,
        if (answer != null) #answer: answer,
        if (locale != $none) #locale: locale
      }));
  @override
  FreetextAnswerModel $make(CopyWithData data) => FreetextAnswerModel(
      questionId: data.get(#questionId, or: $value.questionId),
      answer: data.get(#answer, or: $value.answer),
      locale: data.get(#locale, or: $value.locale));

  @override
  FreetextAnswerModelCopyWith<$R2, FreetextAnswerModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _FreetextAnswerModelCopyWithImpl($value, $cast, t);
}

class MultipleChoiceAnswerModelMapper
    extends ClassMapperBase<MultipleChoiceAnswerModel> {
  MultipleChoiceAnswerModelMapper._();

  static MultipleChoiceAnswerModelMapper? _instance;
  static MultipleChoiceAnswerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = MultipleChoiceAnswerModelMapper._());
      SurveyAnswerModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MultipleChoiceAnswerModel';

  static String _$questionId(MultipleChoiceAnswerModel v) => v.questionId;
  static const Field<MultipleChoiceAnswerModel, String> _f$questionId =
      Field('questionId', _$questionId);
  static List<String> _$answers(MultipleChoiceAnswerModel v) => v.answers;
  static const Field<MultipleChoiceAnswerModel, List<String>> _f$answers =
      Field('answers', _$answers);

  @override
  final MappableFields<MultipleChoiceAnswerModel> fields = const {
    #questionId: _f$questionId,
    #answers: _f$answers,
  };

  static MultipleChoiceAnswerModel _instantiate(DecodingData data) {
    return MultipleChoiceAnswerModel(
        questionId: data.dec(_f$questionId), answers: data.dec(_f$answers));
  }

  @override
  final Function instantiate = _instantiate;

  static MultipleChoiceAnswerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MultipleChoiceAnswerModel>(map);
  }

  static MultipleChoiceAnswerModel fromJson(String json) {
    return ensureInitialized().decodeJson<MultipleChoiceAnswerModel>(json);
  }
}

mixin MultipleChoiceAnswerModelMappable {
  String toJson() {
    return MultipleChoiceAnswerModelMapper.ensureInitialized()
        .encodeJson<MultipleChoiceAnswerModel>(
            this as MultipleChoiceAnswerModel);
  }

  Map<String, dynamic> toMap() {
    return MultipleChoiceAnswerModelMapper.ensureInitialized()
        .encodeMap<MultipleChoiceAnswerModel>(
            this as MultipleChoiceAnswerModel);
  }

  MultipleChoiceAnswerModelCopyWith<MultipleChoiceAnswerModel,
          MultipleChoiceAnswerModel, MultipleChoiceAnswerModel>
      get copyWith => _MultipleChoiceAnswerModelCopyWithImpl(
          this as MultipleChoiceAnswerModel, $identity, $identity);
  @override
  String toString() {
    return MultipleChoiceAnswerModelMapper.ensureInitialized()
        .stringifyValue(this as MultipleChoiceAnswerModel);
  }

  @override
  bool operator ==(Object other) {
    return MultipleChoiceAnswerModelMapper.ensureInitialized()
        .equalsValue(this as MultipleChoiceAnswerModel, other);
  }

  @override
  int get hashCode {
    return MultipleChoiceAnswerModelMapper.ensureInitialized()
        .hashValue(this as MultipleChoiceAnswerModel);
  }
}

extension MultipleChoiceAnswerModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MultipleChoiceAnswerModel, $Out> {
  MultipleChoiceAnswerModelCopyWith<$R, MultipleChoiceAnswerModel, $Out>
      get $asMultipleChoiceAnswerModel => $base
          .as((v, t, t2) => _MultipleChoiceAnswerModelCopyWithImpl(v, t, t2));
}

abstract class MultipleChoiceAnswerModelCopyWith<
    $R,
    $In extends MultipleChoiceAnswerModel,
    $Out> implements SurveyAnswerModelCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get answers;
  @override
  $R call({String? questionId, List<String>? answers});
  MultipleChoiceAnswerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MultipleChoiceAnswerModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MultipleChoiceAnswerModel, $Out>
    implements
        MultipleChoiceAnswerModelCopyWith<$R, MultipleChoiceAnswerModel, $Out> {
  _MultipleChoiceAnswerModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MultipleChoiceAnswerModel> $mapper =
      MultipleChoiceAnswerModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>> get answers =>
      ListCopyWith($value.answers, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(answers: v));
  @override
  $R call({String? questionId, List<String>? answers}) =>
      $apply(FieldCopyWithData({
        if (questionId != null) #questionId: questionId,
        if (answers != null) #answers: answers
      }));
  @override
  MultipleChoiceAnswerModel $make(CopyWithData data) =>
      MultipleChoiceAnswerModel(
          questionId: data.get(#questionId, or: $value.questionId),
          answers: data.get(#answers, or: $value.answers));

  @override
  MultipleChoiceAnswerModelCopyWith<$R2, MultipleChoiceAnswerModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _MultipleChoiceAnswerModelCopyWithImpl($value, $cast, t);
}

class ScaleAnswerModelMapper extends ClassMapperBase<ScaleAnswerModel> {
  ScaleAnswerModelMapper._();

  static ScaleAnswerModelMapper? _instance;
  static ScaleAnswerModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ScaleAnswerModelMapper._());
      SurveyAnswerModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ScaleAnswerModel';

  static String _$questionId(ScaleAnswerModel v) => v.questionId;
  static const Field<ScaleAnswerModel, String> _f$questionId =
      Field('questionId', _$questionId);
  static double _$answer(ScaleAnswerModel v) => v.answer;
  static const Field<ScaleAnswerModel, double> _f$answer =
      Field('answer', _$answer);

  @override
  final MappableFields<ScaleAnswerModel> fields = const {
    #questionId: _f$questionId,
    #answer: _f$answer,
  };

  static ScaleAnswerModel _instantiate(DecodingData data) {
    return ScaleAnswerModel(
        questionId: data.dec(_f$questionId), answer: data.dec(_f$answer));
  }

  @override
  final Function instantiate = _instantiate;

  static ScaleAnswerModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ScaleAnswerModel>(map);
  }

  static ScaleAnswerModel fromJson(String json) {
    return ensureInitialized().decodeJson<ScaleAnswerModel>(json);
  }
}

mixin ScaleAnswerModelMappable {
  String toJson() {
    return ScaleAnswerModelMapper.ensureInitialized()
        .encodeJson<ScaleAnswerModel>(this as ScaleAnswerModel);
  }

  Map<String, dynamic> toMap() {
    return ScaleAnswerModelMapper.ensureInitialized()
        .encodeMap<ScaleAnswerModel>(this as ScaleAnswerModel);
  }

  ScaleAnswerModelCopyWith<ScaleAnswerModel, ScaleAnswerModel, ScaleAnswerModel>
      get copyWith => _ScaleAnswerModelCopyWithImpl(
          this as ScaleAnswerModel, $identity, $identity);
  @override
  String toString() {
    return ScaleAnswerModelMapper.ensureInitialized()
        .stringifyValue(this as ScaleAnswerModel);
  }

  @override
  bool operator ==(Object other) {
    return ScaleAnswerModelMapper.ensureInitialized()
        .equalsValue(this as ScaleAnswerModel, other);
  }

  @override
  int get hashCode {
    return ScaleAnswerModelMapper.ensureInitialized()
        .hashValue(this as ScaleAnswerModel);
  }
}

extension ScaleAnswerModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ScaleAnswerModel, $Out> {
  ScaleAnswerModelCopyWith<$R, ScaleAnswerModel, $Out>
      get $asScaleAnswerModel =>
          $base.as((v, t, t2) => _ScaleAnswerModelCopyWithImpl(v, t, t2));
}

abstract class ScaleAnswerModelCopyWith<$R, $In extends ScaleAnswerModel, $Out>
    implements SurveyAnswerModelCopyWith<$R, $In, $Out> {
  @override
  $R call({String? questionId, double? answer});
  ScaleAnswerModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ScaleAnswerModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ScaleAnswerModel, $Out>
    implements ScaleAnswerModelCopyWith<$R, ScaleAnswerModel, $Out> {
  _ScaleAnswerModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ScaleAnswerModel> $mapper =
      ScaleAnswerModelMapper.ensureInitialized();
  @override
  $R call({String? questionId, double? answer}) => $apply(FieldCopyWithData({
        if (questionId != null) #questionId: questionId,
        if (answer != null) #answer: answer
      }));
  @override
  ScaleAnswerModel $make(CopyWithData data) => ScaleAnswerModel(
      questionId: data.get(#questionId, or: $value.questionId),
      answer: data.get(#answer, or: $value.answer));

  @override
  ScaleAnswerModelCopyWith<$R2, ScaleAnswerModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ScaleAnswerModelCopyWithImpl($value, $cast, t);
}
