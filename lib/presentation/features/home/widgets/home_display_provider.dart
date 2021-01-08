import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../state/home_store.dart';
import 'home_display_size_calc.dart';
import 'tabs/tab_item_size.dart';

export 'package:provider/provider.dart';

abstract class HomeDisplayProviderInterface with ChangeNotifier {
  void openGame(String url);
}

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

  @override
  bool openGame(String url) {
    final gameParam = url.split('/');
    debugPrint('game url query: $gameParam');

    /// Open game's web page if game can be found in stored map
    if (gameParam.length == 3 &&
        homeStore.hasGameInMap(
          gameParam.take(2).join('/0'),
          gameParam.last.strToInt,
        )) {
      final gameUrl = url.substring(url.indexOf('.com/') + 4);
      debugPrint('opening game: $gameUrl');
      homeStore.getGameUrl(gameUrl);
      return true;

      /// Jump to game platform page
    } else if (gameParam.length == 2) {}
    return false;
  }
}
