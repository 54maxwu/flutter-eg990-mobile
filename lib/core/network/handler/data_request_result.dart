import 'package:flutter_ty_mobile/features/general/data/model/request_status_model.dart';
import 'package:to_string/to_string.dart';

part 'data_request_result.g.dart';

@ToString()
class DataRequestResult {
  dynamic data;
  RequestStatusModel failedData;

  DataRequestResult({this.data, this.failedData});

  @override
  String toString() => _$DataRequestResultToString(this);
}
