import 'package:flutter/widgets.dart';

import '../state/home_store.dart';
import 'home_display_size_calc.dart';

abstract class HomeDisplayProviderInterface with ChangeNotifier {
  void updateBannerSize(bool expand);
}

class HomeDisplayProvider
    with ChangeNotifier
    implements HomeDisplayProviderInterface {
  final HomeStore homeStore;
  final HomeDisplaySizeCalc calc;

  HomeDisplayProvider({
    @required this.homeStore,
    @required this.calc,
  });

  @override
  void updateBannerSize(bool expand) {
    calc.updatePageHeight(!expand);
  }
}
