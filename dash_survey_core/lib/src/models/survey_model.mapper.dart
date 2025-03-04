// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'survey_model.dart';

class SurveyDisplayTypeMapper extends EnumMapper<SurveyDisplayType> {
  SurveyDisplayTypeMapper._();

  static SurveyDisplayTypeMapper? _instance;
  static SurveyDisplayTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyDisplayTypeMapper._());
    }
    return _instance!;
  }

  static SurveyDisplayType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SurveyDisplayType decode(dynamic value) {
    switch (value) {
      case 'dialog':
        return SurveyDisplayType.dialog;
      case 'bottomSheet':
        return SurveyDisplayType.bottomSheet;
      case 'fullScreen':
        return SurveyDisplayType.fullScreen;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SurveyDisplayType self) {
    switch (self) {
      case SurveyDisplayType.dialog:
        return 'dialog';
      case SurveyDisplayType.bottomSheet:
        return 'bottomSheet';
      case SurveyDisplayType.fullScreen:
        return 'fullScreen';
    }
  }
}

extension SurveyDisplayTypeMapperExtension on SurveyDisplayType {
  String toValue() {
    SurveyDisplayTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SurveyDisplayType>(this) as String;
  }
}

class SurveyIndicationTypeMapper extends EnumMapper<SurveyIndicationType> {
  SurveyIndicationTypeMapper._();

  static SurveyIndicationTypeMapper? _instance;
  static SurveyIndicationTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyIndicationTypeMapper._());
    }
    return _instance!;
  }

  static SurveyIndicationType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SurveyIndicationType decode(dynamic value) {
    switch (value) {
      case 'floatingButton':
        return SurveyIndicationType.floatingButton;
      case 'popupDialog':
        return SurveyIndicationType.popupDialog;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SurveyIndicationType self) {
    switch (self) {
      case SurveyIndicationType.floatingButton:
        return 'floatingButton';
      case SurveyIndicationType.popupDialog:
        return 'popupDialog';
    }
  }
}

extension SurveyIndicationTypeMapperExtension on SurveyIndicationType {
  String toValue() {
    SurveyIndicationTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SurveyIndicationType>(this)
        as String;
  }
}

class SurveyModelMapper extends ClassMapperBase<SurveyModel> {
  SurveyModelMapper._();

  static SurveyModelMapper? _instance;
  static SurveyModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SurveyModelMapper._());
      SurveyQuestionModelMapper.ensureInitialized();
      LocalizedTextMapper.ensureInitialized();
      SurveyDisplayOptionsModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SurveyModel';

  static String _$id(SurveyModel v) => v.id;
  static const Field<SurveyModel, String> _f$id = Field('id', _$id);
  static List<SurveyQuestionModel> _$questions(SurveyModel v) => v.questions;
  static const Field<SurveyModel, List<SurveyQuestionModel>> _f$questions =
      Field('questions', _$questions);
  static LocalizedText _$name(SurveyModel v) => v.name;
  static const Field<SurveyModel, LocalizedText> _f$name =
      Field('name', _$name);
  static DateTime _$createdAt(SurveyModel v) => v.createdAt;
  static const Field<SurveyModel, DateTime> _f$createdAt =
      Field('createdAt', _$createdAt);
  static LocalizedText? _$description(SurveyModel v) => v.description;
  static const Field<SurveyModel, LocalizedText> _f$description =
      Field('description', _$description, opt: true);
  static SurveyDisplayOptionsModel? _$displayOptions(SurveyModel v) =>
      v.displayOptions;
  static const Field<SurveyModel, SurveyDisplayOptionsModel> _f$displayOptions =
      Field('displayOptions', _$displayOptions, opt: true);
  static LocalizedText? _$finishedMessage(SurveyModel v) => v.finishedMessage;
  static const Field<SurveyModel, LocalizedText> _f$finishedMessage =
      Field('finishedMessage', _$finishedMessage, opt: true);

  @override
  final MappableFields<SurveyModel> fields = const {
    #id: _f$id,
    #questions: _f$questions,
    #name: _f$name,
    #createdAt: _f$createdAt,
    #description: _f$description,
    #displayOptions: _f$displayOptions,
    #finishedMessage: _f$finishedMessage,
  };

  static SurveyModel _instantiate(DecodingData data) {
    return SurveyModel(
        id: data.dec(_f$id),
        questions: data.dec(_f$questions),
        name: data.dec(_f$name),
        createdAt: data.dec(_f$createdAt),
        description: data.dec(_f$description),
        displayOptions: data.dec(_f$displayOptions),
        finishedMessage: data.dec(_f$finishedMessage));
  }

  @override
  final Function instantiate = _instantiate;

  static SurveyModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SurveyModel>(map);
  }

  static SurveyModel fromJson(String json) {
    return ensureInitialized().decodeJson<SurveyModel>(json);
  }
}

