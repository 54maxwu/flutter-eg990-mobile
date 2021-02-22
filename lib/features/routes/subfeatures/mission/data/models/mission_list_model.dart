import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'mission_model.dart';

part 'mission_list_model.freezed.dart';

@freezed
abstract class MissionListModel with _$MissionListModel {
  const factory MissionListModel({
    @JsonKey(name: 'day', fromJson: decodeMissionList) List<MissionModel> daily,
    @JsonKey(fromJson: decodeMissionList) List<MissionModel> limit,
    @JsonKey(name: 'month', fromJson: decodeMissionList)
        List<MissionModel> monthly,
    @JsonKey(fromJson: decodeMissionList) List<MissionModel> once,
    @JsonKey(name: 'week', fromJson: decodeMissionList)
        List<MissionModel> weekly,
  }) = _MissionListModel;

  static MissionListModel parseJson(Map<String, dynamic> jsonMap) =>
      _$_MissionListModel(
        daily: jsonMap['day'] != null ? decodeMissionList(jsonMap['day']) : [],
        limit:
            jsonMap['limit'] != null ? decodeMissionList(jsonMap['limit']) : [],
        monthly:
            jsonMap['month'] != null ? decodeMissionList(jsonMap['month']) : [],
        once: jsonMap['once'] != null ? decodeMissionList(jsonMap['once']) : [],
        weekly:
            jsonMap['week'] != null ? decodeMissionList(jsonMap['week']) : [],
      );
}

List<MissionModel> decodeMissionList(dynamic str) {
  try {
    return JsonUtil.decodeArrayToModel(
      str,
      (jsonMap) => MissionModel.parseJson(jsonMap),
      tag: 'MissionListDecode',
    );
  } catch (e) {
    MyLogger.warn(msg: 'decode mission list has exception: $e');
    return [];
  }
}

extension MissionListModelExtension on MissionListModel {
  List<MissionModel> operator [](int tabIndex) {
    switch (tabIndex) {
      case 0:
        return this.daily;
      case 1:
        return this.weekly;
      case 2:
        return this.monthly;
      case 3:
        return this.once;
      case 4:
        return this.limit;
      default:
        return [];
    }
  }
}
