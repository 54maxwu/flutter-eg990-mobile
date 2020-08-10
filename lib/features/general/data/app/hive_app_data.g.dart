// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_app_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveAppDataEntityAdapter extends TypeAdapter<HiveAppDataEntity> {
  @override
  final typeId = 106;

  @override
  HiveAppDataEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAppDataEntity(
      key: fields[0] as String,
      data: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, HiveAppDataEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.data);
  }
}
