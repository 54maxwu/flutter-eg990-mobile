import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../state/balance_store.dart';
import 'balance_grid_item.dart';

class BalanceDisplay extends StatefulWidget {
  final BalanceStore store;

  BalanceDisplay(this.store);

  @override
  _BalanceDisplayState createState() => _BalanceDisplayState();
}

class _BalanceDisplayState extends State<BalanceDisplay> {
  final GlobalKey progressTextKey = new GlobalKey();
  List<String> platforms;
  List<GlobalKey<BalanceGridItemState>> gridKeys;
  List<BalanceGridItem> gridItems;
  List<ReactionDisposer> _disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.balanceUpdated,
        // Run some logic with the content of the observed field
        (String platform) {
          if (platform == null || platform.isEmpty) return;
          print('reaction on $platform update...');
          int gridIndex = platforms.indexOf(platform);
          print('grid index: $gridIndex');
          GlobalKey<BalanceGridItemState> key = gridItems[gridIndex].key;
          print('new platform credit: ${widget.store.balanceMap[platform]}');
          key.currentState.setCredit = widget.store.balanceMap[platform];
        },
      ),
    ];
  }

  @override
  void dispose() {
    try {
      widget.store.closeStreams();
      _disposers.forEach((d) => d());
    } on Exception {}
    super.dispose();
  }

  @override
  void initState() {
    platforms = widget.store.promises;
    super.initState();
    widget.store.getCreditLimit();
  }

  @override
  Widget build(BuildContext context) {
    gridKeys ??= new List();
    gridItems ??= platforms.map((platform) {
      GlobalKey<BalanceGridItemState> key =
          new GlobalKey<BalanceGridItemState>(debugLabel: platform);
      gridKeys.add(key);
      return BalanceGridItem(
        key,
        platform,
        onTapAction: (action, platform) {
          if (widget.store.waitForTransferResult)
            callToast(localeStr.messageWait);
          else
            widget.store.exeGridAction(action, platform);
        },
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                  child: StreamBuilder<String>(
                    stream: widget.store.loadingStream,
                    builder: (context, snapshot) {
                      if (snapshot != null &&
                          snapshot.data != null &&
                          snapshot.data.isNotEmpty) {
//                        print('balance progress: ${snapshot.data}');
                        return Row(
                          children: <Widget>[
                            SizedBox(
                              width: 14.0,
                              height: 14.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                snapshot.data,
                                key: progressTextKey,
                                style: TextStyle(
                                  fontSize: FontSize.SUBTITLE.value,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else
                        return SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
            GridView.count(
              physics: ClampingScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.35,
              shrinkWrap: true,
              children: gridItems,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Themes.defaultTextColor),
                        children: [
                          TextSpan(
                            text: '${localeStr.balanceHintTextTitle}\n',
                            style: TextStyle(
                              color: Themes.defaultSubtitleColor,
                              fontWeight: FontWeight.bold,
                              height: 3,
                            ),
                          ),
                          TextSpan(
                            text: '${localeStr.balanceHintText1}'
                                '\n${localeStr.balanceHintText2}'
                                '\n${localeStr.balanceHintText3}'
                                '\n${localeStr.balanceHintText4}',
                            style: TextStyle(height: 1.75),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
