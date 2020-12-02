// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'deposit_promo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
DepositPromoModel _$DepositPromoModelFromJson(Map<String, dynamic> json) {
  return _DepositPromoModel.fromJson(json);
}

/// @nodoc
class _$DepositPromoModelTearOff {
  const _$DepositPromoModelTearOff();

// ignore: unused_element
  _DepositPromoModel call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc,
      @JsonKey(name: 'min_deposit')
          int minDeposit,
      String type,
      @JsonKey(fromJson: _decodePercentageAsInt)
          int percentage,
      @JsonKey(name: 'max_promo_amt')
          int maxPromoAmt,
      int multiply,
      String dtype,
      dynamic sequence,
      @JsonKey(name: 'featureindex')
          String featureIndex}) {
    return _DepositPromoModel(
      promoId: promoId,
      promoDesc: promoDesc,
      minDeposit: minDeposit,
      type: type,
      percentage: percentage,
      maxPromoAmt: maxPromoAmt,
      multiply: multiply,
      dtype: dtype,
      sequence: sequence,
      featureIndex: featureIndex,
    );
  }

// ignore: unused_element
  DepositPromoModel fromJson(Map<String, Object> json) {
    return DepositPromoModel.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $DepositPromoModel = _$DepositPromoModelTearOff();

/// @nodoc
mixin _$DepositPromoModel {
  @JsonKey(name: 'promoid', required: true)
  int get promoId;
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  String get promoDesc;
  @JsonKey(name: 'min_deposit')
  int get minDeposit;
  String get type;
  @JsonKey(fromJson: _decodePercentageAsInt)
  int get percentage;
  @JsonKey(name: 'max_promo_amt')
  int get maxPromoAmt;
  int get multiply;
  String get dtype;
  dynamic get sequence;
  @JsonKey(name: 'featureindex')
  String get featureIndex;

  Map<String, dynamic> toJson();
  $DepositPromoModelCopyWith<DepositPromoModel> get copyWith;
}

/// @nodoc
abstract class $DepositPromoModelCopyWith<$Res> {
  factory $DepositPromoModelCopyWith(
          DepositPromoModel value, $Res Function(DepositPromoModel) then) =
      _$DepositPromoModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc,
      @JsonKey(name: 'min_deposit')
          int minDeposit,
      String type,
      @JsonKey(fromJson: _decodePercentageAsInt)
          int percentage,
      @JsonKey(name: 'max_promo_amt')
          int maxPromoAmt,
      int multiply,
      String dtype,
      dynamic sequence,
      @JsonKey(name: 'featureindex')
          String featureIndex});
}

/// @nodoc
class _$DepositPromoModelCopyWithImpl<$Res>
    implements $DepositPromoModelCopyWith<$Res> {
  _$DepositPromoModelCopyWithImpl(this._value, this._then);

  final DepositPromoModel _value;
  // ignore: unused_field
  final $Res Function(DepositPromoModel) _then;

  @override
  $Res call({
    Object promoId = freezed,
    Object promoDesc = freezed,
    Object minDeposit = freezed,
    Object type = freezed,
    Object percentage = freezed,
    Object maxPromoAmt = freezed,
    Object multiply = freezed,
    Object dtype = freezed,
    Object sequence = freezed,
    Object featureIndex = freezed,
  }) {
    return _then(_value.copyWith(
      promoId: promoId == freezed ? _value.promoId : promoId as int,
      promoDesc: promoDesc == freezed ? _value.promoDesc : promoDesc as String,
      minDeposit: minDeposit == freezed ? _value.minDeposit : minDeposit as int,
      type: type == freezed ? _value.type : type as String,
      percentage: percentage == freezed ? _value.percentage : percentage as int,
      maxPromoAmt:
          maxPromoAmt == freezed ? _value.maxPromoAmt : maxPromoAmt as int,
      multiply: multiply == freezed ? _value.multiply : multiply as int,
      dtype: dtype == freezed ? _value.dtype : dtype as String,
      sequence: sequence == freezed ? _value.sequence : sequence as dynamic,
      featureIndex: featureIndex == freezed
          ? _value.featureIndex
          : featureIndex as String,
    ));
  }
}

