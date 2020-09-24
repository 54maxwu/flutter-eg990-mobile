// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'movie_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MovieCategoryModelTearOff {
  const _$MovieCategoryModelTearOff();

// ignore: unused_element
  _MovieCategoryModel call(
      {int tid, String name, String status, int sort, int count}) {
    return _MovieCategoryModel(
      tid: tid,
      name: name,
      status: status,
      sort: sort,
      count: count,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MovieCategoryModel = _$MovieCategoryModelTearOff();

/// @nodoc
mixin _$MovieCategoryModel {
  int get tid;
  String get name;
  String get status;
  int get sort;
  int get count;

  $MovieCategoryModelCopyWith<MovieCategoryModel> get copyWith;
}

/// @nodoc
abstract class $MovieCategoryModelCopyWith<$Res> {
  factory $MovieCategoryModelCopyWith(
          MovieCategoryModel value, $Res Function(MovieCategoryModel) then) =
      _$MovieCategoryModelCopyWithImpl<$Res>;
  $Res call({int tid, String name, String status, int sort, int count});
}

/// @nodoc
class _$MovieCategoryModelCopyWithImpl<$Res>
    implements $MovieCategoryModelCopyWith<$Res> {
  _$MovieCategoryModelCopyWithImpl(this._value, this._then);

  final MovieCategoryModel _value;
  // ignore: unused_field
  final $Res Function(MovieCategoryModel) _then;

  @override
  $Res call({
    Object tid = freezed,
    Object name = freezed,
    Object status = freezed,
    Object sort = freezed,
    Object count = freezed,
  }) {
    return _then(_value.copyWith(
      tid: tid == freezed ? _value.tid : tid as int,
      name: name == freezed ? _value.name : name as String,
      status: status == freezed ? _value.status : status as String,
      sort: sort == freezed ? _value.sort : sort as int,
      count: count == freezed ? _value.count : count as int,
    ));
  }
}

/// @nodoc
abstract class _$MovieCategoryModelCopyWith<$Res>
    implements $MovieCategoryModelCopyWith<$Res> {
  factory _$MovieCategoryModelCopyWith(
          _MovieCategoryModel value, $Res Function(_MovieCategoryModel) then) =
      __$MovieCategoryModelCopyWithImpl<$Res>;
  @override
  $Res call({int tid, String name, String status, int sort, int count});
}

/// @nodoc
class __$MovieCategoryModelCopyWithImpl<$Res>
    extends _$MovieCategoryModelCopyWithImpl<$Res>
    implements _$MovieCategoryModelCopyWith<$Res> {
  __$MovieCategoryModelCopyWithImpl(
      _MovieCategoryModel _value, $Res Function(_MovieCategoryModel) _then)
      : super(_value, (v) => _then(v as _MovieCategoryModel));

  @override
  _MovieCategoryModel get _value => super._value as _MovieCategoryModel;

  @override
  $Res call({
    Object tid = freezed,
    Object name = freezed,
    Object status = freezed,
    Object sort = freezed,
    Object count = freezed,
  }) {
    return _then(_MovieCategoryModel(
      tid: tid == freezed ? _value.tid : tid as int,
      name: name == freezed ? _value.name : name as String,
      status: status == freezed ? _value.status : status as String,
      sort: sort == freezed ? _value.sort : sort as int,
      count: count == freezed ? _value.count : count as int,
    ));
  }
}

/// @nodoc
class _$_MovieCategoryModel implements _MovieCategoryModel {
  const _$_MovieCategoryModel(
      {this.tid, this.name, this.status, this.sort, this.count});

  @override
  final int tid;
  @override
  final String name;
  @override
  final String status;
  @override
  final int sort;
  @override
  final int count;

  @override
  String toString() {
    return 'MovieCategoryModel(tid: $tid, name: $name, status: $status, sort: $sort, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MovieCategoryModel &&
            (identical(other.tid, tid) ||
                const DeepCollectionEquality().equals(other.tid, tid)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(tid) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(count);

  @override
  _$MovieCategoryModelCopyWith<_MovieCategoryModel> get copyWith =>
      __$MovieCategoryModelCopyWithImpl<_MovieCategoryModel>(this, _$identity);
}

abstract class _MovieCategoryModel implements MovieCategoryModel {
  const factory _MovieCategoryModel(
      {int tid,
      String name,
      String status,
      int sort,
      int count}) = _$_MovieCategoryModel;

  @override
  int get tid;
  @override
  String get name;
  @override
  String get status;
  @override
  int get sort;
  @override
  int get count;
  @override
  _$MovieCategoryModelCopyWith<_MovieCategoryModel> get copyWith;
}
