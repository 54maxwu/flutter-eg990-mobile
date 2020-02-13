import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_string/to_string.dart';

part 'permission_item.g.dart';

@ToString()
class PermissionItem {
  PermissionGroup group;
  PermissionStatus status;

  PermissionItem(this.group, this.status);

  @override
  String toString() {
    return _$PermissionItemToString(this);
  }
}

extension RequestListPermission on List<PermissionItem> {
  Future requestPermission() async {
    List<PermissionGroup> groupList = List();
    forEach((item) {
      if (item.status == PermissionStatus.denied) groupList.add(item.group);
    });
    if (groupList.isNotEmpty) {
      MyLogger.info(
          msg: 'requesting permissions: $groupList', tag: 'Permission');
      await PermissionHandler().requestPermissions(groupList);
    } else
      MyLogger.info(msg: 'permissions checked', tag: 'Permission');
  }
}
