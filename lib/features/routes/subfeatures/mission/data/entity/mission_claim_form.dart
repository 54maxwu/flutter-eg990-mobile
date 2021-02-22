import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/presentation/data/mission_type.dart';
import 'package:meta/meta.dart' show required;

///
/// Mission:
/// {
///   "id": 55,
///   "title": "绑定微信号并通过验证完成",
///   "member": 1,
///   "required": 1,
///   "prize_type": "0",
///   "prize": 20,
///   "prize_amount": 10,
///   "type": 4,
///   "sort": 56,
///   "url": "https://eg990.com/center",
///   "tab": "1",
///   "info": "至个人中心完成绑定微信号 获得彩金流水需一倍",
///   "auto": "1",
///   "complete": "0"
/// }
///
/// Json Form:
/// {missionType: "once", id: 55}
///
/// Response:
/// {code: 0, msg: "", data: "领取成功"}
///
class MissionClaimForm {
  final MissionTypeEnum missionType;
  final int prizeId;

  const MissionClaimForm({
    @required this.missionType,
    @required this.prizeId,
  });

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  MissionClaimForm copyWith({
    MissionTypeEnum missionType,
    int prizeId,
  }) {
    if ((missionType == null || identical(missionType, this.missionType)) &&
        (prizeId == null || identical(prizeId, this.prizeId))) {
      return this;
    }

    return new MissionClaimForm(
      missionType: missionType ?? this.missionType,
      prizeId: prizeId ?? this.prizeId,
    );
  }

  @override
  String toString() {
    return 'MissionClaimForm{missionType: $missionType, prizeId: $prizeId}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MissionClaimForm &&
          runtimeType == other.runtimeType &&
          missionType == other.missionType &&
          prizeId == other.prizeId);

  @override
  int get hashCode => missionType.hashCode ^ prizeId.hashCode;

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'time': this.missionType.value.jsonKey,
      'id': this.prizeId,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
