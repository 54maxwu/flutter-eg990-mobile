// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'mission_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MissionListModelTearOff {
  const _$MissionListModelTearOff();

// ignore: unused_element
  _MissionListModel call(
      {@JsonKey(name: 'day', fromJson: decodeMissionList)
          List<MissionModel> daily,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> limit,
      @JsonKey(name: 'month', fromJson: decodeMissionList)
          List<MissionModel> monthly,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> once,
      @JsonKey(name: 'week', fromJson: decodeMissionList)
          List<MissionModel> weekly}) {
    return _MissionListModel(
      daily: daily,
      limit: limit,
      monthly: monthly,
      once: once,
      weekly: weekly,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MissionListModel = _$MissionListModelTearOff();

/// @nodoc
mixin _$MissionListModel {
  @JsonKey(name: 'day', fromJson: decodeMissionList)
  List<MissionModel> get daily;
  @JsonKey(fromJson: decodeMissionList)
  List<MissionModel> get limit;
  @JsonKey(name: 'month', fromJson: decodeMissionList)
  List<MissionModel> get monthly;
  @JsonKey(fromJson: decodeMissionList)
  List<MissionModel> get once;
  @JsonKey(name: 'week', fromJson: decodeMissionList)
  List<MissionModel> get weekly;

  @JsonKey(ignore: true)
  $MissionListModelCopyWith<MissionListModel> get copyWith;
}

/// @nodoc
abstract class $MissionListModelCopyWith<$Res> {
  factory $MissionListModelCopyWith(
          MissionListModel value, $Res Function(MissionListModel) then) =
      _$MissionListModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'day', fromJson: decodeMissionList)
          List<MissionModel> daily,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> limit,
      @JsonKey(name: 'month', fromJson: decodeMissionList)
          List<MissionModel> monthly,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> once,
      @JsonKey(name: 'week', fromJson: decodeMissionList)
          List<MissionModel> weekly});
}

/// @nodoc
class _$MissionListModelCopyWithImpl<$Res>
    implements $MissionListModelCopyWith<$Res> {
  _$MissionListModelCopyWithImpl(this._value, this._then);

  final MissionListModel _value;
  // ignore: unused_field
  final $Res Function(MissionListModel) _then;

  @override
  $Res call({
    Object daily = freezed,
    Object limit = freezed,
    Object monthly = freezed,
    Object once = freezed,
    Object weekly = freezed,
  }) {
    return _then(_value.copyWith(
      daily: daily == freezed ? _value.daily : daily as List<MissionModel>,
      limit: limit == freezed ? _value.limit : limit as List<MissionModel>,
      monthly:
          monthly == freezed ? _value.monthly : monthly as List<MissionModel>,
      once: once == freezed ? _value.once : once as List<MissionModel>,
      weekly: weekly == freezed ? _value.weekly : weekly as List<MissionModel>,
    ));
  }
}

/// @nodoc
abstract class _$MissionListModelCopyWith<$Res>
    implements $MissionListModelCopyWith<$Res> {
  factory _$MissionListModelCopyWith(
          _MissionListModel value, $Res Function(_MissionListModel) then) =
      __$MissionListModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'day', fromJson: decodeMissionList)
          List<MissionModel> daily,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> limit,
      @JsonKey(name: 'month', fromJson: decodeMissionList)
          List<MissionModel> monthly,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> once,
      @JsonKey(name: 'week', fromJson: decodeMissionList)
          List<MissionModel> weekly});
}

