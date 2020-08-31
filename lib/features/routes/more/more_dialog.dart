import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/event_inject.dart';
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
    MoreGridItem.notice,
    MoreGridItem.download,
    MoreGridItem.tutorial,
    MoreGridItem.service,
    MoreGridItem.routeChange,
    MoreGridItem.store,
    MoreGridItem.roller,
    MoreGridItem.task,
    MoreGridItem.sign,
    MoreGridItem.agentAbout,
    MoreGridItem.collect,
  ];

  final double _titleHeight = 54.0;
  final double _expectItemHeight = 96.0;

  void _itemTapped(BuildContext context, RouteListItem itemValue) {
    debugPrint('item tapped: $itemValue');
    if (itemValue.route != null) {
      if (itemValue.isUserOnly && store.hasUser == false) {
        // navigate to login page
        RouterNavigate.navigateToPage(RoutePage.login);
      } else if (itemValue.id == RouteEnum.SERVICE) {
        RouterNavigate.replacePage(
          itemValue.route,
          arg: WebRouteArguments(startUrl: Global.currentService),
        );
      } else if (itemValue.id == RouteEnum.TUTORIAL ||
          itemValue.id == RouteEnum.AGENT_ABOUT) {
        RouterNavigate.replacePage(itemValue.route);
      } else {
        // navigate to route
        RouterNavigate.navigateToPage(itemValue.route);
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
    // screen width - widget padding - cross space = available width
    double itemWidth = (Global.device.width - 48) / 3;
    double gridRatio = itemWidth / _expectItemHeight;
    debugPrint('grid item width: $itemWidth, gridRatio: $gridRatio');

    double baseTextSize = (Global.device.isIos)
        ? FontSize.NORMAL.value + 1
        : FontSize.NORMAL.value;
    int availableCharacters = (itemWidth * 0.95 - 16.0 / baseTextSize).round();
    bool hasDoubleLineText =
        gridItems.any((element) => element.isLongText(availableCharacters));
    debugPrint('item hasDoubleLineText: $hasDoubleLineText');

    int row = gridItems.length ~/ 3;
    if (gridItems.length % 3 > 0) row += 1;
    int _generateGrid = row * 3;
    debugPrint('grid row: $row, generate: $_generateGrid');

    // 16.0 = border radius
    double _height =
        (_titleHeight + row * _expectItemHeight).ceilToDouble() + 16.0;
    debugPrint('dialog height: $_height');

    return DialogWidget(
      maxHeight: _height,
      customBg: Themes.moreDialogColor,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: _titleHeight,
                    decoration: BoxDecoration(
                      color: Themes.dialogTitleBgColor,
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
                        color: Themes.dialogTitleColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: _expectItemHeight * row + 16.0,
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
                  var itemValue = (index < gridItems.length)
                      ? gridItems[index].value
                      : null;
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
        color: Themes.moreGridColor,
        borderRadius: cornerBorder,
      ),
      margin: EdgeInsets.fromLTRB((fixedMarginLeft) ? 0.2 : 0.5, 0.5, 0.0,
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
                                  color: Themes.defaultAccentColor,
                                )
                              : networkImageBuilder(
                                  itemValue.imageName,
                                  imgColor: Themes.defaultAccentColor,
                                ),
                        )
                      : Icon(
                          itemValue.iconData,
                          color: Themes.defaultAccentColor,
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
                      color: Themes.defaultGridTextColor,
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
