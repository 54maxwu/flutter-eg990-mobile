import 'dart:collection';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/home/data/models/game_category_model.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_platform_entity.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_types_entity.dart';
import 'package:flutter_ty_mobile/features/home/domain/usecase/usecase_export.dart';

import '../../../../widget_res_export.dart' show FontSize, Global, HexColor;
import 'game_display_page.dart';
import 'game_display_tab_view.dart';

///
///@author H.C.CHIANG
///@version 2020/1/14
class GameDisplayTab extends StatefulWidget {
  final GameTypesEntity tabsData;

  GameDisplayTab({
    Key key,
    @required this.tabsData,
  }) : super(key: key);

  @override
  _GameDisplayTabState createState() => _GameDisplayTabState();
}

class _GameDisplayTabState extends State<GameDisplayTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  List<GameCategoryModel> _tabs;
  HashMap<String, List<GamePlatformEntity>> _platformMap;
  int _tabCnt;

  @override
  void initState() {
//    print('game tabs data: ${widget.tabsData}');
    _tabs = new List.from(widget.tabsData.categories);
    _tabCnt = _tabs.length;
    print('game tabs count = $_tabCnt');
    mapPlatforms();
    super.initState();

    _tabController = TabController(length: _tabCnt, vsync: this);
    _pageController = PageController();
  }

  void mapPlatforms() {
    final all = widget.tabsData.platforms;
    _platformMap = new HashMap();
    _tabs.forEach((category) {
      var list = List<GamePlatformEntity>.from(
          all.where((platform) => category.type == platform.category));
      _platformMap.putIfAbsent(category.type, () => list);
    });
//    _platformMap.keys.forEach((key) =>
//        MyLogger.print(msg: '$key: ${_platformMap[key]}', tag: 'PlatformMap'));
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.warn(msg: '${e.runtimeType}', tag: "GameDisplayTab", error: e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          color: HexColor.fromHex('#313131'),
          elevation: 3.0,
          child: Container(
            height: 68, // here the desired height
            child: TabBar(
              unselectedLabelColor: Colors.white60,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: FontSize.NORMAL.value),
              labelPadding: EdgeInsets.only(top: 4.0),
              indicatorWeight: 3.0,
              controller: _tabController,
              /* Category Tabs */
              tabs: _tabs.map((data) {
                return Tab(
                  text: data.ch,
                  icon: ExtendedImage.network(
                    '${Global.TEST_BASE_URL}${data.getIconUrl()}',
                    scale: 3.0,
                  ),
                  iconMargin: EdgeInsets.only(bottom: 2.0),
                );
              }).toList(),
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
        Expanded(
          child: GameDisplayTabView(
            pageController: _pageController,
            tabController: _tabController,
            children: _tabs.map((data) {
              return GameDisplayPage(
                platforms: _platformMap[data.type],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
