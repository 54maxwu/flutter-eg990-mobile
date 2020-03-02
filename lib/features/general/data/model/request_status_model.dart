import 'package:to_string/to_string.dart';

part 'request_status_model.g.dart';

@ToString()
class RequestStatusModel {
  String msg;
  String status;

  RequestStatusModel({this.msg, this.status});

  factory RequestStatusModel.fromJson(Map<String, dynamic> json) {
    return RequestStatusModel(
      msg: json['msg'].toString(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }

  static RequestStatusModel jsonToStatusModel(Map<String, dynamic> jsonMap) =>
      RequestStatusModel.fromJson(jsonMap);

  bool get isSuccess => this.status == 'success';

  @override
  String toString() => _$RequestStatusModelToString(this);
}
