// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'movie_hot_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$MovieHotModelTearOff {
  const _$MovieHotModelTearOff();

// ignore: unused_element
  _MovieHotModel call(
      {@JsonKey(name: 'good_count') int goodCount,
      int mid,
      int cid,
      String pic,
      dynamic tid,
      String title,
      Object year}) {
    return _MovieHotModel(
      goodCount: goodCount,
      mid: mid,
      cid: cid,
      pic: pic,
      tid: tid,
      title: title,
      year: year,
    );
  }
}

// ignore: unused_element
const $MovieHotModel = _$MovieHotModelTearOff();

mixin _$MovieHotModel {
  @JsonKey(name: 'good_count')
  int get goodCount;
  int get mid;
  int get cid;
  String get pic;
  dynamic get tid;
  String get title;
  Object get year;

  $MovieHotModelCopyWith<MovieHotModel> get copyWith;
}

abstract class $MovieHotModelCopyWith<$Res> {
  factory $MovieHotModelCopyWith(
          MovieHotModel value, $Res Function(MovieHotModel) then) =
      _$MovieHotModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'good_count') int goodCount,
      int mid,
      int cid,
      String pic,
      dynamic tid,
      String title,
      Object year});
}

class _$MovieHotModelCopyWithImpl<$Res>
    implements $MovieHotModelCopyWith<$Res> {
  _$MovieHotModelCopyWithImpl(this._value, this._then);

  final MovieHotModel _value;
  // ignore: unused_field
  final $Res Function(MovieHotModel) _then;

  @override
  $Res call({
    Object goodCount = freezed,
    Object mid = freezed,
    Object cid = freezed,
    Object pic = freezed,
    Object tid = freezed,
    Object title = freezed,
    Object year = freezed,
  }) {
    return _then(_value.copyWith(
      goodCount: goodCount == freezed ? _value.goodCount : goodCount as int,
      mid: mid == freezed ? _value.mid : mid as int,
      cid: cid == freezed ? _value.cid : cid as int,
      pic: pic == freezed ? _value.pic : pic as String,
      tid: tid == freezed ? _value.tid : tid as dynamic,
      title: title == freezed ? _value.title : title as String,
      year: year == freezed ? _value.year : year,
    ));
  }
}

abstract class _$MovieHotModelCopyWith<$Res>
    implements $MovieHotModelCopyWith<$Res> {
  factory _$MovieHotModelCopyWith(
          _MovieHotModel value, $Res Function(_MovieHotModel) then) =
      __$MovieHotModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'good_count') int goodCount,
      int mid,
      int cid,
      String pic,
      dynamic tid,
      String title,
      Object year});
}

class __$MovieHotModelCopyWithImpl<$Res>
    extends _$MovieHotModelCopyWithImpl<$Res>
    implements _$MovieHotModelCopyWith<$Res> {
  __$MovieHotModelCopyWithImpl(
      _MovieHotModel _value, $Res Function(_MovieHotModel) _then)
      : super(_value, (v) => _then(v as _MovieHotModel));

  @override
  _MovieHotModel get _value => super._value as _MovieHotModel;

  @override
  $Res call({
    Object goodCount = freezed,
    Object mid = freezed,
    Object cid = freezed,
    Object pic = freezed,
    Object tid = freezed,
    Object title = freezed,
    Object year = freezed,
  }) {
    return _then(_MovieHotModel(
      goodCount: goodCount == freezed ? _value.goodCount : goodCount as int,
      mid: mid == freezed ? _value.mid : mid as int,
      cid: cid == freezed ? _value.cid : cid as int,
      pic: pic == freezed ? _value.pic : pic as String,
      tid: tid == freezed ? _value.tid : tid as dynamic,
      title: title == freezed ? _value.title : title as String,
      year: year == freezed ? _value.year : year,
    ));
  }
}

class _$_MovieHotModel implements _MovieHotModel {
  const _$_MovieHotModel(
      {@JsonKey(name: 'good_count') this.goodCount,
      this.mid,
      this.cid,
      this.pic,
      this.tid,
      this.title,
      this.year});

  @override
  @JsonKey(name: 'good_count')
  final int goodCount;
  @override
  final int mid;
  @override
  final int cid;
  @override
  final String pic;
  @override
  final dynamic tid;
  @override
  final String title;
  @override
  final Object year;

  @override
  String toString() {
    return 'MovieHotModel(goodCount: $goodCount, mid: $mid, cid: $cid, pic: $pic, tid: $tid, title: $title, year: $year)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MovieHotModel &&
            (identical(other.goodCount, goodCount) ||
                const DeepCollectionEquality()
                    .equals(other.goodCount, goodCount)) &&
            (identical(other.mid, mid) ||
                const DeepCollectionEquality().equals(other.mid, mid)) &&
            (identical(other.cid, cid) ||
                const DeepCollectionEquality().equals(other.cid, cid)) &&
            (identical(other.pic, pic) ||
                const DeepCollectionEquality().equals(other.pic, pic)) &&
            (identical(other.tid, tid) ||
                const DeepCollectionEquality().equals(other.tid, tid)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(goodCount) ^
      const DeepCollectionEquality().hash(mid) ^
      const DeepCollectionEquality().hash(cid) ^
      const DeepCollectionEquality().hash(pic) ^
      const DeepCollectionEquality().hash(tid) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(year);

  @override
  _$MovieHotModelCopyWith<_MovieHotModel> get copyWith =>
      __$MovieHotModelCopyWithImpl<_MovieHotModel>(this, _$identity);
}

abstract class _MovieHotModel implements MovieHotModel {
  const factory _MovieHotModel(
      {@JsonKey(name: 'good_count') int goodCount,
      int mid,
      int cid,
      String pic,
      dynamic tid,
      String title,
      Object year}) = _$_MovieHotModel;

  @override
  @JsonKey(name: 'good_count')
  int get goodCount;
  @override
  int get mid;
  @override
  int get cid;
  @override
  String get pic;
  @override
  dynamic get tid;
  @override
  String get title;
  @override
  Object get year;
  @override
  _$MovieHotModelCopyWith<_MovieHotModel> get copyWith;
}
