// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginHiveFormAdapter extends TypeAdapter<_$_LoginHiveForm> {
  @override
  final typeId = 109;

  @override
  _$_LoginHiveForm read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_LoginHiveForm(
      account: fields[0] as String,
      password: fields[1] as String,
      fastLogin: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, _$_LoginHiveForm obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.account)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.fastLogin);
  }
}
