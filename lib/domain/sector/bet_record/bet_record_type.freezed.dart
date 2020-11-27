// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bet_record_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BetRecordTypeTearOff {
  const _$BetRecordTypeTearOff();

// ignore: unused_element
  _BetRecordType call(
      {@JsonKey(name: 'id')
          int categoryId,
      @Deprecated('use label getter instead')
      @JsonKey(name: 'ch')
          String categoryName,
      @JsonKey(name: 'type')
          String categoryType,
      Map<String, dynamic> platformMap}) {
    return _BetRecordType(
      categoryId: categoryId,
      categoryName: categoryName,
      categoryType: categoryType,
      platformMap: platformMap,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BetRecordType = _$BetRecordTypeTearOff();

/// @nodoc
mixin _$BetRecordType {
  @JsonKey(name: 'id')
  int get categoryId;
  @Deprecated('use label getter instead')
  @JsonKey(name: 'ch')
  String get categoryName;
  @JsonKey(name: 'type')
  String get categoryType;
  Map<String, dynamic> get platformMap;

  $BetRecordTypeCopyWith<BetRecordType> get copyWith;
}

/// @nodoc
abstract class $BetRecordTypeCopyWith<$Res> {
  factory $BetRecordTypeCopyWith(
          BetRecordType value, $Res Function(BetRecordType) then) =
      _$BetRecordTypeCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id')
          int categoryId,
      @Deprecated('use label getter instead')
      @JsonKey(name: 'ch')
          String categoryName,
      @JsonKey(name: 'type')
          String categoryType,
      Map<String, dynamic> platformMap});
}

/// @nodoc
class _$BetRecordTypeCopyWithImpl<$Res>
    implements $BetRecordTypeCopyWith<$Res> {
  _$BetRecordTypeCopyWithImpl(this._value, this._then);

  final BetRecordType _value;
  // ignore: unused_field
  final $Res Function(BetRecordType) _then;

  @override
  $Res call({
    Object categoryId = freezed,
    Object categoryName = freezed,
    Object categoryType = freezed,
    Object platformMap = freezed,
  }) {
    return _then(_value.copyWith(
      categoryId: categoryId == freezed ? _value.categoryId : categoryId as int,
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName as String,
      categoryType: categoryType == freezed
          ? _value.categoryType
          : categoryType as String,
      platformMap: platformMap == freezed
          ? _value.platformMap
          : platformMap as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
abstract class _$BetRecordTypeCopyWith<$Res>
    implements $BetRecordTypeCopyWith<$Res> {
  factory _$BetRecordTypeCopyWith(
          _BetRecordType value, $Res Function(_BetRecordType) then) =
      __$BetRecordTypeCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id')
          int categoryId,
      @Deprecated('use label getter instead')
      @JsonKey(name: 'ch')
          String categoryName,
      @JsonKey(name: 'type')
          String categoryType,
      Map<String, dynamic> platformMap});
}

/// @nodoc
class __$BetRecordTypeCopyWithImpl<$Res>
    extends _$BetRecordTypeCopyWithImpl<$Res>
    implements _$BetRecordTypeCopyWith<$Res> {
  __$BetRecordTypeCopyWithImpl(
      _BetRecordType _value, $Res Function(_BetRecordType) _then)
      : super(_value, (v) => _then(v as _BetRecordType));

  @override
  _BetRecordType get _value => super._value as _BetRecordType;

  @override
  $Res call({
    Object categoryId = freezed,
    Object categoryName = freezed,
    Object categoryType = freezed,
    Object platformMap = freezed,
  }) {
    return _then(_BetRecordType(
      categoryId: categoryId == freezed ? _value.categoryId : categoryId as int,
      categoryName: categoryName == freezed
          ? _value.categoryName
          : categoryName as String,
      categoryType: categoryType == freezed
          ? _value.categoryType
          : categoryType as String,
      platformMap: platformMap == freezed
          ? _value.platformMap
          : platformMap as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
class _$_BetRecordType extends _BetRecordType {
  const _$_BetRecordType(
      {@JsonKey(name: 'id')
          this.categoryId,
      @Deprecated('use label getter instead')
      @JsonKey(name: 'ch')
          this.categoryName,
      @JsonKey(name: 'type')
          this.categoryType,
      this.platformMap})
      : super._();

  @override
  @JsonKey(name: 'id')
  final int categoryId;
  @override
  @Deprecated('use label getter instead')
  @JsonKey(name: 'ch')
  final String categoryName;
  @override
  @JsonKey(name: 'type')
  final String categoryType;
  @override
  final Map<String, dynamic> platformMap;

  @override
  String toString() {
    return 'BetRecordType(categoryId: $categoryId, categoryName: $categoryName, categoryType: $categoryType, platformMap: $platformMap)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BetRecordType &&
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.categoryName, categoryName) ||
                const DeepCollectionEquality()
                    .equals(other.categoryName, categoryName)) &&
            (identical(other.categoryType, categoryType) ||
                const DeepCollectionEquality()
                    .equals(other.categoryType, categoryType)) &&
            (identical(other.platformMap, platformMap) ||
                const DeepCollectionEquality()
                    .equals(other.platformMap, platformMap)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(categoryName) ^
      const DeepCollectionEquality().hash(categoryType) ^
      const DeepCollectionEquality().hash(platformMap);

  @override
  _$BetRecordTypeCopyWith<_BetRecordType> get copyWith =>
      __$BetRecordTypeCopyWithImpl<_BetRecordType>(this, _$identity);
}

abstract class _BetRecordType extends BetRecordType {
  const _BetRecordType._() : super._();
  const factory _BetRecordType(
      {@JsonKey(name: 'id')
          int categoryId,
      @Deprecated('use label getter instead')
      @JsonKey(name: 'ch')
          String categoryName,
      @JsonKey(name: 'type')
          String categoryType,
      Map<String, dynamic> platformMap}) = _$_BetRecordType;

  @override
  @JsonKey(name: 'id')
  int get categoryId;
  @override
  @Deprecated('use label getter instead')
  @JsonKey(name: 'ch')
  String get categoryName;
  @override
  @JsonKey(name: 'type')
  String get categoryType;
  @override
  Map<String, dynamic> get platformMap;
  @override
  _$BetRecordTypeCopyWith<_BetRecordType> get copyWith;
}
