import 'package:flui/flui.dart' show FLToast;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/widget_res_export.dart'
    show
        HexColor,
        RouterNavigate,
        RouterPageInfo,
        getRouteUserStreams,
        localeStr;

///@author H.C.CHIANG
///@version 2020/1/15
class UserDisplay extends StatelessWidget {
  final UserEntity user;
  final Color bgColor = HexColor.fromHex('#e8e8e8');

  UserDisplay({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getRouteUserStreams.updateUser(user);
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      var dismiss = FLToast.showLoading(
        text: localeStr.messageWelcomeUser(user.account),
      );
      Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
        dismiss();
        RouterNavigate.navigateToPage(RouterPageInfo.member);
      });
    });
    return SizedBox.shrink();
//    return Container(
//      color: bgColor,
//      constraints: BoxConstraints.tightFor(width: Global.device.width - 16),
//      child: Text(user.toString(), style: TextStyle(color: Colors.black87)),
//    );
  }
}
