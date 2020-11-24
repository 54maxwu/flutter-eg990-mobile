// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$User {
  const _$User();

  UniqueId get id;
  Username get username;
  String get credit;
  int get vip;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! User) return false;
    return true &&
        this.id == other.id &&
        this.username == other.username &&
        this.credit == other.credit &&
        this.vip == other.vip;
  }

  int get hashCode {
    return mapPropsToHashCode([id, username, credit, vip]);
  }

  String toString() {
    return 'User <\'id\': ${this.id},\'username\': ${this.username},\'credit\': ${this.credit},\'vip\': ${this.vip},>';
  }

  User copyWith({UniqueId id, Username username, String credit, int vip}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      credit: credit ?? this.credit,
      vip: vip ?? this.vip,
    );
  }
}
