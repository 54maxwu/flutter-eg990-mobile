import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_data.freezed.dart';

@freezed
abstract class NoticeData with _$NoticeData {
  const factory NoticeData({
    @JsonKey(name: 'content_cn') String content,
    String date,
    int sort,
    int typeId,
  }) = _NoticeData;

  static NoticeData parseJson(Map<String, dynamic> jsonMap, int typeId) =>
      _$_NoticeData(
        content: (jsonMap.containsKey('content')
            ? jsonMap['content']
            : jsonMap[Global.jsonContentKey]) as String,
        date: jsonMap['date'] as String,
        sort: jsonMap['sort'] as int,
        typeId: typeId,
      );
}

List<NoticeData> noticeDataArrayToList(dynamic map, int typeId) =>
    JsonUtil.decodeArrayToModel(
      map,
      (jsonMap) => NoticeData.parseJson(jsonMap, typeId),
      tag: 'NoticeDataModel',
    );
