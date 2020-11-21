import 'dart:convert';

import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_platform_entity.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/models/game_category_model.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/models/game_platform_model.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/models/game_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final GameCategoryModel categoryModel =
      GameCategoryModel(type: "casino", ch: "真人");

  final GamePlatformEntity platformEntity = GamePlatformEntity(
    id: 53,
    site: "eg",
    ch: "EG casino",
    category: "casino",
    className: "eg-casino",
  );

  test('test transform platform to entity', () {
    final map = json.decode(fixture('home/game_types.json'));
    final model = GameTypes.jsonToGameTypes(map);
    expect(model.categories.length, 7);
    expect(model.categories.first, categoryModel.entity);
    expect(model.platforms.first, platformEntity);
  });
}
