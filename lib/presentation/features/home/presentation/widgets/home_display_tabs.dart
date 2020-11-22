import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_category_entity.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/models/game_category_model.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/widgets/home_display_provider.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/widgets/pageview/platforms_page.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/widgets/tabs/tab_control.dart';
import 'package:provider/provider.dart';

import 'tabs/tab_item.dart';
import 'tabs/vertical_tabs.dart';

class HomeDisplayTabs extends StatefulWidget {
  final List<GameCategoryEntity> tabs;

  HomeDisplayTabs({Key key, @required this.tabs}) : super(key: key);

  @override
  HomeDisplayTabsState createState() => HomeDisplayTabsState();
}

class HomeDisplayTabsState extends State<HomeDisplayTabs> {
  final TabControl tabControl = TabControl();

  @override
  void initState() {
    debugPrint('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isEmpty) {
      return WarningDisplay(message: Failure.server().message);
    }
    return ChangeNotifierProvider<TabControl>.value(
      value: tabControl,
      child: VerticalTabs(
        tabsWidth: Provider.of<HomeDisplayProvider>(context).calc.barMaxWidth,
        onSelect: (index) => tabControl.setTabIndex = index,
        contentScrollAxis: Axis.horizontal,
        tabs: List<Tab>.generate(
            widget.tabs.length,
            (index) => Tab(
                  child: TabItem(
                    index: index,
                    info: widget.tabs[index].info.value,
                  ),
                )),
        contents: List.generate(widget.tabs.length,
            (index) => PlatformsPage(category: widget.tabs[index].type)),
      ),
    );
  }
}
