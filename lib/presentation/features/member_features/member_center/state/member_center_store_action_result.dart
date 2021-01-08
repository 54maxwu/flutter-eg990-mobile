import 'package:meta/meta.dart';

enum MemberCenterStoreAction {
  PASSWORD,
  BIRTH,
  EMAIL,
  WECHAT,
  ZALO,
  VERIFY_REQUEST,
  VERIFY,
}

class MemberCenterStoreActionResult {
  final MemberCenterStoreAction action;
  final bool success;
  final String msg;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const MemberCenterStoreActionResult({
    @required this.action,
    this.success,
    this.msg = '',
  });

  MemberCenterStoreActionResult copyWith({
    MemberCenterStoreAction action,
    bool success,
    String msg,
  }) {
    if ((action == null || identical(action, this.action)) &&
        (success == null || identical(success, this.success)) &&
        (msg == null || identical(msg, this.msg))) {
      return this;
    }

    return new MemberCenterStoreActionResult(
      action: action ?? this.action,
      success: success ?? this.success,
      msg: msg ?? this.msg,
    );
  }

  @override
  String toString() {
    return 'MemberCenterStoreActionResult{action: $action, success: $success, msg: $msg}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberCenterStoreActionResult &&
          runtimeType == other.runtimeType &&
          action == other.action &&
          success == other.success &&
          msg == other.msg);

  @override
  int get hashCode => action.hashCode ^ success.hashCode ^ msg.hashCode;

//</editor-fold>
}
