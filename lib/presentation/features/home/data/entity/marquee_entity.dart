import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'marquee_entity.freezed.dart';
part 'marquee_entity.g.dart';

@freezed
abstract class MarqueeEntity implements _$MarqueeEntity, DataOperator {
  const MarqueeEntity._();

  @HiveType(typeId: 102)
  const factory MarqueeEntity({
    @HiveField(0) @required int id,
    @HiveField(1) @required String content,
    @HiveField(2) @required String url,
  }) = _MarqueeEntity;

  @override
  String operator [](String key) {
    return id.toString();
  }
}
