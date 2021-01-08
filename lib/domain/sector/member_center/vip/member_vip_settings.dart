import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_vip_settings.freezed.dart';

@freezed
abstract class MemberVipSettings with _$MemberVipSettings {
  const factory MemberVipSettings({
    @JsonKey(name: 'allgame', defaultValue: '') String allGame,
    @JsonKey(name: 'slotgame', defaultValue: '') String slotGame,
    @JsonKey(name: 'casinogame', defaultValue: '') String casinoGame,
    @JsonKey(name: 'sportgame', defaultValue: '') String sportGame,
    @JsonKey(name: 'fishgame', defaultValue: '') String fishGame,
    @JsonKey(name: 'lotterygame', defaultValue: '') String lotteryGame,
    @JsonKey(name: 'cardgame', defaultValue: '') String cardGame,
  }) = _MemberVipSettings;

  static MemberVipSettings parseJson(Map<String, dynamic> jsonMap) =>
      _$_MemberVipSettings(
        allGame: '${jsonMap['allgame']}' ?? '',
        slotGame: '${jsonMap['slotgame']}' ?? '',
        casinoGame: '${jsonMap['casinogame']}' ?? '',
        sportGame: '${jsonMap['sportgame']}' ?? '',
        fishGame: '${jsonMap['fishgame']}' ?? '',
        lotteryGame: '${jsonMap['lotterygame']}' ?? '',
        cardGame: '${jsonMap['cardgame']}' ?? '',
      );
}

extension MemberVipSettingsExtension on MemberVipSettings {
  Map<String, dynamic> toJson() => <String, dynamic>{
        'allgame': this.allGame,
        'slotgame': this.slotGame,
        'casinogame': this.casinoGame,
        'sportgame': this.sportGame,
        'fishgame': this.fishGame,
        'lotterygame': this.lotteryGame,
        'cardgame': this.cardGame,
      };
}
