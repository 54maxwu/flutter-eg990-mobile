enum BalanceGridAction { transferIn, transferOut, refresh }

typedef BalanceGridCall = Future Function(
    BalanceGridAction action, String platform);
