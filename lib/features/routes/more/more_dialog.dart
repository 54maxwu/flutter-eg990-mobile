import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/state/event_store.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/screen/feature_screen_store.dart';

import 'more_grid_item.dart';

///
///@author H.C.CHIANG
///@version 2020/6/1
///
class MoreDialog extends StatelessWidget {
  final FeatureScreenStore store;
  final EventStore eventStore;

  MoreDialog(this.store, this.eventStore);

  static final List<MoreGridItem> gridItems = [
    MoreGridItem.download,
    MoreGridItem.tutorial,
    MoreGridItem.service,
    MoreGridItem.vip,
    MoreGridItem.store,
    MoreGridItem.agentAbout,
  ];

  static final List<MoreGridItem> userGridItems = [
    MoreGridItem.notice,
    MoreGridItem.download,
    MoreGridItem.tutorial,
    MoreGridItem.service,
    MoreGridItem.vip,
    MoreGridItem.store,
    MoreGridItem.agentAbout,
  ];

  final double _titleHeight = 54.0;
  final double _expectItemHeight = 96.0;

  void _itemTapped(BuildContext context, RouteListItem itemValue) {
    debugPrint('item tapped: $itemValue');
    if (itemValue.route != null) {
      if (itemValue.isUserOnly && store.hasUser == false) {
        // navigate to login page
        AppNavigator.navigateTo(RoutePage.login);
      } else if (itemValue.id == RouteEnum.TUTORIAL ||
          itemValue.id == RouteEnum.AGENT_ABOUT ||
          itemValue.id == RouteEnum.SERVICE) {
        AppNavigator.replaceWith(itemValue.route);
      } else {
        // navigate to route
        AppNavigator.navigateTo(itemValue.route);
      }
      Future.delayed(
        Duration(milliseconds: 100),
        () => Navigator.of(context).pop(),
      );
    } else if (itemValue == MoreGridItem.sign.value) {
      if (store == null) return;
      if (store.hasUser == false)
        callToastError(localeStr.messageErrorNotLogin);
      else
        eventStore.setForceShowEvent = true;
    } else {
      callToastInfo(localeStr.workInProgress);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MoreGridItem> items = (store.hasUser) ? userGridItems : gridItems;

    // screen width - widget padding - cross space = available width
    double itemWidth = (Global.device.width - 48) / 3;
    double gridRatio = itemWidth / _expectItemHeight;
    debugPrint('grid item width: $itemWidth, gridRatio: $gridRatio');

    double baseTextSize = (Global.device.isIos)
        ? FontSize.NORMAL.value + 1
        : FontSize.NORMAL.value;
    int availableCharacters = (itemWidth * 0.95 - 16.0 / baseTextSize).round();
    bool hasDoubleLineText =
        items.any((element) => element.isLongText(availableCharacters));
    debugPrint('item hasDoubleLineText: $hasDoubleLineText');

    int row = items.length ~/ 3;
    if (items.length % 3 > 0) row += 1;
    int _generateGrid = row * 3;
    debugPrint('grid row: $row, generate: $_generateGrid');

    double _totalHeight = itemWidth / gridRatio * row;
    double _height = _titleHeight + _totalHeight + 6.0;
    debugPrint('dialog height: $_height');

    return DialogWidget(
      maxHeight: _height,
      customBg: themeColor.moreDialogColor,
      padding: Global.device.dialogInset +
          EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: _titleHeight,
              decoration: BoxDecoration(
                color: themeColor.dialogTitleBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                localeStr.pageTitleMore,
                style: TextStyle(
                  fontSize: FontSize.TITLE.value,
                  color: themeColor.dialogTitleColor,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: gridRatio,
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _generateGrid,
                  itemBuilder: (context, index) {
                    var itemValue =
                        (index < items.length) ? items[index].value : null;
                    return GestureDetector(
                      onTap: (itemValue != null)
                          ? () => _itemTapped(context, itemValue)
                          : null,
                      child: _createGridItem(
                        itemValue,
                        hasDoubleLineText: hasDoubleLineText,
                        fixedMarginLeft: index % 3 == 2,
                        fixedMarginBottom: (index / 3).floor() == 1,
                        cornerBorderLeft: index == _generateGrid - 3,
                        cornerBorderRight: index == _generateGrid - 1,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createGridItem(
    RouteListItem itemValue, {
    bool hasDoubleLineText,
    bool fixedMarginLeft,
    bool fixedMarginBottom,
    bool cornerBorderLeft,
    bool cornerBorderRight,
  }) {
    BorderRadius cornerBorder;
    if (cornerBorderLeft)
      cornerBorder = BorderRadius.only(
        bottomLeft: Radius.circular(16.0),
      );
    else if (cornerBorderRight)
      cornerBorder = BorderRadius.only(
        bottomRight: Radius.circular(16.0),
      );
    else
      cornerBorder = BorderRadius.zero;

    return Container(
      height: _expectItemHeight,
      decoration: BoxDecoration(
        color: themeColor.moreGridColor,
        borderRadius: cornerBorder,
      ),
      margin: EdgeInsets.fromLTRB((fixedMarginLeft) ? 1.0 : 0.75, 0.5, 0.0,
          (fixedMarginBottom) ? 0.2 : 0.5),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: (hasDoubleLineText)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: (itemValue == null)
            ? []
            : <Widget>[
                Padding(
                  padding: (hasDoubleLineText)
                      ? const EdgeInsets.only(top: 16.0)
                      : EdgeInsets.zero,
                  child: (itemValue.imageName != null)
                      ? SizedBox(
                          width: 32.0,
                          height: 32.0,
                          child: (itemValue.imageName.startsWith('assets/'))
                              ? Image.asset(
                                  itemValue.imageName,
                                  color: themeColor.defaultAccentColor,
                                )
                              : networkImageBuilder(
                                  itemValue.imageName,
                                  imgColor: themeColor.defaultAccentColor,
                                ),
                        )
                      : Icon(
                          itemValue.iconData,
                          color: themeColor.defaultAccentColor,
                          size: 32.0,
                        ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  height: (hasDoubleLineText)
                      ? FontSize.NORMAL.value * 3.5
                      : FontSize.NORMAL.value * 2,
                  child: Text(
                    itemValue.title ?? itemValue.route?.pageTitle ?? '?',
                    style: TextStyle(
                      fontSize: FontSize.NORMAL.value,
                      color: themeColor.defaultGridTextColor,
                    ),
                    maxLines: (hasDoubleLineText) ? 2 : 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
      ),
    );
  }
}
