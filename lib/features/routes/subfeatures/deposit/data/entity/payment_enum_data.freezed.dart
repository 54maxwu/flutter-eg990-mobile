// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'payment_enum_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PaymentTutorialItemTearOff {
  const _$PaymentTutorialItemTearOff();

// ignore: unused_element
  _PaymentTutorialItem call(
      {@required int sortId,
      @required String value,
      String link,
      @required TutorialItemType type}) {
    return _PaymentTutorialItem(
      sortId: sortId,
      value: value,
      link: link,
      type: type,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PaymentTutorialItem = _$PaymentTutorialItemTearOff();

/// @nodoc
mixin _$PaymentTutorialItem {
  int get sortId;
  String get value;
  String get link;
  TutorialItemType get type;

  @JsonKey(ignore: true)
  $PaymentTutorialItemCopyWith<PaymentTutorialItem> get copyWith;
}

/// @nodoc
abstract class $PaymentTutorialItemCopyWith<$Res> {
  factory $PaymentTutorialItemCopyWith(
          PaymentTutorialItem value, $Res Function(PaymentTutorialItem) then) =
      _$PaymentTutorialItemCopyWithImpl<$Res>;
  $Res call({int sortId, String value, String link, TutorialItemType type});
}

/// @nodoc
class _$PaymentTutorialItemCopyWithImpl<$Res>
    implements $PaymentTutorialItemCopyWith<$Res> {
  _$PaymentTutorialItemCopyWithImpl(this._value, this._then);

  final PaymentTutorialItem _value;
  // ignore: unused_field
  final $Res Function(PaymentTutorialItem) _then;

  @override
  $Res call({
    Object sortId = freezed,
    Object value = freezed,
    Object link = freezed,
    Object type = freezed,
  }) {
    return _then(_value.copyWith(
      sortId: sortId == freezed ? _value.sortId : sortId as int,
      value: value == freezed ? _value.value : value as String,
      link: link == freezed ? _value.link : link as String,
      type: type == freezed ? _value.type : type as TutorialItemType,
    ));
  }
}

/// @nodoc
abstract class _$PaymentTutorialItemCopyWith<$Res>
    implements $PaymentTutorialItemCopyWith<$Res> {
  factory _$PaymentTutorialItemCopyWith(_PaymentTutorialItem value,
          $Res Function(_PaymentTutorialItem) then) =
      __$PaymentTutorialItemCopyWithImpl<$Res>;
  @override
  $Res call({int sortId, String value, String link, TutorialItemType type});
}

/// @nodoc
class __$PaymentTutorialItemCopyWithImpl<$Res>
    extends _$PaymentTutorialItemCopyWithImpl<$Res>
    implements _$PaymentTutorialItemCopyWith<$Res> {
  __$PaymentTutorialItemCopyWithImpl(
      _PaymentTutorialItem _value, $Res Function(_PaymentTutorialItem) _then)
      : super(_value, (v) => _then(v as _PaymentTutorialItem));

  @override
  _PaymentTutorialItem get _value => super._value as _PaymentTutorialItem;

  @override
  $Res call({
    Object sortId = freezed,
    Object value = freezed,
    Object link = freezed,
    Object type = freezed,
  }) {
    return _then(_PaymentTutorialItem(
      sortId: sortId == freezed ? _value.sortId : sortId as int,
      value: value == freezed ? _value.value : value as String,
      link: link == freezed ? _value.link : link as String,
      type: type == freezed ? _value.type : type as TutorialItemType,
    ));
  }
}

/// @nodoc
class _$_PaymentTutorialItem implements _PaymentTutorialItem {
  const _$_PaymentTutorialItem(
      {@required this.sortId,
      @required this.value,
      this.link,
      @required this.type})
      : assert(sortId != null),
        assert(value != null),
        assert(type != null);

  @override
  final int sortId;
  @override
  final String value;
  @override
  final String link;
  @override
  final TutorialItemType type;

  @override
  String toString() {
    return 'PaymentTutorialItem(sortId: $sortId, value: $value, link: $link, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PaymentTutorialItem &&
            (identical(other.sortId, sortId) ||
                const DeepCollectionEquality().equals(other.sortId, sortId)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sortId) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(type);

  @JsonKey(ignore: true)
  @override
  _$PaymentTutorialItemCopyWith<_PaymentTutorialItem> get copyWith =>
      __$PaymentTutorialItemCopyWithImpl<_PaymentTutorialItem>(
          this, _$identity);
}

abstract class _PaymentTutorialItem implements PaymentTutorialItem {
  const factory _PaymentTutorialItem(
      {@required int sortId,
      @required String value,
      String link,
      @required TutorialItemType type}) = _$_PaymentTutorialItem;

  @override
  int get sortId;
  @override
  String get value;
  @override
  String get link;
  @override
  TutorialItemType get type;
  @override
  @JsonKey(ignore: true)
  _$PaymentTutorialItemCopyWith<_PaymentTutorialItem> get copyWith;
}
