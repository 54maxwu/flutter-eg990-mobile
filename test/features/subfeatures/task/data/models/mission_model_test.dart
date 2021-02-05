import 'dart:convert';

import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final map = json.decode(fixture('subfeatures/mission/mission_data.json'));

  test('test mission model', () {
    MissionModel model = MissionModel.parseJson(map);
    print('model: $model\n\n');
    print('data valid: ${model.isValidMission}');
  });
}
