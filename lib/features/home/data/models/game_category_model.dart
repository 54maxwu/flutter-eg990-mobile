import 'package:flutter_eg990_mobile/core/base/data_operator.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:vnum/vnum.dart';

part 'game_category.dart';
part 'game_category_model.freezed.dart';
part 'game_category_model.g.dart';

@freezed
abstract class GameCategoryModel with _$GameCategoryModel {
  @HiveType(typeId: 103)
  @Implements(DataOperator)
  const factory GameCategoryModel({
    @HiveField(0) @required String ch,
    @HiveField(1) @required String type,
  }) = _GameCategoryModel;

  static GameCategoryModel jsonToGameCategoryModel(
          Map<String, dynamic> jsonMap) =>
      _$_GameCategoryModel(
        ch: jsonMap['ch'] as String,
        type: jsonMap['type'] as String,
      );

//  @override
//  String operator [](String key) {
//    return type.toString();
//  }
}

enum GamePageType { Games, Recommend, Favorite, Movie1, Movie2 }

extension GameCategoryModelExtension on GameCategoryModel {
  String get iconUrl => _categoryMap[type].iconUrl ?? '';

  String get label => _categoryMap[type].label ?? '?';

  GamePageType get pageType {
    switch (type) {
      case 'eg_movie':
        return GamePageType.Movie1;
      case 'new_movie':
        return GamePageType.Movie2;
      case 'recommend':
        return GamePageType.Recommend;
      case 'fav':
        return GamePageType.Favorite;
      default:
        return GamePageType.Games;
    }
  }
}

const GameCategoryModel movieEgCategory = GameCategoryModel(
  type: 'eg_movie',
  ch: 'EG影城',
);
const GameCategoryModel movieNewCategory = GameCategoryModel(
  type: 'new_movie',
  ch: '新影城',
);
const GameCategoryModel recommendCategory = GameCategoryModel(
  type: 'recommend',
  ch: '推荐',
);
const GameCategoryModel favoriteCategory = GameCategoryModel(
  type: 'fav',
  ch: '最爱',
);
