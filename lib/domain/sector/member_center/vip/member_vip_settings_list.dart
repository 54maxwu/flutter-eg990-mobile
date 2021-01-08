import 'package:freezed_annotation/freezed_annotation.dart';

import 'member_vip_settings.dart';

part 'member_vip_settings_list.freezed.dart';

@freezed
abstract class MemberVipSettingsList with _$MemberVipSettingsList {
  const factory MemberVipSettingsList({
    @JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
        MemberVipSettings item,
    String title,
  }) = _MemberVipSettingsList;

  static MemberVipSettingsList parseJson(Map<String, dynamic> jsonMap) =>
      _$_MemberVipSettingsList(
        item: MemberVipSettings.parseJson(
            jsonMap['setting'] as Map<String, dynamic>),
        title: jsonMap['title'] as String,
      );
}

extension MemberVipSettingsListExtension on MemberVipSettingsList {}
