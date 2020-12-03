// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_data.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$BalanceData {
  const _$BalanceData();

  String get platform;
  String get amount;
  String get error;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! BalanceData) return false;
    return true &&
        this.platform == other.platform &&
        this.amount == other.amount &&
        this.error == other.error;
  }

  int get hashCode {
    return mapPropsToHashCode([platform, amount, error]);
  }

  String toString() {
    return 'BalanceData <\'platform\': ${this.platform},\'amount\': ${this.amount},\'error\': ${this.error},>';
  }

  BalanceData copyWith({String platform, String amount, String error}) {
    return BalanceData(
      platform: platform ?? this.platform,
      amount: amount ?? this.amount,
      error: error ?? this.error,
    );
  }
}
