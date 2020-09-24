// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'movie_post_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MoviePostModelTearOff {
  const _$MoviePostModelTearOff();

// ignore: unused_element
  _MoviePostModel call(
      {MoviePostData post,
      @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
          List<MovieHotModel> hotList}) {
    return _MoviePostModel(
      post: post,
      hotList: hotList,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MoviePostModel = _$MoviePostModelTearOff();

/// @nodoc
mixin _$MoviePostModel {
  MoviePostData get post;
  @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
  List<MovieHotModel> get hotList;

  $MoviePostModelCopyWith<MoviePostModel> get copyWith;
}

/// @nodoc
abstract class $MoviePostModelCopyWith<$Res> {
  factory $MoviePostModelCopyWith(
          MoviePostModel value, $Res Function(MoviePostModel) then) =
      _$MoviePostModelCopyWithImpl<$Res>;
  $Res call(
      {MoviePostData post,
      @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
          List<MovieHotModel> hotList});

  $MoviePostDataCopyWith<$Res> get post;
}

/// @nodoc
class _$MoviePostModelCopyWithImpl<$Res>
    implements $MoviePostModelCopyWith<$Res> {
  _$MoviePostModelCopyWithImpl(this._value, this._then);

  final MoviePostModel _value;
  // ignore: unused_field
  final $Res Function(MoviePostModel) _then;

  @override
  $Res call({
    Object post = freezed,
    Object hotList = freezed,
  }) {
    return _then(_value.copyWith(
      post: post == freezed ? _value.post : post as MoviePostData,
      hotList:
          hotList == freezed ? _value.hotList : hotList as List<MovieHotModel>,
    ));
  }

  @override
  $MoviePostDataCopyWith<$Res> get post {
    if (_value.post == null) {
      return null;
    }
    return $MoviePostDataCopyWith<$Res>(_value.post, (value) {
      return _then(_value.copyWith(post: value));
    });
  }
}

/// @nodoc
abstract class _$MoviePostModelCopyWith<$Res>
    implements $MoviePostModelCopyWith<$Res> {
  factory _$MoviePostModelCopyWith(
          _MoviePostModel value, $Res Function(_MoviePostModel) then) =
      __$MoviePostModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {MoviePostData post,
      @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
          List<MovieHotModel> hotList});

  @override
  $MoviePostDataCopyWith<$Res> get post;
}

/// @nodoc
class __$MoviePostModelCopyWithImpl<$Res>
    extends _$MoviePostModelCopyWithImpl<$Res>
    implements _$MoviePostModelCopyWith<$Res> {
  __$MoviePostModelCopyWithImpl(
      _MoviePostModel _value, $Res Function(_MoviePostModel) _then)
      : super(_value, (v) => _then(v as _MoviePostModel));

  @override
  _MoviePostModel get _value => super._value as _MoviePostModel;

  @override
  $Res call({
    Object post = freezed,
    Object hotList = freezed,
  }) {
    return _then(_MoviePostModel(
      post: post == freezed ? _value.post : post as MoviePostData,
      hotList:
          hotList == freezed ? _value.hotList : hotList as List<MovieHotModel>,
    ));
  }
}

/// @nodoc
class _$_MoviePostModel implements _MoviePostModel {
  const _$_MoviePostModel(
      {this.post,
      @JsonKey(name: 'hot', fromJson: decodeMovieHotModel) this.hotList});

  @override
  final MoviePostData post;
  @override
  @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
  final List<MovieHotModel> hotList;

  @override
  String toString() {
    return 'MoviePostModel(post: $post, hotList: $hotList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoviePostModel &&
            (identical(other.post, post) ||
                const DeepCollectionEquality().equals(other.post, post)) &&
            (identical(other.hotList, hotList) ||
                const DeepCollectionEquality().equals(other.hotList, hotList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(post) ^
      const DeepCollectionEquality().hash(hotList);

  @override
  _$MoviePostModelCopyWith<_MoviePostModel> get copyWith =>
      __$MoviePostModelCopyWithImpl<_MoviePostModel>(this, _$identity);
}

abstract class _MoviePostModel implements MoviePostModel {
  const factory _MoviePostModel(
      {MoviePostData post,
      @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
          List<MovieHotModel> hotList}) = _$_MoviePostModel;

  @override
  MoviePostData get post;
  @override
  @JsonKey(name: 'hot', fromJson: decodeMovieHotModel)
  List<MovieHotModel> get hotList;
  @override
  _$MoviePostModelCopyWith<_MoviePostModel> get copyWith;
}

/// @nodoc
class _$MoviePostDataTearOff {
  const _$MoviePostDataTearOff();

// ignore: unused_element
  _MoviePostData call(
      {@JsonKey(name: 'bad_count') int badCount,
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
      dynamic year}) {
    return _MoviePostData(
      badCount: badCount,
      buy: buy,
      buyCount: buyCount,
      cid: cid,
      content: content,
      duration: duration,
      favorite: favorite,
      free: free,
      freeSwitch: freeSwitch,
      goodCount: goodCount,
      hobby: hobby,
      mid: mid,
      phone: phone,
      pic: pic,
      playUrl: playUrl,
      point: point,
      price: price,
      sort: sort,
      status: status,
      tid: tid,
      title: title,
      vodkey: vodkey,
      watchCount: watchCount,
      year: year,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MoviePostData = _$MoviePostDataTearOff();

/// @nodoc
mixin _$MoviePostData {
  @JsonKey(name: 'bad_count')
  int get badCount;
  String get buy;
  @JsonKey(name: 'buy_count')
  int get buyCount;
  int get cid;
  String get content;
  String get duration;
  String get favorite;
  int get free;
  String get freeSwitch;
  @JsonKey(name: 'good_count')
  int get goodCount;
  String get hobby;
  int get mid;
  String get phone;
  String get pic;
  @JsonKey(name: 'play_url')
  String get playUrl;
  int get point;
  String get price;
  int get sort;
  String get status;
  dynamic get tid;
  String get title;
  String get vodkey;
  @JsonKey(name: 'watch_count')
  int get watchCount;
  dynamic get year;

  $MoviePostDataCopyWith<MoviePostData> get copyWith;
}

/// @nodoc
abstract class $MoviePostDataCopyWith<$Res> {
  factory $MoviePostDataCopyWith(
          MoviePostData value, $Res Function(MoviePostData) then) =
      _$MoviePostDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'bad_count') int badCount,
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
      dynamic year});
}

/// @nodoc
class _$MoviePostDataCopyWithImpl<$Res>
    implements $MoviePostDataCopyWith<$Res> {
  _$MoviePostDataCopyWithImpl(this._value, this._then);

  final MoviePostData _value;
  // ignore: unused_field
  final $Res Function(MoviePostData) _then;

  @override
  $Res call({
    Object badCount = freezed,
    Object buy = freezed,
    Object buyCount = freezed,
    Object cid = freezed,
    Object content = freezed,
    Object duration = freezed,
    Object favorite = freezed,
    Object free = freezed,
    Object freeSwitch = freezed,
    Object goodCount = freezed,
    Object hobby = freezed,
    Object mid = freezed,
    Object phone = freezed,
    Object pic = freezed,
    Object playUrl = freezed,
    Object point = freezed,
    Object price = freezed,
    Object sort = freezed,
    Object status = freezed,
    Object tid = freezed,
    Object title = freezed,
    Object vodkey = freezed,
    Object watchCount = freezed,
    Object year = freezed,
  }) {
    return _then(_value.copyWith(
      badCount: badCount == freezed ? _value.badCount : badCount as int,
      buy: buy == freezed ? _value.buy : buy as String,
      buyCount: buyCount == freezed ? _value.buyCount : buyCount as int,
      cid: cid == freezed ? _value.cid : cid as int,
      content: content == freezed ? _value.content : content as String,
      duration: duration == freezed ? _value.duration : duration as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
      free: free == freezed ? _value.free : free as int,
      freeSwitch:
          freeSwitch == freezed ? _value.freeSwitch : freeSwitch as String,
      goodCount: goodCount == freezed ? _value.goodCount : goodCount as int,
      hobby: hobby == freezed ? _value.hobby : hobby as String,
      mid: mid == freezed ? _value.mid : mid as int,
      phone: phone == freezed ? _value.phone : phone as String,
      pic: pic == freezed ? _value.pic : pic as String,
      playUrl: playUrl == freezed ? _value.playUrl : playUrl as String,
      point: point == freezed ? _value.point : point as int,
      price: price == freezed ? _value.price : price as String,
      sort: sort == freezed ? _value.sort : sort as int,
      status: status == freezed ? _value.status : status as String,
      tid: tid == freezed ? _value.tid : tid as dynamic,
      title: title == freezed ? _value.title : title as String,
      vodkey: vodkey == freezed ? _value.vodkey : vodkey as String,
      watchCount: watchCount == freezed ? _value.watchCount : watchCount as int,
      year: year == freezed ? _value.year : year as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$MoviePostDataCopyWith<$Res>
    implements $MoviePostDataCopyWith<$Res> {
  factory _$MoviePostDataCopyWith(
          _MoviePostData value, $Res Function(_MoviePostData) then) =
      __$MoviePostDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'bad_count') int badCount,
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
      dynamic year});
}

/// @nodoc
class __$MoviePostDataCopyWithImpl<$Res>
    extends _$MoviePostDataCopyWithImpl<$Res>
    implements _$MoviePostDataCopyWith<$Res> {
  __$MoviePostDataCopyWithImpl(
      _MoviePostData _value, $Res Function(_MoviePostData) _then)
      : super(_value, (v) => _then(v as _MoviePostData));

  @override
  _MoviePostData get _value => super._value as _MoviePostData;

  @override
  $Res call({
    Object badCount = freezed,
    Object buy = freezed,
    Object buyCount = freezed,
    Object cid = freezed,
    Object content = freezed,
    Object duration = freezed,
    Object favorite = freezed,
    Object free = freezed,
    Object freeSwitch = freezed,
    Object goodCount = freezed,
    Object hobby = freezed,
    Object mid = freezed,
    Object phone = freezed,
    Object pic = freezed,
    Object playUrl = freezed,
    Object point = freezed,
    Object price = freezed,
    Object sort = freezed,
    Object status = freezed,
    Object tid = freezed,
    Object title = freezed,
    Object vodkey = freezed,
    Object watchCount = freezed,
    Object year = freezed,
  }) {
    return _then(_MoviePostData(
      badCount: badCount == freezed ? _value.badCount : badCount as int,
      buy: buy == freezed ? _value.buy : buy as String,
      buyCount: buyCount == freezed ? _value.buyCount : buyCount as int,
      cid: cid == freezed ? _value.cid : cid as int,
      content: content == freezed ? _value.content : content as String,
      duration: duration == freezed ? _value.duration : duration as String,
      favorite: favorite == freezed ? _value.favorite : favorite as String,
      free: free == freezed ? _value.free : free as int,
      freeSwitch:
          freeSwitch == freezed ? _value.freeSwitch : freeSwitch as String,
      goodCount: goodCount == freezed ? _value.goodCount : goodCount as int,
      hobby: hobby == freezed ? _value.hobby : hobby as String,
      mid: mid == freezed ? _value.mid : mid as int,
      phone: phone == freezed ? _value.phone : phone as String,
      pic: pic == freezed ? _value.pic : pic as String,
      playUrl: playUrl == freezed ? _value.playUrl : playUrl as String,
      point: point == freezed ? _value.point : point as int,
      price: price == freezed ? _value.price : price as String,
      sort: sort == freezed ? _value.sort : sort as int,
      status: status == freezed ? _value.status : status as String,
      tid: tid == freezed ? _value.tid : tid as dynamic,
      title: title == freezed ? _value.title : title as String,
      vodkey: vodkey == freezed ? _value.vodkey : vodkey as String,
      watchCount: watchCount == freezed ? _value.watchCount : watchCount as int,
      year: year == freezed ? _value.year : year as dynamic,
    ));
  }
}

/// @nodoc
class _$_MoviePostData implements _MoviePostData {
  const _$_MoviePostData(
      {@JsonKey(name: 'bad_count') this.badCount,
      this.buy,
      @JsonKey(name: 'buy_count') this.buyCount,
      this.cid,
      this.content,
      this.duration,
      this.favorite,
      this.free,
      this.freeSwitch,
      @JsonKey(name: 'good_count') this.goodCount,
      this.hobby,
      this.mid,
      this.phone,
      this.pic,
      @JsonKey(name: 'play_url') this.playUrl,
      this.point,
      this.price,
      this.sort,
      this.status,
      this.tid,
      this.title,
      this.vodkey,
      @JsonKey(name: 'watch_count') this.watchCount,
      this.year});

  @override
  @JsonKey(name: 'bad_count')
  final int badCount;
  @override
  final String buy;
  @override
  @JsonKey(name: 'buy_count')
  final int buyCount;
  @override
  final int cid;
  @override
  final String content;
  @override
  final String duration;
  @override
  final String favorite;
  @override
  final int free;
  @override
  final String freeSwitch;
  @override
  @JsonKey(name: 'good_count')
  final int goodCount;
  @override
  final String hobby;
  @override
  final int mid;
  @override
  final String phone;
  @override
  final String pic;
  @override
  @JsonKey(name: 'play_url')
  final String playUrl;
  @override
  final int point;
  @override
  final String price;
  @override
  final int sort;
  @override
  final String status;
  @override
  final dynamic tid;
  @override
  final String title;
  @override
  final String vodkey;
  @override
  @JsonKey(name: 'watch_count')
  final int watchCount;
  @override
  final dynamic year;

  @override
  String toString() {
    return 'MoviePostData(badCount: $badCount, buy: $buy, buyCount: $buyCount, cid: $cid, content: $content, duration: $duration, favorite: $favorite, free: $free, freeSwitch: $freeSwitch, goodCount: $goodCount, hobby: $hobby, mid: $mid, phone: $phone, pic: $pic, playUrl: $playUrl, point: $point, price: $price, sort: $sort, status: $status, tid: $tid, title: $title, vodkey: $vodkey, watchCount: $watchCount, year: $year)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoviePostData &&
            (identical(other.badCount, badCount) ||
                const DeepCollectionEquality()
                    .equals(other.badCount, badCount)) &&
            (identical(other.buy, buy) ||
                const DeepCollectionEquality().equals(other.buy, buy)) &&
            (identical(other.buyCount, buyCount) ||
                const DeepCollectionEquality()
                    .equals(other.buyCount, buyCount)) &&
            (identical(other.cid, cid) ||
                const DeepCollectionEquality().equals(other.cid, cid)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.favorite, favorite) ||
                const DeepCollectionEquality()
                    .equals(other.favorite, favorite)) &&
            (identical(other.free, free) ||
                const DeepCollectionEquality().equals(other.free, free)) &&
            (identical(other.freeSwitch, freeSwitch) ||
                const DeepCollectionEquality()
                    .equals(other.freeSwitch, freeSwitch)) &&
            (identical(other.goodCount, goodCount) ||
                const DeepCollectionEquality()
                    .equals(other.goodCount, goodCount)) &&
            (identical(other.hobby, hobby) ||
                const DeepCollectionEquality().equals(other.hobby, hobby)) &&
            (identical(other.mid, mid) ||
                const DeepCollectionEquality().equals(other.mid, mid)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.pic, pic) ||
                const DeepCollectionEquality().equals(other.pic, pic)) &&
            (identical(other.playUrl, playUrl) ||
                const DeepCollectionEquality()
                    .equals(other.playUrl, playUrl)) &&
            (identical(other.point, point) ||
                const DeepCollectionEquality().equals(other.point, point)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.tid, tid) ||
                const DeepCollectionEquality().equals(other.tid, tid)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.vodkey, vodkey) ||
                const DeepCollectionEquality().equals(other.vodkey, vodkey)) &&
            (identical(other.watchCount, watchCount) ||
                const DeepCollectionEquality()
                    .equals(other.watchCount, watchCount)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(badCount) ^
      const DeepCollectionEquality().hash(buy) ^
      const DeepCollectionEquality().hash(buyCount) ^
      const DeepCollectionEquality().hash(cid) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(favorite) ^
      const DeepCollectionEquality().hash(free) ^
      const DeepCollectionEquality().hash(freeSwitch) ^
      const DeepCollectionEquality().hash(goodCount) ^
      const DeepCollectionEquality().hash(hobby) ^
      const DeepCollectionEquality().hash(mid) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(pic) ^
      const DeepCollectionEquality().hash(playUrl) ^
      const DeepCollectionEquality().hash(point) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(tid) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(vodkey) ^
      const DeepCollectionEquality().hash(watchCount) ^
      const DeepCollectionEquality().hash(year);

  @override
  _$MoviePostDataCopyWith<_MoviePostData> get copyWith =>
      __$MoviePostDataCopyWithImpl<_MoviePostData>(this, _$identity);
}

abstract class _MoviePostData implements MoviePostData {
  const factory _MoviePostData(
      {@JsonKey(name: 'bad_count') int badCount,
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
      dynamic year}) = _$_MoviePostData;

  @override
  @JsonKey(name: 'bad_count')
  int get badCount;
  @override
  String get buy;
  @override
  @JsonKey(name: 'buy_count')
  int get buyCount;
  @override
  int get cid;
  @override
  String get content;
  @override
  String get duration;
  @override
  String get favorite;
  @override
  int get free;
  @override
  String get freeSwitch;
  @override
  @JsonKey(name: 'good_count')
  int get goodCount;
  @override
  String get hobby;
  @override
  int get mid;
  @override
  String get phone;
  @override
  String get pic;
  @override
  @JsonKey(name: 'play_url')
  String get playUrl;
  @override
  int get point;
  @override
  String get price;
  @override
  int get sort;
  @override
  String get status;
  @override
  dynamic get tid;
  @override
  String get title;
  @override
  String get vodkey;
  @override
  @JsonKey(name: 'watch_count')
  int get watchCount;
  @override
  dynamic get year;
  @override
  _$MoviePostDataCopyWith<_MoviePostData> get copyWith;
}
