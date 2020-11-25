import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'game_entity.freezed.dart';
part 'game_entity.g.dart';

@freezed
abstract class GameEntity with _$GameEntity, DataOperator {
  const GameEntity._();

  @HiveType(typeId: 113)
  const factory GameEntity({
    @HiveField(0) @required int id,
    @HiveField(1) @required String cname,
    @HiveField(2) @required String ename,
    @HiveField(3)
    @JsonKey(fromJson: _decodeGameUrl, required: true)
        String gameUrl,
    @HiveField(4) @Default(0) int favorite,
    @HiveField(5) @Default(0) int sort,
  }) = _GameEntity;

  // static GameEntity jsonToGameEntity(Map<String, dynamic> jsonMap) =>
  //     _$_GameEntity(
  //       id: jsonMap['id'] as int,
  //       cname: (jsonMap.containsKey('cname')) ? jsonMap['cname'] as String : '',
  //       ename: (jsonMap.containsKey('ename')) ? jsonMap['ename'] as String : '',
  //       gameUrl: _decodeGameUrl(jsonMap['gameUrl'] as Map<String, dynamic>),
  //       favorite: jsonMap['favorite'] as int ?? 0,
  //       sort: jsonMap['sort'] as int ?? 0,
  //     );

  @override
  String operator [](String key) => '$gameUrl';
}

String _decodeGameUrl(Map<String, dynamic> json) =>
    '${json['platform']}/${json['category']}/${json['gameid']}';

enum GameEntityUrlCompose { PLATFORM, CATEGORY, GAME_ID }

extension GameEntityExtension on GameEntity {
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    final info = gameUrl.split('/');
    data['category'] = info[1];
    data['cname'] = cname;
    data['ename'] = ename;
    data['gameid'] = info[2];
    data['id'] = id;
    data['platform'] = info[0];
    return data;
  }

  String get imageUrl => '/images/games/game/$id.jpg';

  String decomposeUrl(GameEntityUrlCompose decompose) {
    final info = gameUrl.split('/');
    switch (decompose) {
      case GameEntityUrlCompose.PLATFORM:
        return info[0];
      case GameEntityUrlCompose.CATEGORY:
        return info[1];
      case GameEntityUrlCompose.GAME_ID:
        return info[2];
      default:
        return '';
    }
  }

  bool isLongText(int limit) => cname.countLength > limit;
}
