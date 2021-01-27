// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'deposit_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
DepositMethod _$DepositMethodFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'online':
      return DepositMethodOnline.fromJson(json);
    case 'virtual':
      return DepositMethodVirtualData.fromJson(json);
    case 'local':
      return DepositMethodLocal.fromJson(json);
    case 'bank':
      return DepositMethodBankData.fromJson(json);

    default:
      throw FallThroughError();
  }
}

/// @nodoc
class _$DepositMethodTearOff {
  const _$DepositMethodTearOff();

// ignore: unused_element
  DepositMethodOnline online(
      {List<DepositMethodVirtualData> options = const [], dynamic key = '1'}) {
    return DepositMethodOnline(
      options: options,
      key: key,
    );
  }

// ignore: unused_element
  DepositMethodVirtualData virtual(
      {String amount,
      @JsonKey(name: 'amountoption') List<String> amountOption,
      @JsonKey(name: 'amounttype') int amountType,
      @JsonKey(name: 'bankaccountid') int bankAccountId,
      int gateway,
      int max,
      int min,
      int payment,
      @JsonKey(name: 'pgindex') int pgIndex,
      @required List<int> sb,
      String type,
      dynamic key}) {
    return DepositMethodVirtualData(
      amount: amount,
      amountOption: amountOption,
      amountType: amountType,
      bankAccountId: bankAccountId,
      gateway: gateway,
      max: max,
      min: min,
      payment: payment,
      pgIndex: pgIndex,
      sb: sb,
      type: type,
      key: key,
    );
  }

// ignore: unused_element
  DepositMethodLocal local(
      {List<DepositMethodBankData> banks = const [], dynamic key = '1'}) {
    return DepositMethodLocal(
      banks: banks,
      key: key,
    );
  }

// ignore: unused_element
  DepositMethodBankData bank(
      {@JsonKey(name: 'bankaccountid') int bankAccountId,
      @JsonKey(name: 'bankaccountno') String bankAccountNo,
      @JsonKey(name: 'bankindex') int bankIndex,
      @JsonKey(fromJson: JsonUtil.getRawJson) String max,
      @JsonKey(fromJson: JsonUtil.getRawJson) String min,
      String payment,
      String type,
      dynamic key}) {
    return DepositMethodBankData(
      bankAccountId: bankAccountId,
      bankAccountNo: bankAccountNo,
      bankIndex: bankIndex,
      max: max,
      min: min,
      payment: payment,
      type: type,
      key: key,
    );
  }

// ignore: unused_element
  DepositMethod fromJson(Map<String, Object> json) {
    return DepositMethod.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $DepositMethod = _$DepositMethodTearOff();

/// @nodoc
mixin _$DepositMethod {
  dynamic get key;

  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult online(List<DepositMethodVirtualData> options, dynamic key),
    @required
        TResult virtual(
            String amount,
            @JsonKey(name: 'amountoption') List<String> amountOption,
            @JsonKey(name: 'amounttype') int amountType,
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            int gateway,
            int max,
            int min,
            int payment,
            @JsonKey(name: 'pgindex') int pgIndex,
            List<int> sb,
            String type,
            dynamic key),
    @required TResult local(List<DepositMethodBankData> banks, dynamic key),
    @required
        TResult bank(
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            @JsonKey(name: 'bankaccountno') String bankAccountNo,
            @JsonKey(name: 'bankindex') int bankIndex,
            @JsonKey(fromJson: JsonUtil.getRawJson) String max,
            @JsonKey(fromJson: JsonUtil.getRawJson) String min,
            String payment,
            String type,
            dynamic key),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult online(List<DepositMethodVirtualData> options, dynamic key),
    TResult virtual(
        String amount,
        @JsonKey(name: 'amountoption') List<String> amountOption,
        @JsonKey(name: 'amounttype') int amountType,
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        int gateway,
        int max,
        int min,
        int payment,
        @JsonKey(name: 'pgindex') int pgIndex,
        List<int> sb,
        String type,
        dynamic key),
    TResult local(List<DepositMethodBankData> banks, dynamic key),
    TResult bank(
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        @JsonKey(name: 'bankaccountno') String bankAccountNo,
        @JsonKey(name: 'bankindex') int bankIndex,
        @JsonKey(fromJson: JsonUtil.getRawJson) String max,
        @JsonKey(fromJson: JsonUtil.getRawJson) String min,
        String payment,
        String type,
        dynamic key),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult online(DepositMethodOnline value),
    @required TResult virtual(DepositMethodVirtualData value),
    @required TResult local(DepositMethodLocal value),
    @required TResult bank(DepositMethodBankData value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult online(DepositMethodOnline value),
    TResult virtual(DepositMethodVirtualData value),
    TResult local(DepositMethodLocal value),
    TResult bank(DepositMethodBankData value),
    @required TResult orElse(),
  });
  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $DepositMethodCopyWith<DepositMethod> get copyWith;
}

/// @nodoc
abstract class $DepositMethodCopyWith<$Res> {
  factory $DepositMethodCopyWith(
          DepositMethod value, $Res Function(DepositMethod) then) =
      _$DepositMethodCopyWithImpl<$Res>;
  $Res call({dynamic key});
}

/// @nodoc
class _$DepositMethodCopyWithImpl<$Res>
    implements $DepositMethodCopyWith<$Res> {
  _$DepositMethodCopyWithImpl(this._value, this._then);

  final DepositMethod _value;
  // ignore: unused_field
  final $Res Function(DepositMethod) _then;

  @override
  $Res call({
    Object key = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

/// @nodoc
abstract class $DepositMethodOnlineCopyWith<$Res>
    implements $DepositMethodCopyWith<$Res> {
  factory $DepositMethodOnlineCopyWith(
          DepositMethodOnline value, $Res Function(DepositMethodOnline) then) =
      _$DepositMethodOnlineCopyWithImpl<$Res>;
  @override
  $Res call({List<DepositMethodVirtualData> options, dynamic key});
}

/// @nodoc
class _$DepositMethodOnlineCopyWithImpl<$Res>
    extends _$DepositMethodCopyWithImpl<$Res>
    implements $DepositMethodOnlineCopyWith<$Res> {
  _$DepositMethodOnlineCopyWithImpl(
      DepositMethodOnline _value, $Res Function(DepositMethodOnline) _then)
      : super(_value, (v) => _then(v as DepositMethodOnline));

  @override
  DepositMethodOnline get _value => super._value as DepositMethodOnline;

  @override
  $Res call({
    Object options = freezed,
    Object key = freezed,
  }) {
    return _then(DepositMethodOnline(
      options: options == freezed
          ? _value.options
          : options as List<DepositMethodVirtualData>,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$DepositMethodOnline implements DepositMethodOnline {
  const _$DepositMethodOnline({this.options = const [], this.key = '1'})
      : assert(options != null),
        assert(key != null);

  factory _$DepositMethodOnline.fromJson(Map<String, dynamic> json) =>
      _$_$DepositMethodOnlineFromJson(json);

  @JsonKey(defaultValue: const [])
  @override
  final List<DepositMethodVirtualData> options;
  @JsonKey(defaultValue: '1')
  @override
  final dynamic key;

  @override
  String toString() {
    return 'DepositMethod.online(options: $options, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DepositMethodOnline &&
            (identical(other.options, options) ||
                const DeepCollectionEquality()
                    .equals(other.options, options)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(options) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  $DepositMethodOnlineCopyWith<DepositMethodOnline> get copyWith =>
      _$DepositMethodOnlineCopyWithImpl<DepositMethodOnline>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult online(List<DepositMethodVirtualData> options, dynamic key),
    @required
        TResult virtual(
            String amount,
            @JsonKey(name: 'amountoption') List<String> amountOption,
            @JsonKey(name: 'amounttype') int amountType,
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            int gateway,
            int max,
            int min,
            int payment,
            @JsonKey(name: 'pgindex') int pgIndex,
            List<int> sb,
            String type,
            dynamic key),
    @required TResult local(List<DepositMethodBankData> banks, dynamic key),
    @required
        TResult bank(
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            @JsonKey(name: 'bankaccountno') String bankAccountNo,
            @JsonKey(name: 'bankindex') int bankIndex,
            @JsonKey(fromJson: JsonUtil.getRawJson) String max,
            @JsonKey(fromJson: JsonUtil.getRawJson) String min,
            String payment,
            String type,
            dynamic key),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return online(options, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult online(List<DepositMethodVirtualData> options, dynamic key),
    TResult virtual(
        String amount,
        @JsonKey(name: 'amountoption') List<String> amountOption,
        @JsonKey(name: 'amounttype') int amountType,
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        int gateway,
        int max,
        int min,
        int payment,
        @JsonKey(name: 'pgindex') int pgIndex,
        List<int> sb,
        String type,
        dynamic key),
    TResult local(List<DepositMethodBankData> banks, dynamic key),
    TResult bank(
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        @JsonKey(name: 'bankaccountno') String bankAccountNo,
        @JsonKey(name: 'bankindex') int bankIndex,
        @JsonKey(fromJson: JsonUtil.getRawJson) String max,
        @JsonKey(fromJson: JsonUtil.getRawJson) String min,
        String payment,
        String type,
        dynamic key),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (online != null) {
      return online(options, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult online(DepositMethodOnline value),
    @required TResult virtual(DepositMethodVirtualData value),
    @required TResult local(DepositMethodLocal value),
    @required TResult bank(DepositMethodBankData value),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return online(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult online(DepositMethodOnline value),
    TResult virtual(DepositMethodVirtualData value),
    TResult local(DepositMethodLocal value),
    TResult bank(DepositMethodBankData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (online != null) {
      return online(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DepositMethodOnlineToJson(this)..['runtimeType'] = 'online';
  }
}

abstract class DepositMethodOnline implements DepositMethod {
  const factory DepositMethodOnline(
      {List<DepositMethodVirtualData> options,
      dynamic key}) = _$DepositMethodOnline;

  factory DepositMethodOnline.fromJson(Map<String, dynamic> json) =
      _$DepositMethodOnline.fromJson;

  List<DepositMethodVirtualData> get options;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  $DepositMethodOnlineCopyWith<DepositMethodOnline> get copyWith;
}

/// @nodoc
abstract class $DepositMethodVirtualDataCopyWith<$Res>
    implements $DepositMethodCopyWith<$Res> {
  factory $DepositMethodVirtualDataCopyWith(DepositMethodVirtualData value,
          $Res Function(DepositMethodVirtualData) then) =
      _$DepositMethodVirtualDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String amount,
      @JsonKey(name: 'amountoption') List<String> amountOption,
      @JsonKey(name: 'amounttype') int amountType,
      @JsonKey(name: 'bankaccountid') int bankAccountId,
      int gateway,
      int max,
      int min,
      int payment,
      @JsonKey(name: 'pgindex') int pgIndex,
      List<int> sb,
      String type,
      dynamic key});
}

/// @nodoc
class _$DepositMethodVirtualDataCopyWithImpl<$Res>
    extends _$DepositMethodCopyWithImpl<$Res>
    implements $DepositMethodVirtualDataCopyWith<$Res> {
  _$DepositMethodVirtualDataCopyWithImpl(DepositMethodVirtualData _value,
      $Res Function(DepositMethodVirtualData) _then)
      : super(_value, (v) => _then(v as DepositMethodVirtualData));

  @override
  DepositMethodVirtualData get _value =>
      super._value as DepositMethodVirtualData;

  @override
  $Res call({
    Object amount = freezed,
    Object amountOption = freezed,
    Object amountType = freezed,
    Object bankAccountId = freezed,
    Object gateway = freezed,
    Object max = freezed,
    Object min = freezed,
    Object payment = freezed,
    Object pgIndex = freezed,
    Object sb = freezed,
    Object type = freezed,
    Object key = freezed,
  }) {
    return _then(DepositMethodVirtualData(
      amount: amount == freezed ? _value.amount : amount as String,
      amountOption: amountOption == freezed
          ? _value.amountOption
          : amountOption as List<String>,
      amountType: amountType == freezed ? _value.amountType : amountType as int,
      bankAccountId: bankAccountId == freezed
          ? _value.bankAccountId
          : bankAccountId as int,
      gateway: gateway == freezed ? _value.gateway : gateway as int,
      max: max == freezed ? _value.max : max as int,
      min: min == freezed ? _value.min : min as int,
      payment: payment == freezed ? _value.payment : payment as int,
      pgIndex: pgIndex == freezed ? _value.pgIndex : pgIndex as int,
      sb: sb == freezed ? _value.sb : sb as List<int>,
      type: type == freezed ? _value.type : type as String,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$DepositMethodVirtualData implements DepositMethodVirtualData {
  const _$DepositMethodVirtualData(
      {this.amount,
      @JsonKey(name: 'amountoption') this.amountOption,
      @JsonKey(name: 'amounttype') this.amountType,
      @JsonKey(name: 'bankaccountid') this.bankAccountId,
      this.gateway,
      this.max,
      this.min,
      this.payment,
      @JsonKey(name: 'pgindex') this.pgIndex,
      @required this.sb,
      this.type,
      this.key})
      : assert(sb != null);

  factory _$DepositMethodVirtualData.fromJson(Map<String, dynamic> json) =>
      _$_$DepositMethodVirtualDataFromJson(json);

  @override
  final String amount;
  @override
  @JsonKey(name: 'amountoption')
  final List<String> amountOption;
  @override
  @JsonKey(name: 'amounttype')
  final int amountType;
  @override
  @JsonKey(name: 'bankaccountid')
  final int bankAccountId;
  @override
  final int gateway;
  @override
  final int max;
  @override
  final int min;
  @override
  final int payment;
  @override
  @JsonKey(name: 'pgindex')
  final int pgIndex;
  @override
  final List<int> sb;
  @override
  final String type;
  @override
  final dynamic key;

  @override
  String toString() {
    return 'DepositMethod.virtual(amount: $amount, amountOption: $amountOption, amountType: $amountType, bankAccountId: $bankAccountId, gateway: $gateway, max: $max, min: $min, payment: $payment, pgIndex: $pgIndex, sb: $sb, type: $type, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DepositMethodVirtualData &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.amountOption, amountOption) ||
                const DeepCollectionEquality()
                    .equals(other.amountOption, amountOption)) &&
            (identical(other.amountType, amountType) ||
                const DeepCollectionEquality()
                    .equals(other.amountType, amountType)) &&
            (identical(other.bankAccountId, bankAccountId) ||
                const DeepCollectionEquality()
                    .equals(other.bankAccountId, bankAccountId)) &&
            (identical(other.gateway, gateway) ||
                const DeepCollectionEquality()
                    .equals(other.gateway, gateway)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.payment, payment) ||
                const DeepCollectionEquality()
                    .equals(other.payment, payment)) &&
            (identical(other.pgIndex, pgIndex) ||
                const DeepCollectionEquality()
                    .equals(other.pgIndex, pgIndex)) &&
            (identical(other.sb, sb) ||
                const DeepCollectionEquality().equals(other.sb, sb)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(amountOption) ^
      const DeepCollectionEquality().hash(amountType) ^
      const DeepCollectionEquality().hash(bankAccountId) ^
      const DeepCollectionEquality().hash(gateway) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(payment) ^
      const DeepCollectionEquality().hash(pgIndex) ^
      const DeepCollectionEquality().hash(sb) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  $DepositMethodVirtualDataCopyWith<DepositMethodVirtualData> get copyWith =>
      _$DepositMethodVirtualDataCopyWithImpl<DepositMethodVirtualData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult online(List<DepositMethodVirtualData> options, dynamic key),
    @required
        TResult virtual(
            String amount,
            @JsonKey(name: 'amountoption') List<String> amountOption,
            @JsonKey(name: 'amounttype') int amountType,
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            int gateway,
            int max,
            int min,
            int payment,
            @JsonKey(name: 'pgindex') int pgIndex,
            List<int> sb,
            String type,
            dynamic key),
    @required TResult local(List<DepositMethodBankData> banks, dynamic key),
    @required
        TResult bank(
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            @JsonKey(name: 'bankaccountno') String bankAccountNo,
            @JsonKey(name: 'bankindex') int bankIndex,
            @JsonKey(fromJson: JsonUtil.getRawJson) String max,
            @JsonKey(fromJson: JsonUtil.getRawJson) String min,
            String payment,
            String type,
            dynamic key),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return virtual(amount, amountOption, amountType, bankAccountId, gateway,
        max, min, payment, pgIndex, sb, type, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult online(List<DepositMethodVirtualData> options, dynamic key),
    TResult virtual(
        String amount,
        @JsonKey(name: 'amountoption') List<String> amountOption,
        @JsonKey(name: 'amounttype') int amountType,
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        int gateway,
        int max,
        int min,
        int payment,
        @JsonKey(name: 'pgindex') int pgIndex,
        List<int> sb,
        String type,
        dynamic key),
    TResult local(List<DepositMethodBankData> banks, dynamic key),
    TResult bank(
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        @JsonKey(name: 'bankaccountno') String bankAccountNo,
        @JsonKey(name: 'bankindex') int bankIndex,
        @JsonKey(fromJson: JsonUtil.getRawJson) String max,
        @JsonKey(fromJson: JsonUtil.getRawJson) String min,
        String payment,
        String type,
        dynamic key),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (virtual != null) {
      return virtual(amount, amountOption, amountType, bankAccountId, gateway,
          max, min, payment, pgIndex, sb, type, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult online(DepositMethodOnline value),
    @required TResult virtual(DepositMethodVirtualData value),
    @required TResult local(DepositMethodLocal value),
    @required TResult bank(DepositMethodBankData value),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return virtual(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult online(DepositMethodOnline value),
    TResult virtual(DepositMethodVirtualData value),
    TResult local(DepositMethodLocal value),
    TResult bank(DepositMethodBankData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (virtual != null) {
      return virtual(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DepositMethodVirtualDataToJson(this)
      ..['runtimeType'] = 'virtual';
  }
}

abstract class DepositMethodVirtualData implements DepositMethod {
  const factory DepositMethodVirtualData(
      {String amount,
      @JsonKey(name: 'amountoption') List<String> amountOption,
      @JsonKey(name: 'amounttype') int amountType,
      @JsonKey(name: 'bankaccountid') int bankAccountId,
      int gateway,
      int max,
      int min,
      int payment,
      @JsonKey(name: 'pgindex') int pgIndex,
      @required List<int> sb,
      String type,
      dynamic key}) = _$DepositMethodVirtualData;

  factory DepositMethodVirtualData.fromJson(Map<String, dynamic> json) =
      _$DepositMethodVirtualData.fromJson;

  String get amount;
  @JsonKey(name: 'amountoption')
  List<String> get amountOption;
  @JsonKey(name: 'amounttype')
  int get amountType;
  @JsonKey(name: 'bankaccountid')
  int get bankAccountId;
  int get gateway;
  int get max;
  int get min;
  int get payment;
  @JsonKey(name: 'pgindex')
  int get pgIndex;
  List<int> get sb;
  String get type;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  $DepositMethodVirtualDataCopyWith<DepositMethodVirtualData> get copyWith;
}

/// @nodoc
abstract class $DepositMethodLocalCopyWith<$Res>
    implements $DepositMethodCopyWith<$Res> {
  factory $DepositMethodLocalCopyWith(
          DepositMethodLocal value, $Res Function(DepositMethodLocal) then) =
      _$DepositMethodLocalCopyWithImpl<$Res>;
  @override
  $Res call({List<DepositMethodBankData> banks, dynamic key});
}

/// @nodoc
class _$DepositMethodLocalCopyWithImpl<$Res>
    extends _$DepositMethodCopyWithImpl<$Res>
    implements $DepositMethodLocalCopyWith<$Res> {
  _$DepositMethodLocalCopyWithImpl(
      DepositMethodLocal _value, $Res Function(DepositMethodLocal) _then)
      : super(_value, (v) => _then(v as DepositMethodLocal));

  @override
  DepositMethodLocal get _value => super._value as DepositMethodLocal;

  @override
  $Res call({
    Object banks = freezed,
    Object key = freezed,
  }) {
    return _then(DepositMethodLocal(
      banks: banks == freezed
          ? _value.banks
          : banks as List<DepositMethodBankData>,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$DepositMethodLocal implements DepositMethodLocal {
  const _$DepositMethodLocal({this.banks = const [], this.key = '1'})
      : assert(banks != null),
        assert(key != null);

  factory _$DepositMethodLocal.fromJson(Map<String, dynamic> json) =>
      _$_$DepositMethodLocalFromJson(json);

  @JsonKey(defaultValue: const [])
  @override
  final List<DepositMethodBankData> banks;
  @JsonKey(defaultValue: '1')
  @override
  final dynamic key;

  @override
  String toString() {
    return 'DepositMethod.local(banks: $banks, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DepositMethodLocal &&
            (identical(other.banks, banks) ||
                const DeepCollectionEquality().equals(other.banks, banks)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(banks) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  $DepositMethodLocalCopyWith<DepositMethodLocal> get copyWith =>
      _$DepositMethodLocalCopyWithImpl<DepositMethodLocal>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult online(List<DepositMethodVirtualData> options, dynamic key),
    @required
        TResult virtual(
            String amount,
            @JsonKey(name: 'amountoption') List<String> amountOption,
            @JsonKey(name: 'amounttype') int amountType,
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            int gateway,
            int max,
            int min,
            int payment,
            @JsonKey(name: 'pgindex') int pgIndex,
            List<int> sb,
            String type,
            dynamic key),
    @required TResult local(List<DepositMethodBankData> banks, dynamic key),
    @required
        TResult bank(
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            @JsonKey(name: 'bankaccountno') String bankAccountNo,
            @JsonKey(name: 'bankindex') int bankIndex,
            @JsonKey(fromJson: JsonUtil.getRawJson) String max,
            @JsonKey(fromJson: JsonUtil.getRawJson) String min,
            String payment,
            String type,
            dynamic key),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return local(banks, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult online(List<DepositMethodVirtualData> options, dynamic key),
    TResult virtual(
        String amount,
        @JsonKey(name: 'amountoption') List<String> amountOption,
        @JsonKey(name: 'amounttype') int amountType,
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        int gateway,
        int max,
        int min,
        int payment,
        @JsonKey(name: 'pgindex') int pgIndex,
        List<int> sb,
        String type,
        dynamic key),
    TResult local(List<DepositMethodBankData> banks, dynamic key),
    TResult bank(
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        @JsonKey(name: 'bankaccountno') String bankAccountNo,
        @JsonKey(name: 'bankindex') int bankIndex,
        @JsonKey(fromJson: JsonUtil.getRawJson) String max,
        @JsonKey(fromJson: JsonUtil.getRawJson) String min,
        String payment,
        String type,
        dynamic key),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (local != null) {
      return local(banks, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult online(DepositMethodOnline value),
    @required TResult virtual(DepositMethodVirtualData value),
    @required TResult local(DepositMethodLocal value),
    @required TResult bank(DepositMethodBankData value),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult online(DepositMethodOnline value),
    TResult virtual(DepositMethodVirtualData value),
    TResult local(DepositMethodLocal value),
    TResult bank(DepositMethodBankData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (local != null) {
      return local(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DepositMethodLocalToJson(this)..['runtimeType'] = 'local';
  }
}

abstract class DepositMethodLocal implements DepositMethod {
  const factory DepositMethodLocal(
      {List<DepositMethodBankData> banks, dynamic key}) = _$DepositMethodLocal;

  factory DepositMethodLocal.fromJson(Map<String, dynamic> json) =
      _$DepositMethodLocal.fromJson;

  List<DepositMethodBankData> get banks;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  $DepositMethodLocalCopyWith<DepositMethodLocal> get copyWith;
}

/// @nodoc
abstract class $DepositMethodBankDataCopyWith<$Res>
    implements $DepositMethodCopyWith<$Res> {
  factory $DepositMethodBankDataCopyWith(DepositMethodBankData value,
          $Res Function(DepositMethodBankData) then) =
      _$DepositMethodBankDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'bankaccountid') int bankAccountId,
      @JsonKey(name: 'bankaccountno') String bankAccountNo,
      @JsonKey(name: 'bankindex') int bankIndex,
      @JsonKey(fromJson: JsonUtil.getRawJson) String max,
      @JsonKey(fromJson: JsonUtil.getRawJson) String min,
      String payment,
      String type,
      dynamic key});
}

/// @nodoc
class _$DepositMethodBankDataCopyWithImpl<$Res>
    extends _$DepositMethodCopyWithImpl<$Res>
    implements $DepositMethodBankDataCopyWith<$Res> {
  _$DepositMethodBankDataCopyWithImpl(
      DepositMethodBankData _value, $Res Function(DepositMethodBankData) _then)
      : super(_value, (v) => _then(v as DepositMethodBankData));

  @override
  DepositMethodBankData get _value => super._value as DepositMethodBankData;

  @override
  $Res call({
    Object bankAccountId = freezed,
    Object bankAccountNo = freezed,
    Object bankIndex = freezed,
    Object max = freezed,
    Object min = freezed,
    Object payment = freezed,
    Object type = freezed,
    Object key = freezed,
  }) {
    return _then(DepositMethodBankData(
      bankAccountId: bankAccountId == freezed
          ? _value.bankAccountId
          : bankAccountId as int,
      bankAccountNo: bankAccountNo == freezed
          ? _value.bankAccountNo
          : bankAccountNo as String,
      bankIndex: bankIndex == freezed ? _value.bankIndex : bankIndex as int,
      max: max == freezed ? _value.max : max as String,
      min: min == freezed ? _value.min : min as String,
      payment: payment == freezed ? _value.payment : payment as String,
      type: type == freezed ? _value.type : type as String,
      key: key == freezed ? _value.key : key as dynamic,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$DepositMethodBankData implements DepositMethodBankData {
  const _$DepositMethodBankData(
      {@JsonKey(name: 'bankaccountid') this.bankAccountId,
      @JsonKey(name: 'bankaccountno') this.bankAccountNo,
      @JsonKey(name: 'bankindex') this.bankIndex,
      @JsonKey(fromJson: JsonUtil.getRawJson) this.max,
      @JsonKey(fromJson: JsonUtil.getRawJson) this.min,
      this.payment,
      this.type,
      this.key});

  factory _$DepositMethodBankData.fromJson(Map<String, dynamic> json) =>
      _$_$DepositMethodBankDataFromJson(json);

  @override
  @JsonKey(name: 'bankaccountid')
  final int bankAccountId;
  @override
  @JsonKey(name: 'bankaccountno')
  final String bankAccountNo;
  @override
  @JsonKey(name: 'bankindex')
  final int bankIndex;
  @override
  @JsonKey(fromJson: JsonUtil.getRawJson)
  final String max;
  @override
  @JsonKey(fromJson: JsonUtil.getRawJson)
  final String min;
  @override
  final String payment;
  @override
  final String type;
  @override
  final dynamic key;

  @override
  String toString() {
    return 'DepositMethod.bank(bankAccountId: $bankAccountId, bankAccountNo: $bankAccountNo, bankIndex: $bankIndex, max: $max, min: $min, payment: $payment, type: $type, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DepositMethodBankData &&
            (identical(other.bankAccountId, bankAccountId) ||
                const DeepCollectionEquality()
                    .equals(other.bankAccountId, bankAccountId)) &&
            (identical(other.bankAccountNo, bankAccountNo) ||
                const DeepCollectionEquality()
                    .equals(other.bankAccountNo, bankAccountNo)) &&
            (identical(other.bankIndex, bankIndex) ||
                const DeepCollectionEquality()
                    .equals(other.bankIndex, bankIndex)) &&
            (identical(other.max, max) ||
                const DeepCollectionEquality().equals(other.max, max)) &&
            (identical(other.min, min) ||
                const DeepCollectionEquality().equals(other.min, min)) &&
            (identical(other.payment, payment) ||
                const DeepCollectionEquality()
                    .equals(other.payment, payment)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(bankAccountId) ^
      const DeepCollectionEquality().hash(bankAccountNo) ^
      const DeepCollectionEquality().hash(bankIndex) ^
      const DeepCollectionEquality().hash(max) ^
      const DeepCollectionEquality().hash(min) ^
      const DeepCollectionEquality().hash(payment) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(key);

  @JsonKey(ignore: true)
  @override
  $DepositMethodBankDataCopyWith<DepositMethodBankData> get copyWith =>
      _$DepositMethodBankDataCopyWithImpl<DepositMethodBankData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required
        TResult online(List<DepositMethodVirtualData> options, dynamic key),
    @required
        TResult virtual(
            String amount,
            @JsonKey(name: 'amountoption') List<String> amountOption,
            @JsonKey(name: 'amounttype') int amountType,
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            int gateway,
            int max,
            int min,
            int payment,
            @JsonKey(name: 'pgindex') int pgIndex,
            List<int> sb,
            String type,
            dynamic key),
    @required TResult local(List<DepositMethodBankData> banks, dynamic key),
    @required
        TResult bank(
            @JsonKey(name: 'bankaccountid') int bankAccountId,
            @JsonKey(name: 'bankaccountno') String bankAccountNo,
            @JsonKey(name: 'bankindex') int bankIndex,
            @JsonKey(fromJson: JsonUtil.getRawJson) String max,
            @JsonKey(fromJson: JsonUtil.getRawJson) String min,
            String payment,
            String type,
            dynamic key),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return bank(
        bankAccountId, bankAccountNo, bankIndex, max, min, payment, type, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult online(List<DepositMethodVirtualData> options, dynamic key),
    TResult virtual(
        String amount,
        @JsonKey(name: 'amountoption') List<String> amountOption,
        @JsonKey(name: 'amounttype') int amountType,
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        int gateway,
        int max,
        int min,
        int payment,
        @JsonKey(name: 'pgindex') int pgIndex,
        List<int> sb,
        String type,
        dynamic key),
    TResult local(List<DepositMethodBankData> banks, dynamic key),
    TResult bank(
        @JsonKey(name: 'bankaccountid') int bankAccountId,
        @JsonKey(name: 'bankaccountno') String bankAccountNo,
        @JsonKey(name: 'bankindex') int bankIndex,
        @JsonKey(fromJson: JsonUtil.getRawJson) String max,
        @JsonKey(fromJson: JsonUtil.getRawJson) String min,
        String payment,
        String type,
        dynamic key),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (bank != null) {
      return bank(bankAccountId, bankAccountNo, bankIndex, max, min, payment,
          type, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult online(DepositMethodOnline value),
    @required TResult virtual(DepositMethodVirtualData value),
    @required TResult local(DepositMethodLocal value),
    @required TResult bank(DepositMethodBankData value),
  }) {
    assert(online != null);
    assert(virtual != null);
    assert(local != null);
    assert(bank != null);
    return bank(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult online(DepositMethodOnline value),
    TResult virtual(DepositMethodVirtualData value),
    TResult local(DepositMethodLocal value),
    TResult bank(DepositMethodBankData value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (bank != null) {
      return bank(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$DepositMethodBankDataToJson(this)..['runtimeType'] = 'bank';
  }
}

abstract class DepositMethodBankData implements DepositMethod {
  const factory DepositMethodBankData(
      {@JsonKey(name: 'bankaccountid') int bankAccountId,
      @JsonKey(name: 'bankaccountno') String bankAccountNo,
      @JsonKey(name: 'bankindex') int bankIndex,
      @JsonKey(fromJson: JsonUtil.getRawJson) String max,
      @JsonKey(fromJson: JsonUtil.getRawJson) String min,
      String payment,
      String type,
      dynamic key}) = _$DepositMethodBankData;

  factory DepositMethodBankData.fromJson(Map<String, dynamic> json) =
      _$DepositMethodBankData.fromJson;

  @JsonKey(name: 'bankaccountid')
  int get bankAccountId;
  @JsonKey(name: 'bankaccountno')
  String get bankAccountNo;
  @JsonKey(name: 'bankindex')
  int get bankIndex;
  @JsonKey(fromJson: JsonUtil.getRawJson)
  String get max;
  @JsonKey(fromJson: JsonUtil.getRawJson)
  String get min;
  String get payment;
  String get type;
  @override
  dynamic get key;
  @override
  @JsonKey(ignore: true)
  $DepositMethodBankDataCopyWith<DepositMethodBankData> get copyWith;
}
