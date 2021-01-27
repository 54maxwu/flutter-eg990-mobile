import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_proportion_form.freezed.dart';

@freezed
abstract class AgentProportionForm with _$AgentProportionForm {
  const factory AgentProportionForm({
    @JsonKey(name: 'accid') int agentId,
    @JsonKey(name: 'administrative_fee') String administrativeFee,
    @JsonKey(name: 'card_config') String cardConfig,
    @JsonKey(name: 'casino_config') String casinoConfig,
    @JsonKey(name: 'fish_config') String fishConfig,
    @JsonKey(name: 'lottery_config') String lotteryConfig,
    @JsonKey(name: 'slot_config') String slotConfig,
    @JsonKey(name: 'sport_config') String sportConfig,
  }) = _AgentProportionForm;
}

extension AgentProportionFormExtension on AgentProportionForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accid': this.agentId,
      'administrative_fee': this.administrativeFee ?? '0.000',
      'card_config': this.cardConfig ?? '0.000',
      'casino_config': this.casinoConfig ?? '0.000',
      'fish_config': this.fishConfig ?? '0.000',
      'slot_config': this.slotConfig ?? '0.000',
      'lottery_config': this.lotteryConfig ?? '0.000',
      'sport_config': this.sportConfig ?? '0.000',
    };
  }
}
