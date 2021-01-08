import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'member_vip_settings.dart';

part 'member_vip_data.freezed.dart';

@freezed
abstract class MemberVipData implements _$MemberVipData, DataOperator {
  const MemberVipData._();

  const factory MemberVipData({
    dynamic vipOption,
    dynamic vipSetting,
    num allGame,
    int allGameLevel,
    int allGameValue,
    num cardGame,
    int cardGameLevel,
    int cardGameValue,
    num casinoGame,
    int casinoGameLevel,
    int casinoGameValue,
    num fishGame,
    int fishGameLevel,
    int fishGameValue,
    num lotteryGame,
    int lotteryGameLevel,
    int lotteryGameValue,
    num slotGame,
    int slotGameLevel,
    int slotGameValue,
    num sportGame,
    int sportGameLevel,
    int sportGameValue,
  }) = _MemberVipData;

  @override
  String operator [](String key) {
    switch (key.toLowerCase()) {
      case 'allgame':
        return '$allGameValue';
      case 'slotgame':
        return '$slotGameValue';
      case 'casinogame':
        return '$casinoGameValue';
      case 'sportgame':
        return '$sportGameValue';
      case 'fishgame':
        return '$fishGameValue';
      case 'lotterygame':
        return '$lotteryGameValue';
      case 'cardgame':
        return '$cardGameValue';
      default:
        return '-1';
    }
  }
}

extension MemberVipDataExtension on MemberVipData {
  List<String> get getBlockKeys =>
      new List.from(vipOption.keys.map((value) => '$value'));

  List<String> get getBlockTitles =>
      new List.from(vipOption.values.map((value) => '$value'));

  List<String> get getLevelLabels =>
      new List.from(vipSetting.values.map((value) => '${value['title']}'));

  Map<String, MemberVipSettings> get getLevelRequirements =>
      Map<String, MemberVipSettings>.from(vipSetting.map((key, value) {
        // debugPrint('map vip level requirements: $key - $value');
        return MapEntry(
            key.toString(), MemberVipSettings.parseJson(value['setting']));
      }));
}
