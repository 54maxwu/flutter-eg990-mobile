import 'package:flutter/widgets.dart';

import '../state/deposit_store.dart';
import 'methods/deposit_method_control.dart';

abstract class DepositDisplayProviderInterface with ChangeNotifier {
  bool get hasAvailableTypes;
}

class DepositDisplayProvider
    with ChangeNotifier
    implements DepositDisplayProviderInterface {
  final DepositStore store;
  final DepositMethodControl methodControl = DepositMethodControl();

  DepositDisplayProvider({
    @required this.store,
  });

  @override
  bool get hasAvailableTypes => store.depositTypes?.isNotEmpty ?? false;
}
