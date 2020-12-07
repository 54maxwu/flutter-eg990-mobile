import 'package:flutter_eg990_mobile/domain/core/value_objects.dart';
import 'package:meta/meta.dart' show immutable, required;

import 'login/login_form_data.dart';

@immutable
class User {
  final UniqueId id;
  final Username username;
  final String credit;
  final int vip;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const User({
    @required this.id,
    @required this.username,
    @required this.credit,
    @required this.vip,
  });

  User copyWith({
    UniqueId id,
    Username username,
    String credit,
    int vip,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (username == null || identical(username, this.username)) &&
        (credit == null || identical(credit, this.credit)) &&
        (vip == null || identical(vip, this.vip))) {
      return this;
    }

    return new User(
      id: id ?? this.id,
      username: username ?? this.username,
      credit: credit ?? this.credit,
      vip: vip ?? this.vip,
    );
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, credit: $credit, vip: $vip}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          credit == other.credit &&
          vip == other.vip);

  @override
  int get hashCode =>
      id.hashCode ^ username.hashCode ^ credit.hashCode ^ vip.hashCode;

//</editor-fold>

}

extension UserExtension on User {
  User updateCredit(String credit) => copyWith(credit: credit);
}
