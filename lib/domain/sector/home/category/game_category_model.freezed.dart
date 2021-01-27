// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'game_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GameCategoryModelTearOff {
  const _$GameCategoryModelTearOff();

// ignore: unused_element
  _GameCategoryModel call({@required String ch, @required String type}) {
    return _GameCategoryModel(
      ch: ch,
      type: type,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GameCategoryModel = _$GameCategoryModelTearOff();

/// @nodoc
mixin _$GameCategoryModel {
  String get ch;
  String get type;

  @JsonKey(ignore: true)
  $GameCategoryModelCopyWith<GameCategoryModel> get copyWith;
}

/// @nodoc
abstract class $GameCategoryModelCopyWith<$Res> {
  factory $GameCategoryModelCopyWith(
          GameCategoryModel value, $Res Function(GameCategoryModel) then) =
      _$GameCategoryModelCopyWithImpl<$Res>;
  $Res call({String ch, String type});
}

/// @nodoc
class _$GameCategoryModelCopyWithImpl<$Res>
    implements $GameCategoryModelCopyWith<$Res> {
  _$GameCategoryModelCopyWithImpl(this._value, this._then);

  final GameCategoryModel _value;
  // ignore: unused_field
  final $Res Function(GameCategoryModel) _then;

  @override
  $Res call({
    Object ch = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      ch: ch == freezed ? _value.ch : ch as String,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

/// @nodoc
abstract class _$GameCategoryModelCopyWith<$Res>
    implements $GameCategoryModelCopyWith<$Res> {
  factory _$GameCategoryModelCopyWith(
          _GameCategoryModel value, $Res Function(_GameCategoryModel) then) =
      __$GameCategoryModelCopyWithImpl<$Res>;
  @override
  $Res call({String ch, String type});
}

/// @nodoc
class __$GameCategoryModelCopyWithImpl<$Res>
    extends _$GameCategoryModelCopyWithImpl<$Res>
    implements _$GameCategoryModelCopyWith<$Res> {
  __$GameCategoryModelCopyWithImpl(
      _GameCategoryModel _value, $Res Function(_GameCategoryModel) _then)
      : super(_value, (v) => _then(v as _GameCategoryModel));

  @override
  _GameCategoryModel get _value => super._value as _GameCategoryModel;

  @override
  $Res call({
    Object ch = freezed,
    Object type = freezed,
  }) {
    return _then(_GameCategoryModel(
      ch: ch == freezed ? _value.ch : ch as String,
      type: type == freezed ? _value.type : type as String,
    ));
  }
}

/// @nodoc
class _$_GameCategoryModel extends _GameCategoryModel {
  const _$_GameCategoryModel({@required this.ch, @required this.type})
      : assert(ch != null),
        assert(type != null),
        super._();

  @override
  final String ch;
  @override
  final String type;

  @override
  String toString() {
    return 'GameCategoryModel(ch: $ch, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GameCategoryModel &&
            (identical(other.ch, ch) ||
                const DeepCollectionEquality().equals(other.ch, ch)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(ch) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  _$GameCategoryModelCopyWith<_GameCategoryModel> get copyWith =>
      __$GameCategoryModelCopyWithImpl<_GameCategoryModel>(this, _$identity);
}

abstract class _GameCategoryModel extends GameCategoryModel {
  const _GameCategoryModel._() : super._();
  const factory _GameCategoryModel(
      {@required String ch, @required String type}) = _$_GameCategoryModel;

  @override
  String get ch;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$GameCategoryModelCopyWith<_GameCategoryModel> get copyWith;
}
