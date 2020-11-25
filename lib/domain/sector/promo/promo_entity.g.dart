// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromoEntityAdapter extends TypeAdapter<_$_PromoEntity> {
  @override
  final int typeId = 121;

  @override
  _$_PromoEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_PromoEntity(
      id: fields[0] as int,
      name: fields[1] as String,
      bannerMobile: fields[2] as String,
      textContent: fields[3] as String,
      placeContent: fields[4] as String,
      applyContent: fields[5] as String,
      ruleContent: fields[6] as String,
      top: fields[7] as String,
      sort: fields[8] as int,
      postCategoryId: fields[9] as int,
      categoryStr: fields[10] as String,
      status: fields[11] as String,
      activeDate: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_PromoEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.bannerMobile)
      ..writeByte(3)
      ..write(obj.textContent)
      ..writeByte(4)
      ..write(obj.placeContent)
      ..writeByte(5)
      ..write(obj.applyContent)
      ..writeByte(6)
      ..write(obj.ruleContent)
      ..writeByte(7)
      ..write(obj.top)
      ..writeByte(8)
      ..write(obj.sort)
      ..writeByte(9)
      ..write(obj.postCategoryId)
      ..writeByte(10)
      ..write(obj.categoryStr)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.activeDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PromoEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
