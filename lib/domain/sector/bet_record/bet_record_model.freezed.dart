// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'bet_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$BetRecordModelTearOff {
  const _$BetRecordModelTearOff();

// ignore: unused_element
  _BetRecordModel call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'last_page') int lastPage,
      @JsonKey(name: 'per_page') int perPage,
      int from,
      int to,
      int total,
      @JsonKey(name: 'next_page_url') String nextPageUrl,
      @JsonKey(name: 'prev_page_url') String prevPageUrl,
      @JsonKey(fromJson: decodeBetRecordData) List<BetRecordData> data}) {
    return _BetRecordModel(
      currentPage: currentPage,
      lastPage: lastPage,
      perPage: perPage,
      from: from,
      to: to,
      total: total,
      nextPageUrl: nextPageUrl,
      prevPageUrl: prevPageUrl,
      data: data,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $BetRecordModel = _$BetRecordModelTearOff();

/// @nodoc
mixin _$BetRecordModel {
  @JsonKey(name: 'current_page')
  int get currentPage;
  @JsonKey(name: 'last_page')
  int get lastPage;
  @JsonKey(name: 'per_page')
  int get perPage;
  int get from;
  int get to;
  int get total;
  @JsonKey(name: 'next_page_url')
  String get nextPageUrl;
  @JsonKey(name: 'prev_page_url')
  String get prevPageUrl;
  @JsonKey(fromJson: decodeBetRecordData)
  List<BetRecordData> get data;

  @JsonKey(ignore: true)
  $BetRecordModelCopyWith<BetRecordModel> get copyWith;
}

/// @nodoc
abstract class $BetRecordModelCopyWith<$Res> {
  factory $BetRecordModelCopyWith(
          BetRecordModel value, $Res Function(BetRecordModel) then) =
      _$BetRecordModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'last_page') int lastPage,
      @JsonKey(name: 'per_page') int perPage,
      int from,
      int to,
      int total,
      @JsonKey(name: 'next_page_url') String nextPageUrl,
      @JsonKey(name: 'prev_page_url') String prevPageUrl,
      @JsonKey(fromJson: decodeBetRecordData) List<BetRecordData> data});
}

/// @nodoc
class _$BetRecordModelCopyWithImpl<$Res>
    implements $BetRecordModelCopyWith<$Res> {
  _$BetRecordModelCopyWithImpl(this._value, this._then);

  final BetRecordModel _value;
  // ignore: unused_field
  final $Res Function(BetRecordModel) _then;

  @override
  $Res call({
    Object currentPage = freezed,
    Object lastPage = freezed,
    Object perPage = freezed,
    Object from = freezed,
    Object to = freezed,
    Object total = freezed,
    Object nextPageUrl = freezed,
    Object prevPageUrl = freezed,
    Object data = freezed,
  }) {
    return _then(_value.copyWith(
      currentPage:
          currentPage == freezed ? _value.currentPage : currentPage as int,
      lastPage: lastPage == freezed ? _value.lastPage : lastPage as int,
      perPage: perPage == freezed ? _value.perPage : perPage as int,
      from: from == freezed ? _value.from : from as int,
      to: to == freezed ? _value.to : to as int,
      total: total == freezed ? _value.total : total as int,
      nextPageUrl:
          nextPageUrl == freezed ? _value.nextPageUrl : nextPageUrl as String,
      prevPageUrl:
          prevPageUrl == freezed ? _value.prevPageUrl : prevPageUrl as String,
      data: data == freezed ? _value.data : data as List<BetRecordData>,
    ));
  }
}

/// @nodoc
abstract class _$BetRecordModelCopyWith<$Res>
    implements $BetRecordModelCopyWith<$Res> {
  factory _$BetRecordModelCopyWith(
          _BetRecordModel value, $Res Function(_BetRecordModel) then) =
      __$BetRecordModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'last_page') int lastPage,
      @JsonKey(name: 'per_page') int perPage,
      int from,
      int to,
      int total,
      @JsonKey(name: 'next_page_url') String nextPageUrl,
      @JsonKey(name: 'prev_page_url') String prevPageUrl,
      @JsonKey(fromJson: decodeBetRecordData) List<BetRecordData> data});
}

