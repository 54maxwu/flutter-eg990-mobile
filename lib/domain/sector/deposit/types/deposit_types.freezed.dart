// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'deposit_types.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DepositTypeTearOff {
  const _$DepositTypeTearOff();

// ignore: unused_element
  _DepositType call({@required int key, List<DepositMethod> dataList}) {
    return _DepositType(
      key: key,
      dataList: dataList,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DepositType = _$DepositTypeTearOff();

/// @nodoc
mixin _$DepositType {
  int get key;
  List<DepositMethod> get dataList;

  @JsonKey(ignore: true)
  $DepositTypeCopyWith<DepositType> get copyWith;
}

/// @nodoc
abstract class $DepositTypeCopyWith<$Res> {
  factory $DepositTypeCopyWith(
          DepositType value, $Res Function(DepositType) then) =
      _$DepositTypeCopyWithImpl<$Res>;
  $Res call({int key, List<DepositMethod> dataList});
}

/// @nodoc
class _$DepositTypeCopyWithImpl<$Res> implements $DepositTypeCopyWith<$Res> {
  _$DepositTypeCopyWithImpl(this._value, this._then);

  final DepositType _value;
  // ignore: unused_field
  final $Res Function(DepositType) _then;

  @override
  $Res call({
    Object key = freezed,
    Object dataList = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as int,
      dataList: dataList == freezed
          ? _value.dataList
          : dataList as List<DepositMethod>,
    ));
  }
}

/// @nodoc
abstract class _$DepositTypeCopyWith<$Res>
    implements $DepositTypeCopyWith<$Res> {
  factory _$DepositTypeCopyWith(
          _DepositType value, $Res Function(_DepositType) then) =
      __$DepositTypeCopyWithImpl<$Res>;
  @override
  $Res call({int key, List<DepositMethod> dataList});
}

/// @nodoc
class __$DepositTypeCopyWithImpl<$Res> extends _$DepositTypeCopyWithImpl<$Res>
    implements _$DepositTypeCopyWith<$Res> {
  __$DepositTypeCopyWithImpl(
      _DepositType _value, $Res Function(_DepositType) _then)
      : super(_value, (v) => _then(v as _DepositType));

  @override
  _DepositType get _value => super._value as _DepositType;

  @override
  $Res call({
    Object key = freezed,
    Object dataList = freezed,
  }) {
    return _then(_DepositType(
      key: key == freezed ? _value.key : key as int,
      dataList: dataList == freezed
          ? _value.dataList
          : dataList as List<DepositMethod>,
    ));
  }
}

/// @nodoc
class _$_DepositType extends _DepositType {
  const _$_DepositType({@required this.key, this.dataList})
      : assert(key != null),
        super._();

  @override
  final int key;
  @override
  final List<DepositMethod> dataList;

  @override
  String toString() {
    return 'DepositType(key: $key, dataList: $dataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DepositType &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.dataList, dataList) ||
                const DeepCollectionEquality()
                    .equals(other.dataList, dataList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(dataList);

  @JsonKey(ignore: true)
  @override
  _$DepositTypeCopyWith<_DepositType> get copyWith =>
      __$DepositTypeCopyWithImpl<_DepositType>(this, _$identity);
}

abstract class _DepositType extends DepositType {
  const _DepositType._() : super._();
  const factory _DepositType(
      {@required int key, List<DepositMethod> dataList}) = _$_DepositType;

  @override
  int get key;
  @override
  List<DepositMethod> get dataList;
  @override
  @JsonKey(ignore: true)
  _$DepositTypeCopyWith<_DepositType> get copyWith;
}
