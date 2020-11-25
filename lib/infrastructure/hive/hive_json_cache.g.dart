// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_json_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveJsonCacheAdapter extends TypeAdapter<HiveJsonCache> {
  @override
  final int typeId = 90;

  @override
  HiveJsonCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveJsonCache(
      expiredInHours: fields[2] as int,
      cacheMap: (fields[3] as Map)?.cast<String, dynamic>(),
      cacheList: (fields[4] as List)?.cast<dynamic>(),
    )..lastUpdate = fields[0] as DateTime;
  }

  @override
  void write(BinaryWriter writer, HiveJsonCache obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lastUpdate)
      ..writeByte(2)
      ..write(obj.expiredInHours)
      ..writeByte(3)
      ..write(obj.cacheMap)
      ..writeByte(4)
      ..write(obj.cacheList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveJsonCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
