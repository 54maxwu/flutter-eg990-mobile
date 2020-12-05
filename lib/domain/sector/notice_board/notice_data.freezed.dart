// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'notice_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$NoticeDataTearOff {
  const _$NoticeDataTearOff();

// ignore: unused_element
  _NoticeData call(
      {@JsonKey(name: 'content_cn') String content,
      String date,
      int sort,
      int typeId}) {
    return _NoticeData(
      content: content,
      date: date,
      sort: sort,
      typeId: typeId,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $NoticeData = _$NoticeDataTearOff();

/// @nodoc
mixin _$NoticeData {
  @JsonKey(name: 'content_cn')
  String get content;
  String get date;
  int get sort;
  int get typeId;

  $NoticeDataCopyWith<NoticeData> get copyWith;
}

/// @nodoc
abstract class $NoticeDataCopyWith<$Res> {
  factory $NoticeDataCopyWith(
          NoticeData value, $Res Function(NoticeData) then) =
      _$NoticeDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'content_cn') String content,
      String date,
      int sort,
      int typeId});
}

/// @nodoc
class _$NoticeDataCopyWithImpl<$Res> implements $NoticeDataCopyWith<$Res> {
  _$NoticeDataCopyWithImpl(this._value, this._then);

  final NoticeData _value;
  // ignore: unused_field
  final $Res Function(NoticeData) _then;

  @override
  $Res call({
    Object content = freezed,
    Object date = freezed,
    Object sort = freezed,
    Object typeId = freezed,
  }) {
    return _then(_value.copyWith(
      content: content == freezed ? _value.content : content as String,
      date: date == freezed ? _value.date : date as String,
      sort: sort == freezed ? _value.sort : sort as int,
      typeId: typeId == freezed ? _value.typeId : typeId as int,
    ));
  }
}

/// @nodoc
abstract class _$NoticeDataCopyWith<$Res> implements $NoticeDataCopyWith<$Res> {
  factory _$NoticeDataCopyWith(
          _NoticeData value, $Res Function(_NoticeData) then) =
      __$NoticeDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'content_cn') String content,
      String date,
      int sort,
      int typeId});
}

/// @nodoc
class __$NoticeDataCopyWithImpl<$Res> extends _$NoticeDataCopyWithImpl<$Res>
    implements _$NoticeDataCopyWith<$Res> {
  __$NoticeDataCopyWithImpl(
      _NoticeData _value, $Res Function(_NoticeData) _then)
      : super(_value, (v) => _then(v as _NoticeData));

  @override
  _NoticeData get _value => super._value as _NoticeData;

  @override
  $Res call({
    Object content = freezed,
    Object date = freezed,
    Object sort = freezed,
    Object typeId = freezed,
  }) {
    return _then(_NoticeData(
      content: content == freezed ? _value.content : content as String,
      date: date == freezed ? _value.date : date as String,
      sort: sort == freezed ? _value.sort : sort as int,
      typeId: typeId == freezed ? _value.typeId : typeId as int,
    ));
  }
}

/// @nodoc
class _$_NoticeData implements _NoticeData {
  const _$_NoticeData(
      {@JsonKey(name: 'content_cn') this.content,
      this.date,
      this.sort,
      this.typeId});

  @override
  @JsonKey(name: 'content_cn')
  final String content;
  @override
  final String date;
  @override
  final int sort;
  @override
  final int typeId;

  @override
  String toString() {
    return 'NoticeData(content: $content, date: $date, sort: $sort, typeId: $typeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NoticeData &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.typeId, typeId) ||
                const DeepCollectionEquality().equals(other.typeId, typeId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(typeId);

  @override
  _$NoticeDataCopyWith<_NoticeData> get copyWith =>
      __$NoticeDataCopyWithImpl<_NoticeData>(this, _$identity);
}

abstract class _NoticeData implements NoticeData {
  const factory _NoticeData(
      {@JsonKey(name: 'content_cn') String content,
      String date,
      int sort,
      int typeId}) = _$_NoticeData;

  @override
  @JsonKey(name: 'content_cn')
  String get content;
  @override
  String get date;
  @override
  int get sort;
  @override
  int get typeId;
  @override
  _$NoticeDataCopyWith<_NoticeData> get copyWith;
}
