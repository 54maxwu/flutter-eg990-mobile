import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vip_level_model.freezed.dart';

@freezed
abstract class VipLevelModel with _$VipLevelModel {
  const factory VipLevelModel({
    @JsonKey(name: 'level', fromJson: decodeVipLevelName)
        List<VipLevelName> levels,
    @JsonKey(name: 'option', fromJson: decodeVipLevelOption)
        List<VipLevelOption> options,
    @JsonKey(name: 'vip') Map<String, dynamic> rules,
  }) = _VipLevelModel;

  static VipLevelModel jsonToVipLevelModel(Map<String, dynamic> jsonMap) =>
      _$_VipLevelModel(
        levels: decodeVipLevelName(jsonMap['level']),
        options: decodeVipLevelOption(jsonMap['option'])
          ..removeWhere((element) =>
              element.type == 'img' ||
              element.name == 'viplevel' ||
              element.name == 'incentive' ||
              element.name == 'allgamekeep'),
        rules: jsonMap['vip'],
      );
}

@freezed
abstract class VipLevelName with _$VipLevelName {
  const factory VipLevelName({
    String key,
    String title,
    String img,
  }) = _VipLevelName;

  static VipLevelName jsonToVipLevelName(Map<String, dynamic> jsonMap) =>
      _$_VipLevelName(
        title: jsonMap['title'] as String,
        img: jsonMap['img'] as String,
      );
}

List<VipLevelName> decodeVipLevelName(dynamic str) =>
    JsonUtil.decodeMapToModelList(
      str,
      (jsonMap) => VipLevelName.jsonToVipLevelName(jsonMap),
      tag: 'VipLevelName',
    );

@freezed
abstract class VipLevelOption with _$VipLevelOption {
  const factory VipLevelOption({
    String key,
    String name,
    String content,
    @JsonKey(name: 'content_cn', defaultValue: '') String contentCN,
    @JsonKey(name: 'content_us', defaultValue: '') String contentEN,
    @JsonKey(name: 'content_vn', defaultValue: '') String contentVI,
    @JsonKey(name: 'content_th', defaultValue: '') String contentTH,
    String type,
  }) = _VipLevelOption;

  static VipLevelOption jsonToVipLevelOption(Map<String, dynamic> jsonMap) {
    return _$_VipLevelOption(
      key: jsonMap['key'] as String,
      name: jsonMap['name'] as String,
      content: (jsonMap.containsKey('ch')) ? jsonMap['ch'] as String : '',
      contentCN: (jsonMap.containsKey('content_cn'))
          ? jsonMap['content_cn'] as String
          : '',
      contentEN: (jsonMap.containsKey('content_us'))
          ? jsonMap['content_us'] as String
          : '',
      contentVI: (jsonMap.containsKey('content_vn'))
          ? jsonMap['content_vn'] as String
          : '',
      contentTH: (jsonMap.containsKey('content_th'))
          ? jsonMap['content_th'] as String
          : '',
      type: jsonMap['type'] as String,
    );
  }
}

List<VipLevelOption> decodeVipLevelOption(dynamic str) =>
    JsonUtil.decodeMapToModelList(
      str,
      (jsonMap) => VipLevelOption.jsonToVipLevelOption(jsonMap),
      tag: 'VipLevelOption',
    );

extension VipLevelOptionExtension on VipLevelOption {
  String get getContent {
    String str = this.content;
    switch (Global.lang.code) {
      case 'zh':
        str = contentCN;
        break;
      case 'en':
        str = contentEN;
        break;
      case 'th':
        str = contentTH;
        break;
      case 'vi':
        str = contentVI;
        break;
    }
    // if content is empty
    // use the one that's not empty by this order
    // en -> cn -> vi -> th
    if (str.isEmpty) {
      str = (contentEN.isNotEmpty)
          ? contentEN
          : (contentCN.isNotEmpty)
              ? contentCN
              : (contentVI.isNotEmpty)
                  ? contentVI
                  : contentTH;
    }
    return str;
  }
}
