import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/category/game_category_entity.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';

import 'home_display_provider.dart';
import 'pageview/platforms_page.dart';
import 'tabs/tab_control.dart';
import 'tabs/tab_item.dart';
import 'tabs/tab_item_size.dart';
import 'tabs/vertical_tabs.dart';

class HomeDisplayTabs extends StatefulWidget {
  final List<GameCategoryEntity> tabs;

  HomeDisplayTabs({Key key, @required this.tabs}) : super(key: key);

  @override
  HomeDisplayTabsState createState() => HomeDisplayTabsState();
}

class HomeDisplayTabsState extends State<HomeDisplayTabs> {
  final TabControl tabControl = TabControl();

  TabItemSize tabSize;

  @override
  void initState() {
    debugPrint('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabSize ??= Provider.of<HomeDisplayProvider>(context).tabItemSize;
    if (widget.tabs.isEmpty) {
      return WarningDisplay(message: Failure.server().message);
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: Global.APP_NAV_HEIGHT * 0.5),
      child: ChangeNotifierProvider<TabControl>.value(
        value: tabControl,
        child: VerticalTabs(
          tabsWidth: tabSize.getTabConstraint.maxWidth,
          tabsPadding: const EdgeInsets.only(bottom: 12.0),
          onSelect: (index) => tabControl.setTabIndex = index,
          contentScrollAxis: Axis.horizontal,
          tabs: List<Tab>.generate(
            widget.tabs.length,
            (index) => Tab(
              child: TabItem(
                index: index,
                info: widget.tabs[index].info.value,
                size: tabSize,
              ),
            ),
          ),
          contents: List.generate(
            widget.tabs.length,
            (index) => PlatformsPage(category: widget.tabs[index].type),
          ),
        ),
      ),
    );
  }
}
