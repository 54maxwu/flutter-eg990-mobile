import 'package:flutter/widgets.dart';

import '../state/bet_record_store.dart';

abstract class BetRecordDisplayProviderInterface with ChangeNotifier {}

class BetRecordDisplayProvider
    with ChangeNotifier
    implements BetRecordDisplayProviderInterface {
  final BetRecordStore recordStore;

  BetRecordDisplayProvider({
    @required this.recordStore,
  });
}
