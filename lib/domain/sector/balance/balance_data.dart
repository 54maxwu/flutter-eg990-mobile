import 'package:meta/meta.dart' show immutable, required;

@immutable
class BalanceData {
  final String platform;
  final String amount;
  final String error;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const BalanceData({
    @required this.platform,
    @required this.amount,
    this.error = '',
  });

  BalanceData copyWith({
    String platform,
    String amount,
    String error,
  }) {
    if ((platform == null || identical(platform, this.platform)) &&
        (amount == null || identical(amount, this.amount)) &&
        (error == null || identical(error, this.error))) {
      return this;
    }

    return new BalanceData(
      platform: platform ?? this.platform,
      amount: amount ?? this.amount,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'BalanceData{platform: $platform, amount: $amount, error: $error}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BalanceData &&
          runtimeType == other.runtimeType &&
          platform == other.platform &&
          amount == other.amount &&
          error == other.error);

  @override
  int get hashCode => platform.hashCode ^ amount.hashCode ^ error.hashCode;

//</editor-fold>

}