/// @nodoc
class __$BetRecordModelCopyWithImpl<$Res>
    extends _$BetRecordModelCopyWithImpl<$Res>
    implements _$BetRecordModelCopyWith<$Res> {
  __$BetRecordModelCopyWithImpl(
      _BetRecordModel _value, $Res Function(_BetRecordModel) _then)
      : super(_value, (v) => _then(v as _BetRecordModel));

  @override
  _BetRecordModel get _value => super._value as _BetRecordModel;

  @override
  $Res call({
    Object currentPage = freezed,
    Object lastPage = freezed,
    Object perPage = freezed,
    Object from = freezed,
    Object to = freezed,
    Object total = freezed,
    Object nextPageUrl = freezed,
    Object prevPageUrl = freezed,
    Object data = freezed,
  }) {
    return _then(_BetRecordModel(
      currentPage:
          currentPage == freezed ? _value.currentPage : currentPage as int,
      lastPage: lastPage == freezed ? _value.lastPage : lastPage as int,
      perPage: perPage == freezed ? _value.perPage : perPage as int,
      from: from == freezed ? _value.from : from as int,
      to: to == freezed ? _value.to : to as int,
      total: total == freezed ? _value.total : total as int,
      nextPageUrl:
          nextPageUrl == freezed ? _value.nextPageUrl : nextPageUrl as String,
      prevPageUrl:
          prevPageUrl == freezed ? _value.prevPageUrl : prevPageUrl as String,
      data: data == freezed ? _value.data : data as List<BetRecordData>,
    ));
  }
}

/// @nodoc
class _$_BetRecordModel implements _BetRecordModel {
  const _$_BetRecordModel(
      {@JsonKey(name: 'current_page') this.currentPage,
      @JsonKey(name: 'last_page') this.lastPage,
      @JsonKey(name: 'per_page') this.perPage,
      this.from,
      this.to,
      this.total,
      @JsonKey(name: 'next_page_url') this.nextPageUrl,
      @JsonKey(name: 'prev_page_url') this.prevPageUrl,
      @JsonKey(fromJson: decodeBetRecordData) this.data});

  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'last_page')
  final int lastPage;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  final int from;
  @override
  final int to;
  @override
  final int total;
  @override
  @JsonKey(name: 'next_page_url')
  final String nextPageUrl;
  @override
  @JsonKey(name: 'prev_page_url')
  final String prevPageUrl;
  @override
  @JsonKey(fromJson: decodeBetRecordData)
  final List<BetRecordData> data;

  @override
  String toString() {
    return 'BetRecordModel(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, from: $from, to: $to, total: $total, nextPageUrl: $nextPageUrl, prevPageUrl: $prevPageUrl, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BetRecordModel &&
            (identical(other.currentPage, currentPage) ||
                const DeepCollectionEquality()
                    .equals(other.currentPage, currentPage)) &&
            (identical(other.lastPage, lastPage) ||
                const DeepCollectionEquality()
                    .equals(other.lastPage, lastPage)) &&
            (identical(other.perPage, perPage) ||
                const DeepCollectionEquality()
                    .equals(other.perPage, perPage)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.nextPageUrl, nextPageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.nextPageUrl, nextPageUrl)) &&
            (identical(other.prevPageUrl, prevPageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.prevPageUrl, prevPageUrl)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(currentPage) ^
      const DeepCollectionEquality().hash(lastPage) ^
      const DeepCollectionEquality().hash(perPage) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(nextPageUrl) ^
      const DeepCollectionEquality().hash(prevPageUrl) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$BetRecordModelCopyWith<_BetRecordModel> get copyWith =>
      __$BetRecordModelCopyWithImpl<_BetRecordModel>(this, _$identity);
}

abstract class _BetRecordModel implements BetRecordModel {
  const factory _BetRecordModel(
          {@JsonKey(name: 'current_page') int currentPage,
          @JsonKey(name: 'last_page') int lastPage,
          @JsonKey(name: 'per_page') int perPage,
          int from,
          int to,
          int total,
          @JsonKey(name: 'next_page_url') String nextPageUrl,
          @JsonKey(name: 'prev_page_url') String prevPageUrl,
          @JsonKey(fromJson: decodeBetRecordData) List<BetRecordData> data}) =
      _$_BetRecordModel;

  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'last_page')
  int get lastPage;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  int get from;
  @override
  int get to;
  @override
  int get total;
  @override
  @JsonKey(name: 'next_page_url')
  String get nextPageUrl;
  @override
  @JsonKey(name: 'prev_page_url')
  String get prevPageUrl;
  @override
  @JsonKey(fromJson: decodeBetRecordData)
  List<BetRecordData> get data;
  @override
  @JsonKey(ignore: true)
  _$BetRecordModelCopyWith<_BetRecordModel> get copyWith;
}
