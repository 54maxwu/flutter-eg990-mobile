import 'package:meta/meta.dart' show immutable, required;

@immutable
class Bankcard {
  final bool hasCard;
  final String bankName;
  final String bankAccount;
  final String accountName;
  final String bankAddress;

  const Bankcard.empty({
    this.bankName = '',
    this.bankAccount = '',
    this.accountName = '',
    this.bankAddress = '',
  }) : this.hasCard = false;

  const Bankcard({
    @required this.bankName,
    @required this.bankAccount,
    @required this.accountName,
    @required this.bankAddress,
  }) : this.hasCard = true;

//<editor-fold desc="Data Methods" defaultstate="collapsed">
  Bankcard copyWith({
    bool hasCard,
    String bankName,
    String bankAccount,
    String accountName,
    String bankAddress,
  }) {
    if ((hasCard == null || identical(hasCard, this.hasCard)) &&
        (bankName == null || identical(bankName, this.bankName)) &&
        (bankAccount == null || identical(bankAccount, this.bankAccount)) &&
        (accountName == null || identical(accountName, this.accountName)) &&
        (bankAddress == null || identical(bankAddress, this.bankAddress))) {
      return this;
    }

    return new Bankcard(
      bankName: bankName ?? this.bankName,
      bankAccount: bankAccount ?? this.bankAccount,
      accountName: accountName ?? this.accountName,
      bankAddress: bankAddress ?? this.bankAddress,
    );
  }

  @override
  String toString() {
    return 'Bankcard{hasCard: $hasCard, bankName: $bankName, bankAccount: $bankAccount, accountName: $accountName, bankAddress: $bankAddress}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bankcard &&
          runtimeType == other.runtimeType &&
          hasCard == other.hasCard &&
          bankName == other.bankName &&
          bankAccount == other.bankAccount &&
          accountName == other.accountName &&
          bankAddress == other.bankAddress);

  @override
  int get hashCode =>
      hasCard.hashCode ^
      bankName.hashCode ^
      bankAccount.hashCode ^
      accountName.hashCode ^
      bankAddress.hashCode;
//</editor-fold>

}
