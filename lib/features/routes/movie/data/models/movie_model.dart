import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';

@freezed
abstract class MovieModel with _$MovieModel {
  const factory MovieModel({
    @JsonKey(name: 'bad_count') int badCount,
    @JsonKey(name: 'buy_count') int buyCount,
    int cid,
    String content,
    String duration,
    @JsonKey(name: 'good_count') int goodCount,
    int mid,
    String pic,
    String price,
    int tid,
    String title,
    @JsonKey(name: 'watch_count') int watchCount,
    dynamic year,
    dynamic key,
  }) = _MovieModel;

  static MovieModel jsonToModel(Map<String, dynamic> jsonMap) => _$_MovieModel(
        badCount: jsonMap['bad_count'] as int,
        buyCount: jsonMap['buy_count'] as int,
        cid: jsonMap['cid'] as int,
        content: jsonMap['content'] as String,
        duration: jsonMap['duration'] as String,
        goodCount: jsonMap['good_count'] as int,
        mid: jsonMap['mid'] as int,
        pic: jsonMap['pic'] as String,
        price: jsonMap['price'] as String,
        tid: jsonMap['tid'] as int,
        title: jsonMap['title'] as String,
        watchCount: jsonMap['watch_count'] as int,
        year: jsonMap['year'],
        key: jsonMap['key'],
      );
}
