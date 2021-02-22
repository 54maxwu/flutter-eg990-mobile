import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

part 'mission_model.freezed.dart';

enum MissionStatus { LOADING, INCOMPLETE, COMPLETE, PENDING, RECEIVED }

@freezed
abstract class MissionModel with _$MissionModel {
  const factory MissionModel({
    @JsonKey(required: true) int id,
    // mission title
    String title,
    // member complete count
    num member,
    // required complete count
    num required,
    // 0 = bonus credit; 1 = store point
    @JsonKey(name: 'prize_type') String prizeType,
    //
    int prize,
    // prize amount on mission complete
    @JsonKey(name: 'prize_amount') num prizeAmount,
    // 1 = deposit; 2 = rollback; 3 = complete count; 4 = bind
    int type,
    // mission list order
    int sort,
    // mission navigate url
    String url,
    // 0 = show dialog; 1 = navigate;
    String tab,
    // mission detail
    String info,
    // 0 = auto; 1 = manual
    String auto,
    // 0 = complete; 1 = not complete; 3 = received
    String complete,
  }) = _MissionModel;

  static MissionModel parseJson(Map<String, dynamic> jsonMap) =>
      _$_MissionModel(
        id: jsonMap['id'] as int,
        title: '${jsonMap['title']}',
        member: jsonMap['member'] as num ?? -1,
        required: jsonMap['required'] as num ?? 0,
        prizeType: '${jsonMap['prize_type']}',
        prize: '${jsonMap['prize']}'.strToInt,
        prizeAmount: jsonMap['prize_amount'] as num,
        type: '${jsonMap['type']}'.strToInt,
        sort: '${jsonMap['sort']}'.strToInt,
        url: '${jsonMap['url']}' ?? '',
        tab: '${jsonMap['tab']}',
        info: '${jsonMap['info']}',
        auto: '${jsonMap['auto']}' ?? '0',
        complete: '${jsonMap['complete']}' ?? '1',
      );
}

extension MissionModelExtension on MissionModel {
  MissionStatus get getStatus {
    switch (complete) {
      case '0':
        return MissionStatus.COMPLETE;
      case '2':
        return MissionStatus.PENDING;
      case '3':
        return MissionStatus.RECEIVED;
      default:
        return MissionStatus.INCOMPLETE;
    }
  }

  bool get isAuto => auto == '0';

  bool get isValidMission =>
      id != null &&
      id >= 0 &&
      (title != null || info != null) &&
      prizeType != null &&
      this.required >= 0 &&
      member >= 0;
}
