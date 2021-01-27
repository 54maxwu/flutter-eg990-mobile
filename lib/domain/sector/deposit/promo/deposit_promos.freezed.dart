// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'deposit_promos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DepositPromosTearOff {
  const _$DepositPromosTearOff();

// ignore: unused_element
  _DepositPromos call(
      {@JsonKey(name: '1', fromJson: decodeDepositPromos)
          List<DepositPromoData> local,
      @JsonKey(name: '2', fromJson: decodeDepositPromos)
          List<DepositPromoData> other}) {
    return _DepositPromos(
      local: local,
      other: other,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DepositPromos = _$DepositPromosTearOff();

/// @nodoc
mixin _$DepositPromos {
  @JsonKey(name: '1', fromJson: decodeDepositPromos)
  List<DepositPromoData> get local;
  @JsonKey(name: '2', fromJson: decodeDepositPromos)
  List<DepositPromoData> get other;

  @JsonKey(ignore: true)
  $DepositPromosCopyWith<DepositPromos> get copyWith;
}

/// @nodoc
abstract class $DepositPromosCopyWith<$Res> {
  factory $DepositPromosCopyWith(
          DepositPromos value, $Res Function(DepositPromos) then) =
      _$DepositPromosCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: '1', fromJson: decodeDepositPromos)
          List<DepositPromoData> local,
      @JsonKey(name: '2', fromJson: decodeDepositPromos)
          List<DepositPromoData> other});
}

/// @nodoc
class _$DepositPromosCopyWithImpl<$Res>
    implements $DepositPromosCopyWith<$Res> {
  _$DepositPromosCopyWithImpl(this._value, this._then);

  final DepositPromos _value;
  // ignore: unused_field
  final $Res Function(DepositPromos) _then;

  @override
  $Res call({
    Object local = freezed,
    Object other = freezed,
  }) {
    return _then(_value.copyWith(
      local: local == freezed ? _value.local : local as List<DepositPromoData>,
      other: other == freezed ? _value.other : other as List<DepositPromoData>,
    ));
  }
}

/// @nodoc
abstract class _$DepositPromosCopyWith<$Res>
    implements $DepositPromosCopyWith<$Res> {
  factory _$DepositPromosCopyWith(
          _DepositPromos value, $Res Function(_DepositPromos) then) =
      __$DepositPromosCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: '1', fromJson: decodeDepositPromos)
          List<DepositPromoData> local,
      @JsonKey(name: '2', fromJson: decodeDepositPromos)
          List<DepositPromoData> other});
}

/// @nodoc
class __$DepositPromosCopyWithImpl<$Res>
    extends _$DepositPromosCopyWithImpl<$Res>
    implements _$DepositPromosCopyWith<$Res> {
  __$DepositPromosCopyWithImpl(
      _DepositPromos _value, $Res Function(_DepositPromos) _then)
      : super(_value, (v) => _then(v as _DepositPromos));

  @override
  _DepositPromos get _value => super._value as _DepositPromos;

  @override
  $Res call({
    Object local = freezed,
    Object other = freezed,
  }) {
    return _then(_DepositPromos(
      local: local == freezed ? _value.local : local as List<DepositPromoData>,
      other: other == freezed ? _value.other : other as List<DepositPromoData>,
    ));
  }
}

/// @nodoc
class _$_DepositPromos implements _DepositPromos {
  const _$_DepositPromos(
      {@JsonKey(name: '1', fromJson: decodeDepositPromos) this.local,
      @JsonKey(name: '2', fromJson: decodeDepositPromos) this.other});

  @override
  @JsonKey(name: '1', fromJson: decodeDepositPromos)
  final List<DepositPromoData> local;
  @override
  @JsonKey(name: '2', fromJson: decodeDepositPromos)
  final List<DepositPromoData> other;

  @override
  String toString() {
    return 'DepositPromos(local: $local, other: $other)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DepositPromos &&
            (identical(other.local, local) ||
                const DeepCollectionEquality().equals(other.local, local)) &&
            (identical(other.other, this.other) ||
                const DeepCollectionEquality()
                    .equals(other.other, this.other)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(local) ^
      const DeepCollectionEquality().hash(other);

  @JsonKey(ignore: true)
  @override
  _$DepositPromosCopyWith<_DepositPromos> get copyWith =>
      __$DepositPromosCopyWithImpl<_DepositPromos>(this, _$identity);
}

abstract class _DepositPromos implements DepositPromos {
  const factory _DepositPromos(
      {@JsonKey(name: '1', fromJson: decodeDepositPromos)
          List<DepositPromoData> local,
      @JsonKey(name: '2', fromJson: decodeDepositPromos)
          List<DepositPromoData> other}) = _$_DepositPromos;

  @override
  @JsonKey(name: '1', fromJson: decodeDepositPromos)
  List<DepositPromoData> get local;
  @override
  @JsonKey(name: '2', fromJson: decodeDepositPromos)
  List<DepositPromoData> get other;
  @override
  @JsonKey(ignore: true)
  _$DepositPromosCopyWith<_DepositPromos> get copyWith;
}
