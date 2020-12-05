import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_entity.dart';

part 'game_model.freezed.dart';

@freezed
abstract class GameModel with _$GameModel {
  const factory GameModel({
    @required int id,
    @required String category,
    @required String platform,
    @JsonKey(name: 'gameid') String gameId,
    @required String cname,
    @Default('') String ename,
    @Default(0) int favorite,
    @Default(0) int sort,
  }) = _GameModel;

  static GameModel parseJson(Map<String, dynamic> jsonMap) => _$_GameModel(
        id: jsonMap['id'] as int,
        category: jsonMap['category'] as String,
        platform: jsonMap['platform'] as String,
        gameId: jsonMap['gameid'] as String,
        cname: (jsonMap.containsKey('cname')) ? jsonMap['cname'] as String : '',
        ename: (jsonMap.containsKey('ename')) ? jsonMap['ename'] as String : '',
        favorite: '${jsonMap['favorite'] ?? 0}'.strToInt,
        sort: jsonMap['sort'] as int ?? 0,
      );
}

extension GameModelExtension on GameModel {
  GameEntity get entity => GameEntity(
        id: id,
        cname: cname,
        ename: ename,
        gameUrl: '$platform/$category/$gameId',
        favorite: favorite,
        sort: sort,
      );
}
