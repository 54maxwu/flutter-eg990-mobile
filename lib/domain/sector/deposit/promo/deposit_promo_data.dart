import 'package:freezed_annotation/freezed_annotation.dart';

part 'deposit_promo_data.freezed.dart';

@freezed
abstract class DepositPromoData with _$DepositPromoData {
  const factory DepositPromoData({
    @JsonKey(name: 'promoid', required: true) int promoId,
    @JsonKey(name: 'promodesc', required: true, defaultValue: '?')
        String promoDesc,
  }) = _DepositPromoData;
}
