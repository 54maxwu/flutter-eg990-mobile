// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marquee_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarqueeEntityAdapter extends TypeAdapter<_$_MarqueeEntity> {
  @override
  final typeId = 102;

  @override
  _$_MarqueeEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_MarqueeEntity(
      id: fields[0] as int,
      content: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_MarqueeEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.url);
  }
}
