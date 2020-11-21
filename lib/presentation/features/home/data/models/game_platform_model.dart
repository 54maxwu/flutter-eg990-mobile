import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_platform_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_platform_model.freezed.dart';

@freezed
abstract class GamePlatformModel implements _$GamePlatformModel, DataOperator {
  const GamePlatformModel._();

  const factory GamePlatformModel({
    @required int id,
    @JsonKey(name: 'class', fromJson: decodePlatformClassName) String className,
    @JsonKey(fromJson: decodePlatformChName) String ch,
    int cid,
    @required String site,
    String site2,
    @JsonKey(name: 'type', required: true) String category,
    int sort,
    String status,
    @Default('0') String favorite,
  }) = _GamePlatformModel;

  static GamePlatformModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_GamePlatformModel(
        id: jsonMap['id'] as int ?? jsonMap['sort'],
        className: decodePlatformClassName(jsonMap),
        ch: decodePlatformChName(jsonMap),
        cid: jsonMap['cid'] as int,
        site: jsonMap['site'] as String,
        site2: jsonMap['site2'] as String,
        category: jsonMap['type'] as String,
        sort: jsonMap['sort'] as int,
        status: jsonMap['status'] as String,
        favorite: jsonMap['favorite'] as String ?? '0',
      );

  @override
  String operator [](String key) {
    return className.toString();
  }
}

extension GamePlatformModelExtension on GamePlatformModel {
  GamePlatformEntity get entity => GamePlatformEntity(
        id: id,
        className: className,
        ch: ch,
        site: site,
        category: category,
        favorite: favorite,
      );
}
