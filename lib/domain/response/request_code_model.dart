import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

part 'request_code_model.freezed.dart';

@freezed
abstract class RequestCodeModel with _$RequestCodeModel {
  factory RequestCodeModel({
    int code,
    dynamic data,
    String msg,
  }) = _RequestCodeModel;

  static RequestCodeModel parseJson(Map<String, dynamic> jsonMap) {
//    if (jsonMap.containsKey('msg') &&
//        '${jsonMap['msg']}'.toLowerCase() == 'Repeat token'.toLowerCase())
//      throw TokenException();
    return _$_RequestCodeModel(
      code: '${jsonMap['code']}'.strToInt,
      data: jsonMap['data'],
      msg: '${jsonMap['msg']}',
    );
  }

  @late
  bool get isSuccess => code == 0;
}
