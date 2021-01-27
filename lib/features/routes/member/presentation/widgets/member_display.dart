import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/screen/feature_screen_inherited_widget.dart';

import '../data/member_grid_item_v2.dart';
import '../state/member_credit_store.dart';
import 'member_display_header.dart';
import 'member_grid_item_widget_v2.dart';
import 'member_grid_item_widget_v2_badge.dart';

class MemberDisplay extends StatefulWidget {
  final MemberCreditStore store;

  MemberDisplay(this.store);

  @override
  _MemberDisplayState createState() => _MemberDisplayState();
}

class _MemberDisplayState extends State<MemberDisplay> with AfterLayoutMixin {
  List<ReactionDisposer> _disposers;
  final GlobalKey<MemberDisplayHeaderState> headerKey =
      new GlobalKey<MemberDisplayHeaderState>(debugLabel: 'header');
  final int _itemPerRow = 3;
  final double _itemSpace = 4.0;
  final double _iconSize = 32 * Global.device.widthScale;

  double headerMaxHeight;
  double headerMinHeight = 160;

  double _gridRatio;
  double _gridItemTextSize;
  double _gridItemTextHeight;

  static final List<MemberGridItemV2> gridItems = [
    MemberGridItemV2.deposit,
    MemberGridItemV2.transfer,
    MemberGridItemV2.bankcard,
    MemberGridItemV2.withdraw,
    MemberGridItemV2.balance,
    MemberGridItemV2.wallet,
    MemberGridItemV2.stationMessages,
    MemberGridItemV2.accountCenter,
    MemberGridItemV2.transferRecord,
    MemberGridItemV2.betRecord,
    MemberGridItemV2.dealRecord,
    MemberGridItemV2.flowRecord,
    MemberGridItemV2.logout,
  ];

  void _itemTapped(MemberGridItemV2 item) {
    debugPrint('item tapped: $item');
    if (item == MemberGridItemV2.logout) {
      getAppGlobalStreams.logout();
    } else if (item == MemberGridItemV2.withdraw && item.value.route != null) {
      RouterNavigate.navigateToPage(
        item.value.route,
        arg: BankcardRouteArguments(withdraw: true),
      );
    } else if (item.value.route != null) {
      RouterNavigate.navigateToPage(item.value.route);
    } else {
      callToastInfo(localeStr.workInProgress);
    }
  }

  @override
  void initState() {
    headerMaxHeight = Global.device.featureContentHeight / 7 * 2;
    debugPrint('header height, max: $headerMaxHeight, min: $headerMinHeight');
    if (headerMaxHeight > 200) headerMaxHeight = 200;
    if (headerMaxHeight < headerMinHeight) headerMaxHeight = headerMinHeight;

    _gridItemTextSize = FontSize.SUBTITLE.value - 1;
    _gridItemTextHeight = _gridItemTextSize * 2.5;

    double gridItemWidth =
        ((Global.device.width - 32) - _itemSpace * (_itemPerRow + 2) - 12) /
            _itemPerRow;
    _gridRatio = gridItemWidth / (_iconSize + _gridItemTextHeight + 20.0);
    debugPrint('grid item width: $gridItemWidth, gridRatio: $_gridRatio');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on error message changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.errorMessage,
        // Run some logic with the content of the observed field
        (String msg) {
          if (msg != null && msg.isNotEmpty) {
            callToastError(msg);
          }
        },
      ),
      /* Reaction on user credit changed */
      reaction(
        // Tell the reaction which observable to observe
        (_) => widget.store.credit,
        // Run some logic with the content of the observed field
        (credit) {
          debugPrint('reaction on credit update');
          headerKey.currentState.updateCredit = credit;
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        /// update new message count and member credit
        /// triggered by navigate back and user login/logout
        StreamBuilder<bool>(
          stream: RouterNavigate.routerStreams.recheckUserStream,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              widget.store.getUserCredit();
              widget.store.getNewMessageCount();
              try {
                final featureInherit =
                    FeatureScreenInheritedWidget.of(context)?.store ?? null;
                debugPrint('found feature inherit: ${featureInherit != null}');
                if (featureInherit != null) featureInherit.getNewMessageCount();
              } on Exception {}
            }
            return SizedBox.shrink();
          },
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: headerMinHeight,
            maxHeight: headerMaxHeight,
            maxWidth: Global.device.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.5, 1.0],
              colors: [
                themeColor.memberLinearColor1,
                themeColor.memberLinearColor2,
                themeColor.memberLinearColor3
              ],
              tileMode: TileMode.clamp,
            ),
          ),
          child: MemberDisplayHeader(
            key: headerKey,
            userName: widget.store.user.account,
            vipLevel: widget.store.user.vip,
            onRefresh: () => widget.store.getUserCredit(),
          ),
        ),
        /* Features Grid */
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 2.0),
            child: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: _itemPerRow,
              mainAxisSpacing: _itemSpace,
              crossAxisSpacing: _itemSpace,
              shrinkWrap: true,
              children: gridItems
                  .map((item) => (item.value.id == RouteEnum.MESSAGE)
                      ? MemberGridItemWidgetV2Badge(
                          item: item,
                          iconSize: _iconSize,
                          textSize: _gridItemTextSize,
                          textHeight: _gridItemTextHeight,
                          store: widget.store,
                          type: MemberGridItemV2BadgeType.NEW_MESSAGE,
                          onItemTap: (value) => _itemTapped(value),
                        )
                      : MemberGridItemWidgetV2(
                          item: item,
                          iconSize: _iconSize,
                          textSize: _gridItemTextSize,
                          textHeight: _gridItemTextHeight,
                          onItemTap: (value) => _itemTapped(value),
                        ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    widget.store.getUserCredit();
  }
}
