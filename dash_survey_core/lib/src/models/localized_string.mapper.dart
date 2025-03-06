// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'localized_string.dart';

class LocalizedTextMapper extends ClassMapperBase<LocalizedText> {
  LocalizedTextMapper._();

  static LocalizedTextMapper? _instance;
  static LocalizedTextMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalizedTextMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalizedText';

  static Map<LocaleCode, String> _$data(LocalizedText v) => v.data;
  static const Field<LocalizedText, Map<LocaleCode, String>> _f$data =
      Field('data', _$data);

  @override
  final MappableFields<LocalizedText> fields = const {
    #data: _f$data,
  };

  static LocalizedText _instantiate(DecodingData data) {
    return LocalizedText(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalizedText fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalizedText>(map);
  }

  static LocalizedText fromJson(String json) {
    return ensureInitialized().decodeJson<LocalizedText>(json);
  }
}

mixin LocalizedTextMappable {
  String toJson() {
    return LocalizedTextMapper.ensureInitialized()
        .encodeJson<LocalizedText>(this as LocalizedText);
  }

  Map<String, dynamic> toMap() {
    return LocalizedTextMapper.ensureInitialized()
        .encodeMap<LocalizedText>(this as LocalizedText);
  }

  LocalizedTextCopyWith<LocalizedText, LocalizedText, LocalizedText>
      get copyWith => _LocalizedTextCopyWithImpl(
          this as LocalizedText, $identity, $identity);
  @override
  String toString() {
    return LocalizedTextMapper.ensureInitialized()
        .stringifyValue(this as LocalizedText);
  }

  @override
  bool operator ==(Object other) {
    return LocalizedTextMapper.ensureInitialized()
        .equalsValue(this as LocalizedText, other);
  }

  @override
  int get hashCode {
    return LocalizedTextMapper.ensureInitialized()
        .hashValue(this as LocalizedText);
  }
}

extension LocalizedTextValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalizedText, $Out> {
  LocalizedTextCopyWith<$R, LocalizedText, $Out> get $asLocalizedText =>
      $base.as((v, t, t2) => _LocalizedTextCopyWithImpl(v, t, t2));
}

abstract class LocalizedTextCopyWith<$R, $In extends LocalizedText, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, LocaleCode, String, ObjectCopyWith<$R, String, String>>
      get data;
  $R call({Map<LocaleCode, String>? data});
  LocalizedTextCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalizedTextCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalizedText, $Out>
    implements LocalizedTextCopyWith<$R, LocalizedText, $Out> {
  _LocalizedTextCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalizedText> $mapper =
      LocalizedTextMapper.ensureInitialized();
  @override
  MapCopyWith<$R, LocaleCode, String, ObjectCopyWith<$R, String, String>>
      get data => MapCopyWith($value.data,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(data: v));
  @override
  $R call({Map<LocaleCode, String>? data}) =>
      $apply(FieldCopyWithData({if (data != null) #data: data}));
  @override
  LocalizedText $make(CopyWithData data) =>
      LocalizedText(data.get(#data, or: $value.data));

  @override
  LocalizedTextCopyWith<$R2, LocalizedText, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalizedTextCopyWithImpl($value, $cast, t);
}

class LocalizedTextMapMapper extends ClassMapperBase<LocalizedTextMap> {
  LocalizedTextMapMapper._();

  static LocalizedTextMapMapper? _instance;
  static LocalizedTextMapMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalizedTextMapMapper._());
      LocalizedTextMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalizedTextMap';

  static LinkedHashMap<String, LocalizedText>? _$data(LocalizedTextMap v) =>
      v.data;
  static const Field<LocalizedTextMap, LinkedHashMap<String, LocalizedText>>
      _f$data = Field('data', _$data, hook: LinkedHashMapHook());

  @override
  final MappableFields<LocalizedTextMap> fields = const {
    #data: _f$data,
  };

  static LocalizedTextMap _instantiate(DecodingData data) {
    return LocalizedTextMap(data.dec(_f$data));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalizedTextMap fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalizedTextMap>(map);
  }

  static LocalizedTextMap fromJson(String json) {
    return ensureInitialized().decodeJson<LocalizedTextMap>(json);
  }
}

mixin LocalizedTextMapMappable {
  String toJson() {
    return LocalizedTextMapMapper.ensureInitialized()
        .encodeJson<LocalizedTextMap>(this as LocalizedTextMap);
  }

  Map<String, dynamic> toMap() {
    return LocalizedTextMapMapper.ensureInitialized()
        .encodeMap<LocalizedTextMap>(this as LocalizedTextMap);
  }

  LocalizedTextMapCopyWith<LocalizedTextMap, LocalizedTextMap, LocalizedTextMap>
      get copyWith => _LocalizedTextMapCopyWithImpl(
          this as LocalizedTextMap, $identity, $identity);
  @override
  String toString() {
    return LocalizedTextMapMapper.ensureInitialized()
        .stringifyValue(this as LocalizedTextMap);
  }

  @override
  bool operator ==(Object other) {
    return LocalizedTextMapMapper.ensureInitialized()
        .equalsValue(this as LocalizedTextMap, other);
  }

  @override
  int get hashCode {
    return LocalizedTextMapMapper.ensureInitialized()
        .hashValue(this as LocalizedTextMap);
  }
}

extension LocalizedTextMapValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalizedTextMap, $Out> {
  LocalizedTextMapCopyWith<$R, LocalizedTextMap, $Out>
      get $asLocalizedTextMap =>
          $base.as((v, t, t2) => _LocalizedTextMapCopyWithImpl(v, t, t2));
}

abstract class LocalizedTextMapCopyWith<$R, $In extends LocalizedTextMap, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({LinkedHashMap<String, LocalizedText>? data});
  LocalizedTextMapCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LocalizedTextMapCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalizedTextMap, $Out>
    implements LocalizedTextMapCopyWith<$R, LocalizedTextMap, $Out> {
  _LocalizedTextMapCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalizedTextMap> $mapper =
      LocalizedTextMapMapper.ensureInitialized();
  @override
  $R call({Object? data = $none}) =>
      $apply(FieldCopyWithData({if (data != $none) #data: data}));
  @override
  LocalizedTextMap $make(CopyWithData data) =>
      LocalizedTextMap(data.get(#data, or: $value.data));

  @override
  LocalizedTextMapCopyWith<$R2, LocalizedTextMap, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalizedTextMapCopyWithImpl($value, $cast, t);
}
