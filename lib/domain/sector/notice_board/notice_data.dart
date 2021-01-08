import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_data.freezed.dart';

@freezed
abstract class NoticeData with _$NoticeData {
  const factory NoticeData({
    @JsonKey(name: 'content_cn', defaultValue: '') String content,
    @JsonKey(name: 'content_us', defaultValue: '') String contentEN,
    @JsonKey(name: 'content_vn', defaultValue: '') String contentVI,
    @JsonKey(name: 'content_th', defaultValue: '') String contentTH,
    String date,
    int sort,
    int typeId,
  }) = _NoticeData;

  static NoticeData parseJson(Map<String, dynamic> jsonMap, int typeId) =>
      _$_NoticeData(
        content: (jsonMap.containsKey('content')
            ? jsonMap['content']
            : jsonMap['content_cn']) as String,
        contentEN: (jsonMap.containsKey('content_us'))
            ? jsonMap['content_us'] as String
            : '',
        contentVI: (jsonMap.containsKey('content_vn'))
            ? jsonMap['content_vn'] as String
            : '',
        contentTH: (jsonMap.containsKey('content_th'))
            ? jsonMap['content_th'] as String
            : '',
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
