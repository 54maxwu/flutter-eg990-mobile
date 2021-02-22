// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'mission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MissionModelTearOff {
  const _$MissionModelTearOff();

// ignore: unused_element
  _MissionModel call(
      {@JsonKey(required: true) int id,
      String title,
      num member,
      num required,
      @JsonKey(name: 'prize_type') String prizeType,
      int prize,
      @JsonKey(name: 'prize_amount') num prizeAmount,
      int type,
      int sort,
      String url,
      String tab,
      String info,
      String auto,
      String complete}) {
    return _MissionModel(
      id: id,
      title: title,
      member: member,
      required: required,
      prizeType: prizeType,
      prize: prize,
      prizeAmount: prizeAmount,
      type: type,
      sort: sort,
      url: url,
      tab: tab,
      info: info,
      auto: auto,
      complete: complete,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MissionModel = _$MissionModelTearOff();

/// @nodoc
mixin _$MissionModel {
  @JsonKey(required: true)
  int get id; // mission title
  String get title; // member complete count
  num get member; // required complete count
  num get required; // 0 = bonus credit; 1 = store point
  @JsonKey(name: 'prize_type')
  String get prizeType; //
  int get prize; // prize amount on mission complete
  @JsonKey(name: 'prize_amount')
  num get prizeAmount; // 1 = deposit; 2 = rollback; 3 = complete count; 4 = bind
  int get type; // mission list order
  int get sort; // mission navigate url
  String get url; // 0 = show dialog; 1 = navigate;
  String get tab; // mission detail
  String get info; // 0 = auto; 1 = manual
  String get auto; // 0 = complete; 1 = not complete; 3 = received
  String get complete;

  @JsonKey(ignore: true)
  $MissionModelCopyWith<MissionModel> get copyWith;
}

/// @nodoc
abstract class $MissionModelCopyWith<$Res> {
  factory $MissionModelCopyWith(
          MissionModel value, $Res Function(MissionModel) then) =
      _$MissionModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(required: true) int id,
      String title,
      num member,
      num required,
      @JsonKey(name: 'prize_type') String prizeType,
      int prize,
      @JsonKey(name: 'prize_amount') num prizeAmount,
      int type,
      int sort,
      String url,
      String tab,
      String info,
      String auto,
      String complete});
}

/// @nodoc
class _$MissionModelCopyWithImpl<$Res> implements $MissionModelCopyWith<$Res> {
  _$MissionModelCopyWithImpl(this._value, this._then);

  final MissionModel _value;
  // ignore: unused_field
  final $Res Function(MissionModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object member = freezed,
    Object required = freezed,
    Object prizeType = freezed,
    Object prize = freezed,
    Object prizeAmount = freezed,
    Object type = freezed,
    Object sort = freezed,
    Object url = freezed,
    Object tab = freezed,
    Object info = freezed,
    Object auto = freezed,
    Object complete = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      member: member == freezed ? _value.member : member as num,
      required: required == freezed ? _value.required : required as num,
      prizeType: prizeType == freezed ? _value.prizeType : prizeType as String,
      prize: prize == freezed ? _value.prize : prize as int,
      prizeAmount:
          prizeAmount == freezed ? _value.prizeAmount : prizeAmount as num,
      type: type == freezed ? _value.type : type as int,
      sort: sort == freezed ? _value.sort : sort as int,
      url: url == freezed ? _value.url : url as String,
      tab: tab == freezed ? _value.tab : tab as String,
      info: info == freezed ? _value.info : info as String,
      auto: auto == freezed ? _value.auto : auto as String,
      complete: complete == freezed ? _value.complete : complete as String,
    ));
  }
}

/// @nodoc
abstract class _$MissionModelCopyWith<$Res>
    implements $MissionModelCopyWith<$Res> {
  factory _$MissionModelCopyWith(
          _MissionModel value, $Res Function(_MissionModel) then) =
      __$MissionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(required: true) int id,
      String title,
      num member,
      num required,
      @JsonKey(name: 'prize_type') String prizeType,
      int prize,
      @JsonKey(name: 'prize_amount') num prizeAmount,
      int type,
      int sort,
      String url,
      String tab,
      String info,
      String auto,
      String complete});
}

/// @nodoc
class __$MissionModelCopyWithImpl<$Res> extends _$MissionModelCopyWithImpl<$Res>
    implements _$MissionModelCopyWith<$Res> {
  __$MissionModelCopyWithImpl(
      _MissionModel _value, $Res Function(_MissionModel) _then)
      : super(_value, (v) => _then(v as _MissionModel));

  @override
  _MissionModel get _value => super._value as _MissionModel;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object member = freezed,
    Object required = freezed,
    Object prizeType = freezed,
    Object prize = freezed,
    Object prizeAmount = freezed,
    Object type = freezed,
    Object sort = freezed,
    Object url = freezed,
    Object tab = freezed,
    Object info = freezed,
    Object auto = freezed,
    Object complete = freezed,
  }) {
    return _then(_MissionModel(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
      member: member == freezed ? _value.member : member as num,
      required: required == freezed ? _value.required : required as num,
      prizeType: prizeType == freezed ? _value.prizeType : prizeType as String,
      prize: prize == freezed ? _value.prize : prize as int,
      prizeAmount:
          prizeAmount == freezed ? _value.prizeAmount : prizeAmount as num,
      type: type == freezed ? _value.type : type as int,
      sort: sort == freezed ? _value.sort : sort as int,
      url: url == freezed ? _value.url : url as String,
      tab: tab == freezed ? _value.tab : tab as String,
      info: info == freezed ? _value.info : info as String,
      auto: auto == freezed ? _value.auto : auto as String,
      complete: complete == freezed ? _value.complete : complete as String,
    ));
  }
}

