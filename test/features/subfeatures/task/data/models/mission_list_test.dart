import 'dart:convert';

import 'package:flutter_eg990_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_list_model.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final map = json.decode(fixture('subfeatures/mission/missions.json'));

  test('test mission list model json parser', () {
    RequestCodeModel response = RequestCodeModel.jsonToCodeModel(map);
    MissionListModel model = MissionListModel.parseJson(response.data);
    print('model: $model\n\n');
    expect(model.daily.length, 6);
    expect(model.daily.every((element) => element is MissionModel), true);
    expect(model.limit.length, 0);
    expect(model.monthly.length, 6);
    expect(model.once.length, 6);
    expect(model.weekly.length, 5);
  });
}
