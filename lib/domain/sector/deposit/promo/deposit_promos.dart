import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'deposit_promo_data.dart';
import 'deposit_promo_model.dart';

part 'deposit_promos.freezed.dart';

@freezed
abstract class DepositPromos with _$DepositPromos {
  const factory DepositPromos({
    @JsonKey(name: '1', fromJson: decodeDepositPromos)
        List<DepositPromoData> local,
    @JsonKey(name: '2', fromJson: decodeDepositPromos)
        List<DepositPromoData> other,
  }) = _DepositPromos;

  static DepositPromos parseJson(Map<String, dynamic> jsonMap) =>
      _$_DepositPromos(
        local: decodeDepositPromos(jsonMap['1']),
        other: decodeDepositPromos(jsonMap['2']),
      );
}

List<DepositPromoData> decodeDepositPromos(dynamic str) =>
    JsonUtil.decodeMapToModelList(
      str,
      (jsonMap) => DepositPromoModel.fromJson(jsonMap).entity,
      addKey: false,
      tag: 'DepositPromos',
    );

extension DepositPromosExtension on DepositPromos {}
