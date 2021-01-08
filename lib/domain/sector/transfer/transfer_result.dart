import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_result.freezed.dart';

@freezed
abstract class TransferResult with _$TransferResult {
  factory TransferResult({
    int code,
    String status,
    dynamic data,
    @JsonKey(fromJson: JsonUtil.getRawJson, required: false, defaultValue: '')
        String msg,
  }) = _TransferResult;

  static TransferResult parseJson(Map<String, dynamic> jsonMap) =>
      _$_TransferResult(
        code: jsonMap['code'] as int,
        status: jsonMap['status'] as String,
        data: jsonMap['data'],
        msg: '${jsonMap['msg']}',
      );

  @late
  bool get isSuccess =>
      (code != null && code == 0) || (status != null && status == 'success');
}