mixin SurveyModelMappable {
  String toJson() {
    return SurveyModelMapper.ensureInitialized()
        .encodeJson<SurveyModel>(this as SurveyModel);
  }

  Map<String, dynamic> toMap() {
    return SurveyModelMapper.ensureInitialized()
        .encodeMap<SurveyModel>(this as SurveyModel);
  }

  SurveyModelCopyWith<SurveyModel, SurveyModel, SurveyModel> get copyWith =>
      _SurveyModelCopyWithImpl(this as SurveyModel, $identity, $identity);
  @override
  String toString() {
    return SurveyModelMapper.ensureInitialized()
        .stringifyValue(this as SurveyModel);
  }

  @override
  bool operator ==(Object other) {
    return SurveyModelMapper.ensureInitialized()
        .equalsValue(this as SurveyModel, other);
  }

  @override
  int get hashCode {
    return SurveyModelMapper.ensureInitialized().hashValue(this as SurveyModel);
  }
}

extension SurveyModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SurveyModel, $Out> {
  SurveyModelCopyWith<$R, SurveyModel, $Out> get $asSurveyModel =>
      $base.as((v, t, t2) => _SurveyModelCopyWithImpl(v, t, t2));
}

abstract class SurveyModelCopyWith<$R, $In extends SurveyModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, SurveyQuestionModel,
          ObjectCopyWith<$R, SurveyQuestionModel, SurveyQuestionModel>>
      get questions;
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get name;
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText>? get description;
  SurveyDisplayOptionsModelCopyWith<$R, SurveyDisplayOptionsModel,
      SurveyDisplayOptionsModel>? get displayOptions;
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText>? get finishedMessage;
  $R call(
      {String? id,
      List<SurveyQuestionModel>? questions,
      LocalizedText? name,
      DateTime? createdAt,
      LocalizedText? description,
      SurveyDisplayOptionsModel? displayOptions,
      LocalizedText? finishedMessage});
  SurveyModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SurveyModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SurveyModel, $Out>
    implements SurveyModelCopyWith<$R, SurveyModel, $Out> {
  _SurveyModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SurveyModel> $mapper =
      SurveyModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, SurveyQuestionModel,
          ObjectCopyWith<$R, SurveyQuestionModel, SurveyQuestionModel>>
      get questions => ListCopyWith($value.questions,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(questions: v));
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText> get name =>
      $value.name.copyWith.$chain((v) => call(name: v));
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText>? get description =>
      $value.description?.copyWith.$chain((v) => call(description: v));
  @override
  SurveyDisplayOptionsModelCopyWith<$R, SurveyDisplayOptionsModel,
          SurveyDisplayOptionsModel>?
      get displayOptions => $value.displayOptions?.copyWith
          .$chain((v) => call(displayOptions: v));
  @override
  LocalizedTextCopyWith<$R, LocalizedText, LocalizedText>?
      get finishedMessage => $value.finishedMessage?.copyWith
          .$chain((v) => call(finishedMessage: v));
  @override
  $R call(
          {String? id,
          List<SurveyQuestionModel>? questions,
          LocalizedText? name,
          DateTime? createdAt,
          Object? description = $none,
          Object? displayOptions = $none,
          Object? finishedMessage = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (questions != null) #questions: questions,
        if (name != null) #name: name,
        if (createdAt != null) #createdAt: createdAt,
        if (description != $none) #description: description,
        if (displayOptions != $none) #displayOptions: displayOptions,
        if (finishedMessage != $none) #finishedMessage: finishedMessage
      }));
  @override
  SurveyModel $make(CopyWithData data) => SurveyModel(
      id: data.get(#id, or: $value.id),
      questions: data.get(#questions, or: $value.questions),
      name: data.get(#name, or: $value.name),
      createdAt: data.get(#createdAt, or: $value.createdAt),
      description: data.get(#description, or: $value.description),
      displayOptions: data.get(#displayOptions, or: $value.displayOptions),
      finishedMessage: data.get(#finishedMessage, or: $value.finishedMessage));

  @override
  SurveyModelCopyWith<$R2, SurveyModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SurveyModelCopyWithImpl($value, $cast, t);
}

class SurveyDisplayOptionsModelMapper
    extends ClassMapperBase<SurveyDisplayOptionsModel> {
  SurveyDisplayOptionsModelMapper._();

  static SurveyDisplayOptionsModelMapper? _instance;
  static SurveyDisplayOptionsModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = SurveyDisplayOptionsModelMapper._());
      SurveyDisplayTypeMapper.ensureInitialized();
      SurveyIndicationTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SurveyDisplayOptionsModel';

  static bool _$showProgressBar(SurveyDisplayOptionsModel v) =>
      v.showProgressBar;
  static const Field<SurveyDisplayOptionsModel, bool> _f$showProgressBar =
      Field('showProgressBar', _$showProgressBar, opt: true, def: true);
  static bool _$showQuestionNumber(SurveyDisplayOptionsModel v) =>
      v.showQuestionNumber;
  static const Field<SurveyDisplayOptionsModel, bool> _f$showQuestionNumber =
      Field('showQuestionNumber', _$showQuestionNumber, opt: true, def: true);
  static SurveyDisplayType _$displayType(SurveyDisplayOptionsModel v) =>
      v.displayType;
  static const Field<SurveyDisplayOptionsModel, SurveyDisplayType>
      _f$displayType = Field('displayType', _$displayType,
          opt: true, def: SurveyDisplayType.bottomSheet);
  static SurveyIndicationType _$indicationType(SurveyDisplayOptionsModel v) =>
      v.indicationType;
  static const Field<SurveyDisplayOptionsModel, SurveyIndicationType>
      _f$indicationType = Field('indicationType', _$indicationType,
          opt: true, def: SurveyIndicationType.floatingButton);

  @override
  final MappableFields<SurveyDisplayOptionsModel> fields = const {
    #showProgressBar: _f$showProgressBar,
    #showQuestionNumber: _f$showQuestionNumber,
    #displayType: _f$displayType,
    #indicationType: _f$indicationType,
  };

  static SurveyDisplayOptionsModel _instantiate(DecodingData data) {
    return SurveyDisplayOptionsModel(
        showProgressBar: data.dec(_f$showProgressBar),
        showQuestionNumber: data.dec(_f$showQuestionNumber),
        displayType: data.dec(_f$displayType),
        indicationType: data.dec(_f$indicationType));
  }

  @override
  final Function instantiate = _instantiate;

  static SurveyDisplayOptionsModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SurveyDisplayOptionsModel>(map);
  }

  static SurveyDisplayOptionsModel fromJson(String json) {
    return ensureInitialized().decodeJson<SurveyDisplayOptionsModel>(json);
  }
}

mixin SurveyDisplayOptionsModelMappable {
  String toJson() {
    return SurveyDisplayOptionsModelMapper.ensureInitialized()
        .encodeJson<SurveyDisplayOptionsModel>(
            this as SurveyDisplayOptionsModel);
  }

  Map<String, dynamic> toMap() {
    return SurveyDisplayOptionsModelMapper.ensureInitialized()
        .encodeMap<SurveyDisplayOptionsModel>(
            this as SurveyDisplayOptionsModel);
  }

  SurveyDisplayOptionsModelCopyWith<SurveyDisplayOptionsModel,
          SurveyDisplayOptionsModel, SurveyDisplayOptionsModel>
      get copyWith => _SurveyDisplayOptionsModelCopyWithImpl(
          this as SurveyDisplayOptionsModel, $identity, $identity);
  @override
  String toString() {
    return SurveyDisplayOptionsModelMapper.ensureInitialized()
        .stringifyValue(this as SurveyDisplayOptionsModel);
  }

  @override
  bool operator ==(Object other) {
    return SurveyDisplayOptionsModelMapper.ensureInitialized()
        .equalsValue(this as SurveyDisplayOptionsModel, other);
  }

  @override
  int get hashCode {
    return SurveyDisplayOptionsModelMapper.ensureInitialized()
        .hashValue(this as SurveyDisplayOptionsModel);
  }
}

extension SurveyDisplayOptionsModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SurveyDisplayOptionsModel, $Out> {
  SurveyDisplayOptionsModelCopyWith<$R, SurveyDisplayOptionsModel, $Out>
      get $asSurveyDisplayOptionsModel => $base
          .as((v, t, t2) => _SurveyDisplayOptionsModelCopyWithImpl(v, t, t2));
}

abstract class SurveyDisplayOptionsModelCopyWith<
    $R,
    $In extends SurveyDisplayOptionsModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {bool? showProgressBar,
      bool? showQuestionNumber,
      SurveyDisplayType? displayType,
      SurveyIndicationType? indicationType});
  SurveyDisplayOptionsModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SurveyDisplayOptionsModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SurveyDisplayOptionsModel, $Out>
    implements
        SurveyDisplayOptionsModelCopyWith<$R, SurveyDisplayOptionsModel, $Out> {
  _SurveyDisplayOptionsModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SurveyDisplayOptionsModel> $mapper =
      SurveyDisplayOptionsModelMapper.ensureInitialized();
  @override
  $R call(
          {bool? showProgressBar,
          bool? showQuestionNumber,
          SurveyDisplayType? displayType,
          SurveyIndicationType? indicationType}) =>
      $apply(FieldCopyWithData({
        if (showProgressBar != null) #showProgressBar: showProgressBar,
        if (showQuestionNumber != null) #showQuestionNumber: showQuestionNumber,
        if (displayType != null) #displayType: displayType,
        if (indicationType != null) #indicationType: indicationType
      }));
  @override
  SurveyDisplayOptionsModel $make(CopyWithData data) =>
      SurveyDisplayOptionsModel(
          showProgressBar:
              data.get(#showProgressBar, or: $value.showProgressBar),
          showQuestionNumber:
              data.get(#showQuestionNumber, or: $value.showQuestionNumber),
          displayType: data.get(#displayType, or: $value.displayType),
          indicationType: data.get(#indicationType, or: $value.indicationType));

  @override
  SurveyDisplayOptionsModelCopyWith<$R2, SurveyDisplayOptionsModel, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SurveyDisplayOptionsModelCopyWithImpl($value, $cast, t);
}
