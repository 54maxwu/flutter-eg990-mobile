// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankcard.dart';

// **************************************************************************
// DataClassGenerator
// **************************************************************************

abstract class _$Bankcard {
  const _$Bankcard();

  bool get hasCard;
  String get bankName;
  String get bankAccount;
  String get accountName;
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! Bankcard) return false;
    return true &&
        this.hasCard == other.hasCard &&
        this.bankName == other.bankName &&
        this.bankAccount == other.bankAccount &&
        this.accountName == other.accountName;
  }

  int get hashCode {
    return mapPropsToHashCode([hasCard, bankName, bankAccount, accountName]);
  }

  String toString() {
    return 'Bankcard <\'hasCard\': ${this.hasCard},\'bankName\': ${this.bankName},\'bankAccount\': ${this.bankAccount},\'accountName\': ${this.accountName},>';
  }

  Bankcard copyWith(
      {bool hasCard, String bankName, String bankAccount, String accountName}) {
    return Bankcard(
      bankName: bankName ?? this.bankName,
      bankAccount: bankAccount ?? this.bankAccount,
      accountName: accountName ?? this.accountName,
    );
  }
}
