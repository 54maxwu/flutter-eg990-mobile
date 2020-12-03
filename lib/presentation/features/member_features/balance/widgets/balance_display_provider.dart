import 'package:flutter/widgets.dart';

import '../state/balance_store.dart';
import '../data/balance_grid_action_type.dart';

abstract class BalanceDisplayProviderInterface with ChangeNotifier {}

class BalanceDisplayProvider
    with ChangeNotifier
    implements BalanceDisplayProviderInterface {
  final BalanceStore store;
  final BalanceGridActionType actionType;

  BalanceDisplayProvider({
    @required this.store,
    @required this.actionType,
  });
}
