import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/tabs_page_control_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/store/data/entity/store_tabs.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/store/presentation/widgets/point_widget.dart';

import '../state/point_store.dart';
import 'point_store_inherit_widget.dart';
import 'store_display_products.dart';
import 'store_display_record.dart';
import 'store_display_rules.dart';

/// Display promo category and items
/// [promos] = data from repository
/// [showPromoId] = promo's id when home page banner was clicked
class StoreDisplayTabs extends StatefulWidget {
  final PointStore store;
  final double parentHeight;

  StoreDisplayTabs({
    @required this.store,
    @required this.parentHeight,
  });

  @override
  _StoreDisplayTabsState createState() => _StoreDisplayTabsState();
}

class _StoreDisplayTabsState extends State<StoreDisplayTabs>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final GlobalKey routeKey = new GlobalKey();
  final List<StoreTabsEnum> _tabs = [
    StoreTabsEnum.product,
    StoreTabsEnum.rules,
    StoreTabsEnum.records,
  ];

  TabController _tabController;
  PageController _pageController;
  Size _tabSize;
  int _tabIndex = 0;
  double _contentMaxHeight;
  Widget _contentWidget;

  /// Set [_tabIndex] to change tab bar item color
  void _setActiveTabIndex() {
    // set state to change tab's image color
    _tabIndex = _tabController.index;
    setState(() {});
  }

  @override
  void initState() {
    _tabSize = Size(Global.device.width / 3, Global.device.comfortButtonHeight);
    print('store tab size: $_tabSize');
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _pageController = PageController();
    _tabController.addListener(_setActiveTabIndex);
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.warn(msg: '${e.runtimeType}', tag: "StoreDisplayTabs", error: e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        /* Tab Bar */
        TabBar(
          unselectedLabelColor: Themes.secondaryTextColor1,
          labelColor: Themes.buttonTextPrimaryColor,
          labelStyle: TextStyle(fontSize: FontSize.SUBTITLE.value),
          labelPadding: EdgeInsets.zero,
          indicatorColor: Colors.transparent,
//          indicatorSize: TabBarIndicatorSize.label,
//          indicatorWeight: 2.0,
//          indicatorPadding: const EdgeInsets.only(bottom: 1.0),
          controller: _tabController,
          /* Category Tabs */
          tabs: List.generate(_tabs.length, (index) {
            return Container(
              constraints: BoxConstraints.tight(_tabSize),
              decoration: BoxDecoration(
                color: (index == _tabIndex)
                    ? Themes.defaultTabSelectedColor
                    : Themes.defaultTabUnselectedColor,
                border: Border.all(color: Themes.defaultBorderColor),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1.15,
                    blurRadius: 1.0, // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                _tabs[index].label,
                style: TextStyle(
                  color: (index == _tabIndex)
                      ? Themes.defaultTabSelectedTextColor
                      : Themes.defaultTextColor,
                  fontSize: FontSize.MESSAGE.value,
                ),
              ),
            );
          }),
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
        /* Tab Content */
        if (_contentWidget != null)
          Expanded(
            child: _contentWidget,
          ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (_contentWidget == null) {
      _contentWidget = _buildContentView();
      setState(() {});
    }
  }

  Widget _buildContentView() {
    _contentMaxHeight = widget.parentHeight - _tabSize.height - 8;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: _contentMaxHeight),
      child: PointStoreInheritedWidget(
        key: routeKey,
        store: widget.store,
        pointWidget: PointWidget(widget.store),
        child: new TabsPageControlWidget(
          pageController: _pageController,
          tabController: _tabController,
          children: [
            StoreDisplayProducts(),
            StoreDisplayRules(_contentMaxHeight),
            StoreDisplayRecord(_contentMaxHeight),
          ],
        ),
      ),
    );
  }
}
