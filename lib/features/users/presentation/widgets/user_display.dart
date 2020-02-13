import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/hex_color.dart';
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';

import '../../../../injection_container.dart' show sl;

///@author H.C.CHIANG
///@version 2020/1/15
class UserDisplay extends StatelessWidget {
  final UserEntity user;
  final Color bgColor = HexColor.fromHex('#e8e8e8');

  UserDisplay({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sl.get<UserData>().login(user);
    print('test user data: ${sl.get<UserData>().toString()}');
    return Container(
      color: bgColor,
      child: Text(user.toString(), style: TextStyle(color: Colors.black87)),
    );
  }
}
