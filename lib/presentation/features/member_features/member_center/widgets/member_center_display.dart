import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/member_center/widgets/member_detail_list.dart';
import 'package:flutter_eg990_mobile/presentation/features/member_features/member_center/widgets/member_vip_level_list.dart';

import '../data/member_center_tabs.dart';

class MemberCenterDisplay extends StatefulWidget {
  MemberCenterDisplay({Key key}) : super(key: key);

  @override
  _MemberCenterDisplayState createState() => _MemberCenterDisplayState();
}

class _MemberCenterDisplayState extends State<MemberCenterDisplay>
    with SingleTickerProviderStateMixin {
  final GlobalKey _barKey = GlobalKey(debugLabel: 'membertabs');
  final GlobalKey _viewKey = GlobalKey(debugLabel: 'memberview');

  List<MemberCenterTab> _tabs;
  List<Widget> _tabsView;
  TabController _tabController;

  @override
  void initState() {
    _tabs = MemberCenterTab.mapAll;
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    _tabsView = null;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MemberCenterDisplay oldWidget) {
    if (oldWidget.key != widget.key) _tabs = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose member detail tab controller has exception: $e',
        tag: "MemberCenterDisplay",
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.isEmpty) {
      MyLogger.warn(
          msg: 'Tabs should not be empty, '
              'data needs to be constant for vnum mapping');
      return WarningDisplay(
          message: localeStr.errorInternal, widthFactor: 1, highlight: false);
    }
    _tabsView ??= List.generate(
      _tabs.length,
      (index) {
        switch (index) {
          case 0:
            return MemberDetailList();
          case 1:
            return MemberVipLevelList();
          default:
            return Container();
        }
      },
    );
    return Scaffold(
      backgroundColor: themeColor.defaultLayeredBackgroundColor,
      appBar: AppBar(
        leadingWidth: 0.0,
        elevation: 0.0,
        title: TabBar(
          key: _barKey,
          controller: _tabController,
          unselectedLabelColor: themeColor.defaultHintColor,
          labelColor: themeColor.defaultTextColor,
          labelStyle: TextStyle(fontSize: FontSize.SUBTITLE.value),
          indicatorColor: themeColor.defaultAccentColor,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: List.generate(
            _tabs.length,
            (index) => Tab(text: _tabs[index].label),
          ),
        ),
      ),
      body: TabBarView(
        key: _viewKey,
        controller: _tabController,
        children: _tabsView,
      ),
    );
  }
}
