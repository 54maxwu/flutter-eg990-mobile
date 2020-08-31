import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_hot_model.freezed.dart';

@freezed
abstract class MovieHotModel with _$MovieHotModel {
  const factory MovieHotModel({
    @JsonKey(name: 'good_count') int goodCount,
    int mid,
    int cid,
    String pic,
    dynamic tid,
    String title,
    Object year,
  }) = _MovieHotModel;

  static MovieHotModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_MovieHotModel(
        goodCount: jsonMap['good_count'] as int,
        mid: jsonMap['mid'] as int,
        cid: (jsonMap.containsKey('cid')) ? jsonMap['cid'] as int : null,
        pic: jsonMap['pic'] as String,
        tid: jsonMap['tid'],
        title: jsonMap['title'] as String,
        year: jsonMap['year'],
      );
}
