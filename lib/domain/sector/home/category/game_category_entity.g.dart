// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_category_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameCategoryEntityAdapter extends TypeAdapter<_$_GameCategoryEntity> {
  @override
  final int typeId = 111;

  @override
  _$_GameCategoryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_GameCategoryEntity(
      type: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_GameCategoryEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameCategoryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
