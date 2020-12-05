import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/domain/sector/notice_board/notice_type.dart';

import '../state/notice_store.dart';
import 'notice_list.dart';

class NoticeDisplay extends StatefulWidget {
  final NoticeStore store;

  NoticeDisplay({Key key, @required this.store}) : super(key: key);

  @override
  _NoticeDisplayState createState() => _NoticeDisplayState();
}

class _NoticeDisplayState extends State<NoticeDisplay>
    with SingleTickerProviderStateMixin {
  final GlobalKey _barKey = GlobalKey(debugLabel: 'noticetabs');
  final GlobalKey _viewKey = GlobalKey(debugLabel: 'noticeview');

  List<NoticeType> _types;
  TabController _tabController;

  @override
  void initState() {
    _types = new List();
    widget.store.notice.keys.forEach((key) {
      _types.add(NoticeType(key));
    });
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: _types.length, vsync: this);
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose notice tab controller has exception: $e',
        tag: "NoticeDisplay",
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_types.isEmpty) {
      MyLogger.warn(
          msg: "notice type is empty, check json map keys"
              "and [NoticeType] value");
      _types = NoticeType.basicTabs;
    }
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
            _types.length,
            (index) => Tab(text: _types[index].label),
          ),
        ),
      ),
      body: TabBarView(
        key: _viewKey,
        controller: _tabController,
        children: List.generate(
          _types.length,
          (index) => NoticeList(
            list: widget.store.notice[_types[index].value] ?? [],
          ),
        ),
      ),
    );
  }
}
