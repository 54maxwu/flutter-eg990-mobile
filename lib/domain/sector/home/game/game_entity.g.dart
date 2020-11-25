// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameEntityAdapter extends TypeAdapter<_$_GameEntity> {
  @override
  final int typeId = 113;

  @override
  _$_GameEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_GameEntity(
      id: fields[0] as int,
      cname: fields[1] as String,
      ename: fields[2] as String,
      gameUrl: fields[3] as String,
      favorite: fields[4] as int,
      sort: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_GameEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.cname)
      ..writeByte(2)
      ..write(obj.ename)
      ..writeByte(3)
      ..write(obj.gameUrl)
      ..writeByte(4)
      ..write(obj.favorite)
      ..writeByte(5)
      ..write(obj.sort);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
