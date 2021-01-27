// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'agent_report_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AgentReportFormTearOff {
  const _$AgentReportFormTearOff();

// ignore: unused_element
  _AgentReportForm call(
      {@required AgentChartType type,
      @required String startTime,
      @required String endTime}) {
    return _AgentReportForm(
      type: type,
      startTime: startTime,
      endTime: endTime,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AgentReportForm = _$AgentReportFormTearOff();

/// @nodoc
mixin _$AgentReportForm {
  AgentChartType get type;
  String get startTime;
  String get endTime;

  $AgentReportFormCopyWith<AgentReportForm> get copyWith;
}

/// @nodoc
abstract class $AgentReportFormCopyWith<$Res> {
  factory $AgentReportFormCopyWith(
          AgentReportForm value, $Res Function(AgentReportForm) then) =
      _$AgentReportFormCopyWithImpl<$Res>;
  $Res call({AgentChartType type, String startTime, String endTime});
}

/// @nodoc
class _$AgentReportFormCopyWithImpl<$Res>
    implements $AgentReportFormCopyWith<$Res> {
  _$AgentReportFormCopyWithImpl(this._value, this._then);

  final AgentReportForm _value;
  // ignore: unused_field
  final $Res Function(AgentReportForm) _then;

  @override
  $Res call({
    Object type = freezed,
    Object startTime = freezed,
    Object endTime = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as AgentChartType,
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      endTime: endTime == freezed ? _value.endTime : endTime as String,
    ));
  }
}

/// @nodoc
abstract class _$AgentReportFormCopyWith<$Res>
    implements $AgentReportFormCopyWith<$Res> {
  factory _$AgentReportFormCopyWith(
          _AgentReportForm value, $Res Function(_AgentReportForm) then) =
      __$AgentReportFormCopyWithImpl<$Res>;
  @override
  $Res call({AgentChartType type, String startTime, String endTime});
}

/// @nodoc
class __$AgentReportFormCopyWithImpl<$Res>
    extends _$AgentReportFormCopyWithImpl<$Res>
    implements _$AgentReportFormCopyWith<$Res> {
  __$AgentReportFormCopyWithImpl(
      _AgentReportForm _value, $Res Function(_AgentReportForm) _then)
      : super(_value, (v) => _then(v as _AgentReportForm));

  @override
  _AgentReportForm get _value => super._value as _AgentReportForm;

  @override
  $Res call({
    Object type = freezed,
    Object startTime = freezed,
    Object endTime = freezed,
  }) {
    return _then(_AgentReportForm(
      type: type == freezed ? _value.type : type as AgentChartType,
      startTime: startTime == freezed ? _value.startTime : startTime as String,
      endTime: endTime == freezed ? _value.endTime : endTime as String,
    ));
  }
}

/// @nodoc
class _$_AgentReportForm implements _AgentReportForm {
  const _$_AgentReportForm(
      {@required this.type, @required this.startTime, @required this.endTime})
      : assert(type != null),
        assert(startTime != null),
        assert(endTime != null);

  @override
  final AgentChartType type;
  @override
  final String startTime;
  @override
  final String endTime;

  @override
  String toString() {
    return 'AgentReportForm(type: $type, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AgentReportForm &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.startTime, startTime) ||
                const DeepCollectionEquality()
                    .equals(other.startTime, startTime)) &&
            (identical(other.endTime, endTime) ||
                const DeepCollectionEquality().equals(other.endTime, endTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(startTime) ^
      const DeepCollectionEquality().hash(endTime);

  @override
  _$AgentReportFormCopyWith<_AgentReportForm> get copyWith =>
      __$AgentReportFormCopyWithImpl<_AgentReportForm>(this, _$identity);
}

abstract class _AgentReportForm implements AgentReportForm {
  const factory _AgentReportForm(
      {@required AgentChartType type,
      @required String startTime,
      @required String endTime}) = _$_AgentReportForm;

  @override
  AgentChartType get type;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  _$AgentReportFormCopyWith<_AgentReportForm> get copyWith;
}
