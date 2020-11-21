import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'banner_entity.freezed.dart';
part 'banner_entity.g.dart';

@freezed
abstract class BannerEntity implements _$BannerEntity, DataOperator {
  const BannerEntity._();

  @HiveType(typeId: 101)
  const factory BannerEntity({
    @HiveField(0) @required int id,
    @HiveField(1) @required String pic,
    @HiveField(2) @required bool noPromo,
    @HiveField(3) @required String promoUrl,
    @HiveField(4) @required int sort,
  }) = _BannerEntity;

  @override
  String operator [](String key) {
    return id.toString();
  }
}
