// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginFormHiveAdapter extends TypeAdapter<LoginFormHive> {
  @override
  final int typeId = 109;

  @override
  LoginFormHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginFormHive(
      username: fields[0] as String,
      password: fields[1] as String,
      save: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoginFormHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.save);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginFormHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
