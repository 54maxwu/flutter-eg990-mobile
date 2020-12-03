import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'balance_grid_action_type.dart';

typedef void BalanceGridCall(BalanceGridAction action);

@immutable
class BalanceGridAction {
  final BalanceGridActionType type;
  final String platform;
  final String credit;

  const BalanceGridAction.transfer({
    @required this.platform,
    @required this.credit,
  }) : this.type = BalanceGridActionType.transfer;

  const BalanceGridAction.withdraw({
    @required this.platform,
    @required this.credit,
  }) : this.type = BalanceGridActionType.withdraw;
}
