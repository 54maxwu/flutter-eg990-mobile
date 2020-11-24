import 'package:flutter_eg990_mobile/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';
import '../../presentation/features/login/data/form/login_form_data.dart';

part 'user_model.freezed.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'accountcode', required: true) String account,
    @JsonKey(name: 'creditlimit', required: true) String credit,
    @required String status,
    @required int vip,
    @JsonKey(name: 'vip_name', required: false) String vipName,
  }) = _UserModel;

  static UserModel jsonToUserModel(Map<String, dynamic> jsonMap) {
    $checkKeys(jsonMap, requiredKeys: const ['accountcode', 'creditlimit']);
    return _$_UserModel(
      account: jsonMap['accountcode'] as String,
      credit: jsonMap['creditlimit'] as String,
      status: jsonMap['status'] as String,
      vip: jsonMap['vip'] as int,
      vipName: jsonMap['vip_name'] as String,
    );
  }
}

extension UserModelExtension on UserModel {
  bool get isValid => status == 'success';

  User get getData => User(
        id: UniqueId(),
        username: Username.dirty(value: this.account),
        credit: this.credit,
        vip: this.vip,
      );
}
