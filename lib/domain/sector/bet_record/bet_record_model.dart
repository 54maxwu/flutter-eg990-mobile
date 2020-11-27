import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'bet_record_data.dart';

part 'bet_record_model.freezed.dart';

@freezed
abstract class BetRecordModel with _$BetRecordModel {
  const factory BetRecordModel({
    @JsonKey(name: 'current_page') int currentPage,
    @JsonKey(name: 'last_page') int lastPage,
    @JsonKey(name: 'per_page') int perPage,
    int from,
    int to,
    int total,
    @JsonKey(name: 'next_page_url') String nextPageUrl,
    @JsonKey(name: 'prev_page_url') String prevPageUrl,
    @JsonKey(fromJson: decodeBetRecordData) List<BetRecordData> data,
  }) = _BetRecordModel;

  static BetRecordModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_BetRecordModel(
        currentPage: jsonMap['current_page'] as int,
        lastPage: jsonMap['last_page'] as int,
        perPage: jsonMap['per_page'] as int,
        from: jsonMap['from'] as int,
        to: jsonMap['to'] as int,
        total: jsonMap['total'] as int,
        nextPageUrl: jsonMap['next_page_url'] as String,
        prevPageUrl: jsonMap['prev_page_url'] as String,
        data: decodeBetRecordData(jsonMap['data']),
      );
}

extension BetRecordModelExtension on BetRecordModel {
  bool get hasNoData =>
      data == null ||
      data.isEmpty ||
      (data.length == 1 && data.first.isSumData());

  BetRecordData get getSum =>
      data.singleWhere((element) => element.isSumData());
}

List<BetRecordData> decodeBetRecordData(dynamic str) =>
    JsonUtil.decodeMapToModelList(
      str,
      (jsonMap) => BetRecordData.jsonToModel(jsonMap),
      tag: 'BetRecordData',
    );
