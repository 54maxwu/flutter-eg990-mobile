import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:meta/meta.dart' show required;
import 'package:to_string/to_string.dart';

part 'user_data.g.dart';

@ToString()
class UserData {
  bool isLoggedIn = false;
  UserEntity user;

  UserData({@required this.isLoggedIn, this.user});

  logout() {
    user = null;
    isLoggedIn = false;
  }

  login(UserEntity entity) {
    user = UserEntity(
        account: entity.account,
        credit: entity.credit,
        vip: entity.vip,
        vipName: entity.vipName);
    isLoggedIn = true;
  }

  @override
  String toString() => _$UserDataToString(this);
}