/// @nodoc
abstract class _$DepositPromoModelCopyWith<$Res>
    implements $DepositPromoModelCopyWith<$Res> {
  factory _$DepositPromoModelCopyWith(
          _DepositPromoModel value, $Res Function(_DepositPromoModel) then) =
      __$DepositPromoModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc,
      @JsonKey(name: 'min_deposit')
          int minDeposit,
      String type,
      @JsonKey(fromJson: _decodePercentageAsInt)
          int percentage,
      @JsonKey(name: 'max_promo_amt')
          int maxPromoAmt,
      int multiply,
      String dtype,
      dynamic sequence,
      @JsonKey(name: 'featureindex')
          String featureIndex});
}

/// @nodoc
class __$DepositPromoModelCopyWithImpl<$Res>
    extends _$DepositPromoModelCopyWithImpl<$Res>
    implements _$DepositPromoModelCopyWith<$Res> {
  __$DepositPromoModelCopyWithImpl(
      _DepositPromoModel _value, $Res Function(_DepositPromoModel) _then)
      : super(_value, (v) => _then(v as _DepositPromoModel));

  @override
  _DepositPromoModel get _value => super._value as _DepositPromoModel;

  @override
  $Res call({
    Object promoId = freezed,
    Object promoDesc = freezed,
    Object minDeposit = freezed,
    Object type = freezed,
    Object percentage = freezed,
    Object maxPromoAmt = freezed,
    Object multiply = freezed,
    Object dtype = freezed,
    Object sequence = freezed,
    Object featureIndex = freezed,
  }) {
    return _then(_DepositPromoModel(
      promoId: promoId == freezed ? _value.promoId : promoId as int,
      promoDesc: promoDesc == freezed ? _value.promoDesc : promoDesc as String,
      minDeposit: minDeposit == freezed ? _value.minDeposit : minDeposit as int,
      type: type == freezed ? _value.type : type as String,
      percentage: percentage == freezed ? _value.percentage : percentage as int,
      maxPromoAmt:
          maxPromoAmt == freezed ? _value.maxPromoAmt : maxPromoAmt as int,
      multiply: multiply == freezed ? _value.multiply : multiply as int,
      dtype: dtype == freezed ? _value.dtype : dtype as String,
      sequence: sequence == freezed ? _value.sequence : sequence as dynamic,
      featureIndex: featureIndex == freezed
          ? _value.featureIndex
          : featureIndex as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_DepositPromoModel implements _DepositPromoModel {
  const _$_DepositPromoModel(
      {@JsonKey(name: 'promoid', required: true)
          this.promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          this.promoDesc,
      @JsonKey(name: 'min_deposit')
          this.minDeposit,
      this.type,
      @JsonKey(fromJson: _decodePercentageAsInt)
          this.percentage,
      @JsonKey(name: 'max_promo_amt')
          this.maxPromoAmt,
      this.multiply,
      this.dtype,
      this.sequence,
      @JsonKey(name: 'featureindex')
          this.featureIndex});

  factory _$_DepositPromoModel.fromJson(Map<String, dynamic> json) =>
      _$_$_DepositPromoModelFromJson(json);

  @override
  @JsonKey(name: 'promoid', required: true)
  final int promoId;
  @override
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  final String promoDesc;
  @override
  @JsonKey(name: 'min_deposit')
  final int minDeposit;
  @override
  final String type;
  @override
  @JsonKey(fromJson: _decodePercentageAsInt)
  final int percentage;
  @override
  @JsonKey(name: 'max_promo_amt')
  final int maxPromoAmt;
  @override
  final int multiply;
  @override
  final String dtype;
  @override
  final dynamic sequence;
  @override
  @JsonKey(name: 'featureindex')
  final String featureIndex;

  @override
  String toString() {
    return 'DepositPromoModel(promoId: $promoId, promoDesc: $promoDesc, minDeposit: $minDeposit, type: $type, percentage: $percentage, maxPromoAmt: $maxPromoAmt, multiply: $multiply, dtype: $dtype, sequence: $sequence, featureIndex: $featureIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DepositPromoModel &&
            (identical(other.promoId, promoId) ||
                const DeepCollectionEquality()
                    .equals(other.promoId, promoId)) &&
            (identical(other.promoDesc, promoDesc) ||
                const DeepCollectionEquality()
                    .equals(other.promoDesc, promoDesc)) &&
            (identical(other.minDeposit, minDeposit) ||
                const DeepCollectionEquality()
                    .equals(other.minDeposit, minDeposit)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.percentage, percentage) ||
                const DeepCollectionEquality()
                    .equals(other.percentage, percentage)) &&
            (identical(other.maxPromoAmt, maxPromoAmt) ||
                const DeepCollectionEquality()
                    .equals(other.maxPromoAmt, maxPromoAmt)) &&
            (identical(other.multiply, multiply) ||
                const DeepCollectionEquality()
                    .equals(other.multiply, multiply)) &&
            (identical(other.dtype, dtype) ||
                const DeepCollectionEquality().equals(other.dtype, dtype)) &&
            (identical(other.sequence, sequence) ||
                const DeepCollectionEquality()
                    .equals(other.sequence, sequence)) &&
            (identical(other.featureIndex, featureIndex) ||
                const DeepCollectionEquality()
                    .equals(other.featureIndex, featureIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(promoId) ^
      const DeepCollectionEquality().hash(promoDesc) ^
      const DeepCollectionEquality().hash(minDeposit) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(percentage) ^
      const DeepCollectionEquality().hash(maxPromoAmt) ^
      const DeepCollectionEquality().hash(multiply) ^
      const DeepCollectionEquality().hash(dtype) ^
      const DeepCollectionEquality().hash(sequence) ^
      const DeepCollectionEquality().hash(featureIndex);

  @override
  _$DepositPromoModelCopyWith<_DepositPromoModel> get copyWith =>
      __$DepositPromoModelCopyWithImpl<_DepositPromoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DepositPromoModelToJson(this);
  }
}

abstract class _DepositPromoModel implements DepositPromoModel {
  const factory _DepositPromoModel(
      {@JsonKey(name: 'promoid', required: true)
          int promoId,
      @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
          String promoDesc,
      @JsonKey(name: 'min_deposit')
          int minDeposit,
      String type,
      @JsonKey(fromJson: _decodePercentageAsInt)
          int percentage,
      @JsonKey(name: 'max_promo_amt')
          int maxPromoAmt,
      int multiply,
      String dtype,
      dynamic sequence,
      @JsonKey(name: 'featureindex')
          String featureIndex}) = _$_DepositPromoModel;

  factory _DepositPromoModel.fromJson(Map<String, dynamic> json) =
      _$_DepositPromoModel.fromJson;

  @override
  @JsonKey(name: 'promoid', required: true)
  int get promoId;
  @override
  @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
  String get promoDesc;
  @override
  @JsonKey(name: 'min_deposit')
  int get minDeposit;
  @override
  String get type;
  @override
  @JsonKey(fromJson: _decodePercentageAsInt)
  int get percentage;
  @override
  @JsonKey(name: 'max_promo_amt')
  int get maxPromoAmt;
  @override
  int get multiply;
  @override
  String get dtype;
  @override
  dynamic get sequence;
  @override
  @JsonKey(name: 'featureindex')
  String get featureIndex;
  @override
  _$DepositPromoModelCopyWith<_DepositPromoModel> get copyWith;
}