/// @nodoc
class _$_MissionModel implements _MissionModel {
  const _$_MissionModel(
      {@JsonKey(required: true) this.id,
      this.title,
      this.member,
      this.required,
      @JsonKey(name: 'prize_type') this.prizeType,
      this.prize,
      @JsonKey(name: 'prize_amount') this.prizeAmount,
      this.type,
      this.sort,
      this.url,
      this.tab,
      this.info,
      this.auto,
      this.complete});

  @override
  @JsonKey(required: true)
  final int id;
  @override // mission title
  final String title;
  @override // member complete count
  final num member;
  @override // required complete count
  final num required;
  @override // 0 = bonus credit; 1 = store point
  @JsonKey(name: 'prize_type')
  final String prizeType;
  @override //
  final int prize;
  @override // prize amount on mission complete
  @JsonKey(name: 'prize_amount')
  final num prizeAmount;
  @override // 1 = deposit; 2 = rollback; 3 = complete count; 4 = bind
  final int type;
  @override // mission list order
  final int sort;
  @override // mission navigate url
  final String url;
  @override // 0 = show dialog; 1 = navigate;
  final String tab;
  @override // mission detail
  final String info;
  @override // 0 = auto; 1 = manual
  final String auto;
  @override // 0 = complete; 1 = not complete; 3 = received
  final String complete;

  @override
  String toString() {
    return 'MissionModel(id: $id, title: $title, member: $member, required: $required, prizeType: $prizeType, prize: $prize, prizeAmount: $prizeAmount, type: $type, sort: $sort, url: $url, tab: $tab, info: $info, auto: $auto, complete: $complete)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MissionModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.member, member) ||
                const DeepCollectionEquality().equals(other.member, member)) &&
            (identical(other.required, required) ||
                const DeepCollectionEquality()
                    .equals(other.required, required)) &&
            (identical(other.prizeType, prizeType) ||
                const DeepCollectionEquality()
                    .equals(other.prizeType, prizeType)) &&
            (identical(other.prize, prize) ||
                const DeepCollectionEquality().equals(other.prize, prize)) &&
            (identical(other.prizeAmount, prizeAmount) ||
                const DeepCollectionEquality()
                    .equals(other.prizeAmount, prizeAmount)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.sort, sort) ||
                const DeepCollectionEquality().equals(other.sort, sort)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.tab, tab) ||
                const DeepCollectionEquality().equals(other.tab, tab)) &&
            (identical(other.info, info) ||
                const DeepCollectionEquality().equals(other.info, info)) &&
            (identical(other.auto, auto) ||
                const DeepCollectionEquality().equals(other.auto, auto)) &&
            (identical(other.complete, complete) ||
                const DeepCollectionEquality()
                    .equals(other.complete, complete)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(member) ^
      const DeepCollectionEquality().hash(required) ^
      const DeepCollectionEquality().hash(prizeType) ^
      const DeepCollectionEquality().hash(prize) ^
      const DeepCollectionEquality().hash(prizeAmount) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(sort) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(tab) ^
      const DeepCollectionEquality().hash(info) ^
      const DeepCollectionEquality().hash(auto) ^
      const DeepCollectionEquality().hash(complete);

  @JsonKey(ignore: true)
  @override
  _$MissionModelCopyWith<_MissionModel> get copyWith =>
      __$MissionModelCopyWithImpl<_MissionModel>(this, _$identity);
}

abstract class _MissionModel implements MissionModel {
  const factory _MissionModel(
      {@JsonKey(required: true) int id,
      String title,
      num member,
      num required,
      @JsonKey(name: 'prize_type') String prizeType,
      int prize,
      @JsonKey(name: 'prize_amount') num prizeAmount,
      int type,
      int sort,
      String url,
      String tab,
      String info,
      String auto,
      String complete}) = _$_MissionModel;

  @override
  @JsonKey(required: true)
  int get id;
  @override // mission title
  String get title;
  @override // member complete count
  num get member;
  @override // required complete count
  num get required;
  @override // 0 = bonus credit; 1 = store point
  @JsonKey(name: 'prize_type')
  String get prizeType;
  @override //
  int get prize;
  @override // prize amount on mission complete
  @JsonKey(name: 'prize_amount')
  num get prizeAmount;
  @override // 1 = deposit; 2 = rollback; 3 = complete count; 4 = bind
  int get type;
  @override // mission list order
  int get sort;
  @override // mission navigate url
  String get url;
  @override // 0 = show dialog; 1 = navigate;
  String get tab;
  @override // mission detail
  String get info;
  @override // 0 = auto; 1 = manual
  String get auto;
  @override // 0 = complete; 1 = not complete; 3 = received
  String get complete;
  @override
  @JsonKey(ignore: true)
  _$MissionModelCopyWith<_MissionModel> get copyWith;
}
