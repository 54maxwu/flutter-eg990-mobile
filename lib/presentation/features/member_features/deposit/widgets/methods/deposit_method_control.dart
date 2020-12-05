import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';

export 'package:provider/provider.dart';

abstract class DepositMethodControlInterface with ChangeNotifier {
  DepositMethod get getSelected;

  set setSelected(DepositMethod index);
}

class DepositMethodControl
    with ChangeNotifier
    implements DepositMethodControlInterface {
  DepositMethod _selected;

  @override
  DepositMethod get getSelected => _selected;

  @override
  set setSelected(DepositMethod selected) {
    _selected = selected;
    notifyListeners();
  }
}
