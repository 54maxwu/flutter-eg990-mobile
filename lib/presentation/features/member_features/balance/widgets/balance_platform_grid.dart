import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_mobx_observer.dart';

import '../state/balance_store.dart';
import 'balance_grid_item.dart';
import 'balance_display_provider.dart';

class BalancePlatformGrid extends StatefulWidget {
  const BalancePlatformGrid({Key key}) : super(key: key);

  @override
  _BalancePlatformGridState createState() => _BalancePlatformGridState();
}

class _BalancePlatformGridState extends State<BalancePlatformGrid> {
  int _gridAxisCount;
  int _noDividerIndex;

  BalanceStore _store;
  List<ReactionDisposer> _disposers;
  List<String> _platforms;
  List<GlobalKey<BalanceGridItemState>> _gridKeys;

  SliverGrid _sliver;

  void initDisposer() {
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.balanceUpdated,
        // Run some logic with the content of the observed field
        (String platform) {
          if (platform == null || platform.isEmpty) return;
          debugPrint('reaction on $platform balance update...');
          int gridIndex = _platforms.indexOf(platform);
          debugPrint('grid index: $gridIndex');
          GlobalKey<BalanceGridItemState> key = _gridKeys[gridIndex];
          debugPrint('grid credit: ${_store.balanceMap[platform]}');
          key.currentState.setCredit = _store.balanceMap[platform];
        },
      ),
    ];
  }

  @override
  void initState() {
    _gridAxisCount = ((Global.device.width - 32) / 100).floor();
    _noDividerIndex = _gridAxisCount - 1;
    super.initState();
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _store = null;
    _sliver = null;
    _gridKeys = null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<BalanceDisplayProvider>(context).store;
    _platforms ??= List.from(_store.promises);
    if (_platforms.length % _gridAxisCount != 0) {
      int emptyBlockCount =
          _gridAxisCount - (_platforms.length % _gridAxisCount);
      for (int i = 0; i < emptyBlockCount; i++) {
        _platforms.add('');
      }
    }
    if (_disposers == null) initDisposer();
    _gridKeys ??= new List();
    _sliver ??= SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridAxisCount,
        mainAxisSpacing: 0.0,
        childAspectRatio: 1.35,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          final String platform = _platforms[index];
          if (platform.isNotEmpty) {
            GlobalKey<BalanceGridItemState> key =
                new GlobalKey<BalanceGridItemState>(debugLabel: platform);
            _gridKeys.add(key);
            return BalanceGridItem(
              key: key,
              platform: platform,
              addDivider: index % _gridAxisCount != _noDividerIndex,
              onTapAction: (action) {},
            );
          } else {
            return BalanceGridItem(
              platform: '',
              addDivider: false,
              onTapAction: null,
            );
          }
        },
        childCount: _platforms.length,
      ),
    );
    return CustomScrollView(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      slivers: [_sliver],
    );
  }
}
