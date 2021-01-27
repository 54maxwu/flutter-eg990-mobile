import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/member/presentation/data/member_grid_item.dart';
import 'package:flutter_eg990_mobile/features/routes/member/presentation/widgets/member_grid_item_widget_badge.dart';
import 'package:flutter_eg990_mobile/features/screen/feature_screen_inherited_widget.dart';

import '../state/member_credit_store.dart';
import 'member_display_header.dart';
import 'member_grid_item_widget.dart';

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
  final double _gridExtent = 160.0;
  final double _gridItemSpace = 8.0;

  double headerMaxHeight;
  double headerMinHeight = 160;

  static final List<MemberGridItem> _gridItems = [
    MemberGridItem.deposit,
    MemberGridItem.transfer,
    MemberGridItem.bankcard,
    MemberGridItem.withdraw,
    MemberGridItem.balance,
    MemberGridItem.wallet,
    MemberGridItem.stationMessages,
    MemberGridItem.accountCenter,
    MemberGridItem.transferRecord,
    MemberGridItem.betRecord,
    MemberGridItem.dealRecord,
    MemberGridItem.rollbacks,
    MemberGridItem.logout,
  ];

  void _itemTapped(MemberGridItem item) {
    debugPrint('item tapped: $item');
    if (item == MemberGridItem.logout) {
      getAppGlobalStreams.logout(navToLogin: true);
    } else if (item.value.route != null) {
      AppNavigator.navigateTo(item.value.route);
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
          stream: AppNavigator.routerStreams.recheckUserStream,
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
            padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: _gridExtent,
                mainAxisSpacing: _gridItemSpace,
                crossAxisSpacing: _gridItemSpace,
              ),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _gridItems.length,
              // itemCount: _gridItems.length,
              itemBuilder: (_, index) {
                if (_gridItems[index].value.id == RouteEnum.MESSAGE) {
                  return MemberGridItemWidgetBadge(
                    item: _gridItems[index],
                    onItemTap: (value) => _itemTapped(value),
                    store: widget.store,
                  );
                } else {
                  return MemberGridItemWidget(
                    item: _gridItems[index],
                    onItemTap: (value) => _itemTapped(value),
                  );
                }
              },
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
