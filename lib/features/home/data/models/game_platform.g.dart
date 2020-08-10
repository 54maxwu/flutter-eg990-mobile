// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_platform.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GamePlatformEntityAdapter extends TypeAdapter<_$GamePlatformEntity> {
  @override
  final typeId = 104;

  @override
  _$GamePlatformEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$GamePlatformEntity(
      id: fields[0] as int,
      className: fields[1] as String,
      ch: fields[2] as String,
      site: fields[3] as String,
      category: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$GamePlatformEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.className)
      ..writeByte(2)
      ..write(obj.ch)
      ..writeByte(3)
      ..write(obj.site)
      ..writeByte(4)
      ..write(obj.category);
  }
}
