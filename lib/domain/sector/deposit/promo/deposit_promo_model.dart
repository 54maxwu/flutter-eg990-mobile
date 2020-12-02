import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'deposit_promo_data.dart';

part 'deposit_promo_model.freezed.dart';
part 'deposit_promo_model.g.dart';

@freezed
abstract class DepositPromoModel with _$DepositPromoModel {
  const factory DepositPromoModel({
    @JsonKey(name: 'promoid', required: true) int promoId,
    @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
        String promoDesc,
    @JsonKey(name: 'min_deposit') int minDeposit,
    String type,
    @JsonKey(fromJson: _decodePercentageAsInt) int percentage,
    @JsonKey(name: 'max_promo_amt') int maxPromoAmt,
    int multiply,
    String dtype,
    dynamic sequence,
    @JsonKey(name: 'featureindex') String featureIndex,
  }) = _DepositPromoModel;

  factory DepositPromoModel.fromJson(Map<String, dynamic> json) =>
      _$DepositPromoModelFromJson(json);

// static DepositPromoModel parseJson(Map<String, dynamic> jsonMap) =>
//     DepositPromoModel.fromJson(jsonMap);
}

int _decodePercentageAsInt(dynamic value) => '$value'.strToInt;

extension DepositPromoModelExtension on DepositPromoModel {
  DepositPromoData get entity => DepositPromoData(
        promoId: promoId,
        promoDesc: promoDesc,
      );
}
