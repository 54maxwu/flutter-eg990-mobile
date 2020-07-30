import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/store/data/models/store_banner_model.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final map = json.decode(fixture('subfeatures/store/banner.json'));

  test('test store banner model', () {
    print('\n');
    RequestCodeModel codeModel = RequestCodeModel.jsonToCodeModel(map);
    print('code model: $codeModel\n\n');
    List<StoreBannerModel> banners = JsonUtil.decodeArrayToModel(codeModel.data,
        (jsonMap) => StoreBannerModel.jsonToStoreBannerModel(jsonMap));
    print('banners: $banners\n\n');
  });
}