/// @nodoc
class __$MissionListModelCopyWithImpl<$Res>
    extends _$MissionListModelCopyWithImpl<$Res>
    implements _$MissionListModelCopyWith<$Res> {
  __$MissionListModelCopyWithImpl(
      _MissionListModel _value, $Res Function(_MissionListModel) _then)
      : super(_value, (v) => _then(v as _MissionListModel));

  @override
  _MissionListModel get _value => super._value as _MissionListModel;

  @override
  $Res call({
    Object daily = freezed,
    Object limit = freezed,
    Object monthly = freezed,
    Object once = freezed,
    Object weekly = freezed,
  }) {
    return _then(_MissionListModel(
      daily: daily == freezed ? _value.daily : daily as List<MissionModel>,
      limit: limit == freezed ? _value.limit : limit as List<MissionModel>,
      monthly:
          monthly == freezed ? _value.monthly : monthly as List<MissionModel>,
      once: once == freezed ? _value.once : once as List<MissionModel>,
      weekly: weekly == freezed ? _value.weekly : weekly as List<MissionModel>,
    ));
  }
}

/// @nodoc
class _$_MissionListModel implements _MissionListModel {
  const _$_MissionListModel(
      {@JsonKey(name: 'day', fromJson: decodeMissionList) this.daily,
      @JsonKey(fromJson: decodeMissionList) this.limit,
      @JsonKey(name: 'month', fromJson: decodeMissionList) this.monthly,
      @JsonKey(fromJson: decodeMissionList) this.once,
      @JsonKey(name: 'week', fromJson: decodeMissionList) this.weekly});

  @override
  @JsonKey(name: 'day', fromJson: decodeMissionList)
  final List<MissionModel> daily;
  @override
  @JsonKey(fromJson: decodeMissionList)
  final List<MissionModel> limit;
  @override
  @JsonKey(name: 'month', fromJson: decodeMissionList)
  final List<MissionModel> monthly;
  @override
  @JsonKey(fromJson: decodeMissionList)
  final List<MissionModel> once;
  @override
  @JsonKey(name: 'week', fromJson: decodeMissionList)
  final List<MissionModel> weekly;

  @override
  String toString() {
    return 'MissionListModel(daily: $daily, limit: $limit, monthly: $monthly, once: $once, weekly: $weekly)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MissionListModel &&
            (identical(other.daily, daily) ||
                const DeepCollectionEquality().equals(other.daily, daily)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.monthly, monthly) ||
                const DeepCollectionEquality()
                    .equals(other.monthly, monthly)) &&
            (identical(other.once, once) ||
                const DeepCollectionEquality().equals(other.once, once)) &&
            (identical(other.weekly, weekly) ||
                const DeepCollectionEquality().equals(other.weekly, weekly)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(daily) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(monthly) ^
      const DeepCollectionEquality().hash(once) ^
      const DeepCollectionEquality().hash(weekly);

  @JsonKey(ignore: true)
  @override
  _$MissionListModelCopyWith<_MissionListModel> get copyWith =>
      __$MissionListModelCopyWithImpl<_MissionListModel>(this, _$identity);
}

abstract class _MissionListModel implements MissionListModel {
  const factory _MissionListModel(
      {@JsonKey(name: 'day', fromJson: decodeMissionList)
          List<MissionModel> daily,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> limit,
      @JsonKey(name: 'month', fromJson: decodeMissionList)
          List<MissionModel> monthly,
      @JsonKey(fromJson: decodeMissionList)
          List<MissionModel> once,
      @JsonKey(name: 'week', fromJson: decodeMissionList)
          List<MissionModel> weekly}) = _$_MissionListModel;

  @override
  @JsonKey(name: 'day', fromJson: decodeMissionList)
  List<MissionModel> get daily;
  @override
  @JsonKey(fromJson: decodeMissionList)
  List<MissionModel> get limit;
  @override
  @JsonKey(name: 'month', fromJson: decodeMissionList)
  List<MissionModel> get monthly;
  @override
  @JsonKey(fromJson: decodeMissionList)
  List<MissionModel> get once;
  @override
  @JsonKey(name: 'week', fromJson: decodeMissionList)
  List<MissionModel> get weekly;
  @override
  @JsonKey(ignore: true)
  _$MissionListModelCopyWith<_MissionListModel> get copyWith;
}
