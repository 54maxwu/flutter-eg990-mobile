import 'package:flutter/widgets.dart';

import '../state/home_store.dart';
import 'home_display_size_calc.dart';
import 'tabs/tab_item_size.dart';

export 'package:provider/provider.dart';

abstract class HomeDisplayProviderInterface with ChangeNotifier {}

class HomeDisplayProvider
    with ChangeNotifier
    implements HomeDisplayProviderInterface {
  final HomeStore homeStore;
  final HomeDisplaySizeCalc calc;
  final TabItemSize tabItemSize;

  HomeDisplayProvider({
    @required this.homeStore,
    @required this.calc,
    @required this.tabItemSize,
  }) {
    calc.updateBarWidth(tabItemSize.getTabConstraint.minWidth);
  }
}
