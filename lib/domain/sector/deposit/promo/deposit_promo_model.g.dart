// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_promo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DepositPromoModel _$_$_DepositPromoModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['promoid', 'promodesc']);
  return _$_DepositPromoModel(
    promoId: json['promoid'] as int,
    promoDesc: json['promodesc'] as String ?? '?',
    minDeposit: json['min_deposit'] as int,
    type: json['type'] as String,
    percentage: _decodePercentageAsInt(json['percentage']),
    maxPromoAmt: json['max_promo_amt'] as int,
    multiply: json['multiply'] as int,
    dtype: json['dtype'] as String,
    sequence: json['sequence'],
    featureIndex: json['featureindex'] as String,
  );
}

Map<String, dynamic> _$_$_DepositPromoModelToJson(
        _$_DepositPromoModel instance) =>
    <String, dynamic>{
      'promoid': instance.promoId,
      'promodesc': instance.promoDesc,
      'min_deposit': instance.minDeposit,
      'type': instance.type,
      'percentage': instance.percentage,
      'max_promo_amt': instance.maxPromoAmt,
      'multiply': instance.multiply,
      'dtype': instance.dtype,
      'sequence': instance.sequence,
      'featureindex': instance.featureIndex,
    };
