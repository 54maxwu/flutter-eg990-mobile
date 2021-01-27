// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'member_vip_settings_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$MemberVipSettingsListTearOff {
  const _$MemberVipSettingsListTearOff();

// ignore: unused_element
  _MemberVipSettingsList call(
      {@JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
          MemberVipSettings item,
      String title}) {
    return _MemberVipSettingsList(
      item: item,
      title: title,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $MemberVipSettingsList = _$MemberVipSettingsListTearOff();

/// @nodoc
mixin _$MemberVipSettingsList {
  @JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
  MemberVipSettings get item;
  String get title;

  @JsonKey(ignore: true)
  $MemberVipSettingsListCopyWith<MemberVipSettingsList> get copyWith;
}

/// @nodoc
abstract class $MemberVipSettingsListCopyWith<$Res> {
  factory $MemberVipSettingsListCopyWith(MemberVipSettingsList value,
          $Res Function(MemberVipSettingsList) then) =
      _$MemberVipSettingsListCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
          MemberVipSettings item,
      String title});

  $MemberVipSettingsCopyWith<$Res> get item;
}

/// @nodoc
class _$MemberVipSettingsListCopyWithImpl<$Res>
    implements $MemberVipSettingsListCopyWith<$Res> {
  _$MemberVipSettingsListCopyWithImpl(this._value, this._then);

  final MemberVipSettingsList _value;
  // ignore: unused_field
  final $Res Function(MemberVipSettingsList) _then;

  @override
  $Res call({
    Object item = freezed,
    Object title = freezed,
  }) {
    return _then(_value.copyWith(
      item: item == freezed ? _value.item : item as MemberVipSettings,
      title: title == freezed ? _value.title : title as String,
    ));
  }

  @override
  $MemberVipSettingsCopyWith<$Res> get item {
    if (_value.item == null) {
      return null;
    }
    return $MemberVipSettingsCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc
abstract class _$MemberVipSettingsListCopyWith<$Res>
    implements $MemberVipSettingsListCopyWith<$Res> {
  factory _$MemberVipSettingsListCopyWith(_MemberVipSettingsList value,
          $Res Function(_MemberVipSettingsList) then) =
      __$MemberVipSettingsListCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
          MemberVipSettings item,
      String title});

  @override
  $MemberVipSettingsCopyWith<$Res> get item;
}

/// @nodoc
class __$MemberVipSettingsListCopyWithImpl<$Res>
    extends _$MemberVipSettingsListCopyWithImpl<$Res>
    implements _$MemberVipSettingsListCopyWith<$Res> {
  __$MemberVipSettingsListCopyWithImpl(_MemberVipSettingsList _value,
      $Res Function(_MemberVipSettingsList) _then)
      : super(_value, (v) => _then(v as _MemberVipSettingsList));

  @override
  _MemberVipSettingsList get _value => super._value as _MemberVipSettingsList;

  @override
  $Res call({
    Object item = freezed,
    Object title = freezed,
  }) {
    return _then(_MemberVipSettingsList(
      item: item == freezed ? _value.item : item as MemberVipSettings,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
class _$_MemberVipSettingsList implements _MemberVipSettingsList {
  const _$_MemberVipSettingsList(
      {@JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
          this.item,
      this.title});

  @override
  @JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
  final MemberVipSettings item;
  @override
  final String title;

  @override
  String toString() {
    return 'MemberVipSettingsList(item: $item, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MemberVipSettingsList &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(item) ^
      const DeepCollectionEquality().hash(title);

  @JsonKey(ignore: true)
  @override
  _$MemberVipSettingsListCopyWith<_MemberVipSettingsList> get copyWith =>
      __$MemberVipSettingsListCopyWithImpl<_MemberVipSettingsList>(
          this, _$identity);
}

abstract class _MemberVipSettingsList implements MemberVipSettingsList {
  const factory _MemberVipSettingsList(
      {@JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
          MemberVipSettings item,
      String title}) = _$_MemberVipSettingsList;

  @override
  @JsonKey(name: 'setting', fromJson: MemberVipSettings.parseJson)
  MemberVipSettings get item;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$MemberVipSettingsListCopyWith<_MemberVipSettingsList> get copyWith;
}
