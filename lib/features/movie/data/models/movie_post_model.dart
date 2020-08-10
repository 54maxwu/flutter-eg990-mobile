import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie_hot_model.dart';

part 'movie_post_model.freezed.dart';

@freezed
abstract class MoviePostModel with _$MoviePostModel {
  const factory MoviePostModel({
    MoviePostData post,
    @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
        List<MovieHotModel> hotList,
  }) = _MoviePostModel;

  static MoviePostModel jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_MoviePostModel(
        post: (jsonMap.containsKey('post'))
            ? MoviePostData.jsonToModel(jsonMap['post'])
            : null,
        hotList: (jsonMap.containsKey('hot'))
            ? decodeMovieHotModel(jsonMap['hot'])
            : [],
      );
}

List<MovieHotModel> decodeMovieHotModel(dynamic str) =>
    JsonUtil.decodeArrayToModel(
      str,
      (jsonMap) => MovieHotModel.jsonToModel(jsonMap),
      tag: 'MovieHotModel',
    );

@freezed
abstract class MoviePostData with _$MoviePostData {
  const factory MoviePostData({
    @JsonKey(name: 'bad_count') int badCount,
    String buy,
    @JsonKey(name: 'buy_count') int buyCount,
    int cid,
    String content,
    String duration,
    String favorite,
    int free,
    String freeSwitch,
    @JsonKey(name: 'good_count') int goodCount,
    String hobby,
    int mid,
    String phone,
    String pic,
    @JsonKey(name: 'play_url') String playUrl,
    int point,
    String price,
    int sort,
    String status,
    dynamic tid,
    String title,
    String vodkey,
    @JsonKey(name: 'watch_count') int watchCount,
    dynamic year,
  }) = _MoviePostData;

  static MoviePostData jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_MoviePostData(
        badCount: jsonMap['bad_count'] as int,
        buy: jsonMap['buy'] as String,
        buyCount: jsonMap['buy_count'] as int,
        cid: jsonMap['cid'] as int,
        content: jsonMap['content'] as String,
        duration: jsonMap['duration'] as String,
        favorite: jsonMap['favorite'] as String,
        free: jsonMap['free'] as int,
        freeSwitch: jsonMap['freeSwitch'] as String,
        goodCount: jsonMap['good_count'] as int,
        hobby: jsonMap['hobby'] as String,
        mid: jsonMap['mid'] as int,
        phone: jsonMap['phone'] as String,
        pic: jsonMap['pic'] as String,
        playUrl: jsonMap['play_url'] as String,
        point: jsonMap['point'] as int,
        price: jsonMap['price'] as String,
        sort: jsonMap['sort'] as int,
        status: jsonMap['status'] as String,
        tid: jsonMap['tid'],
        title: jsonMap['title'] as String,
        vodkey: jsonMap['vodkey'] as String,
        watchCount: jsonMap['watch_count'] as int,
        year: jsonMap['year'],
      );
}

extension MoviePostDataExtension on MoviePostData {
  bool get isPurchased => buy == 'success' || freeSwitch == 'open';
  bool get isFreeToWatch => buy == 'free' && freeSwitch == 'open';
  bool get clickedHobby => hobby == '1' || hobby == '-1';
  bool get clickedFavorite => favorite == 'success';
  bool get clickedGood => hobby == '1';
  bool get clickedBad => hobby == '-1';
}
