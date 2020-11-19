// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$User {
  const _$User();

  UniqueId get id;
  Username get username;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! User) return false;
    return true && this.id == other.id && this.username == other.username;
  }

  int get hashCode {
    return mapPropsToHashCode([id, username]);
  }

  String toString() {
    return 'User <\'id\': ${this.id},\'username\': ${this.username},>';
  }

  User copyWith({UniqueId id, Username username}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
    );
  }
}
