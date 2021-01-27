import 'package:flutter/widgets.dart';

import '../state/bankcard_store.dart';

export 'package:provider/provider.dart';

abstract class BankcardDisplayProviderInterface with ChangeNotifier {
  set setPage(BankcardPageEnum page);
}

enum BankcardPageEnum { NEW_CARD, LIST }

class BankcardDisplayProvider
    with ChangeNotifier
    implements BankcardDisplayProviderInterface {
  final BankcardStore store;

  BankcardDisplayProvider({
    @required this.store,
    BankcardPageEnum startPage,
  }) {
    if (startPage != null) {
      page = startPage;
    }
  }

  BankcardPageEnum page;

  @override
  set setPage(BankcardPageEnum page) {
    this.page = page;
    notifyListeners();
  }
}
