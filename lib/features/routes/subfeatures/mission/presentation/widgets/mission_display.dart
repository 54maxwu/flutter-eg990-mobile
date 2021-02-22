import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/mission/data/models/mission_list_model.dart';

import '../data/mission_type.dart';
import '../state/mission_store.dart';
import 'mission_list_view.dart';
import 'mission_rule_dialog.dart';

class MissionDisplay extends StatefulWidget {
  final MissionStore store;

  MissionDisplay({Key key, @required this.store}) : super(key: key);

  @override
  _MissionDisplayState createState() => _MissionDisplayState();
}

class _MissionDisplayState extends State<MissionDisplay>
    with SingleTickerProviderStateMixin {
  final GlobalKey _barKey = GlobalKey(debugLabel: 'missiontabs');
  final GlobalKey _viewKey = GlobalKey(debugLabel: 'missionview');

  TabController _tabController;
  List<MissionTypeEnum> _types;
  int _current = 0;

  @override
  void initState() {
    _types = MissionTypeEnum.mapAll;
    _types.removeWhere((t) => widget.store.initData[t.value.id].isEmpty);
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: _types.length, vsync: this);
    _tabController.addListener(() {
      _current = _tabController.index;
    });
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
    } catch (e) {
      MyLogger.debug(
        msg: 'dispose mission tab controller has exception: $e',
        tag: "MissionDisplay",
      );
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_types.isEmpty) {
      MyLogger.warn(
          msg: "mission type is empty, [MissionTypeEnum] value need to be "
              "constant for vnum map to work.");
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leadingWidth: 0.0,
        elevation: 0.0,
        backgroundColor: themeColor.missionTabColor,
        leading: SizedBox.shrink(),
        titleSpacing: 0,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
              child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: FontSize.MESSAGE.value,
                    color: themeColor.missionTextColor,
                  ),
                  onTap: () {
                    _tabController?.animateTo(
                        (_current == 0) ? _types.length - 1 : _current - 1);
                  }),
            ),
            Expanded(
              child: TabBar(
                key: _barKey,
                controller: _tabController,
                isScrollable: true,
                physics: const BouncingScrollPhysics(),
                unselectedLabelColor: themeColor.missionTextColor,
                labelColor: themeColor.missionTabColor,
                labelStyle: TextStyle(fontSize: FontSize.SUBTITLE.value),
                indicator:
                    BoxDecoration(color: themeColor.missionTabSelectedColor),
                indicatorSize: TabBarIndicatorSize.tab,
                /* Category Tabs */
                tabs: _types.map((tab) {
                  return Container(
                    width: FontSize.MESSAGE.value * 5,
                    height: FontSize.MESSAGE.value * 2,
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      tab.label,
                      maxLines: (Global.lang.isChinese) ? 1 : 2,
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: FontSize.MESSAGE.value,
                  color: themeColor.missionTextColor,
                ),
                onTap: () {
                  _tabController?.animateTo(
                      (_current == _types.length - 1) ? 0 : _current + 1);
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.center,
            stops: [0.12, 0.88],
            colors: [
              themeColor.missionBackgroundLinear1,
              themeColor.missionBackgroundLinear2,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RaisedButton(
                    onPressed: () => widget.store.initialize(),
                    shape: StadiumBorder(),
                    color: themeColor.missionRefreshButtonColor,
                    visualDensity:
                        const VisualDensity(horizontal: 2, vertical: -2),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: localeStr.btnRefresh,
                            style:
                                TextStyle(color: themeColor.missionTextColor),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 1),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(
                                  Icons.refresh,
                                  size: FontSize.MESSAGE.value,
                                  color: themeColor.missionTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: localeStr.missionTextRule,
                            style:
                                TextStyle(color: themeColor.missionTextColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) =>
                                        new MissionRulesDialog(
                                      rules: widget.store.rules,
                                    ),
                                  ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 2),
                              child: Icon(
                                Icons.help,
                                size: FontSize.SUBTITLE.value,
                                color: themeColor.missionTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                key: _viewKey,
                controller: _tabController,
                children: List.generate(
                  _types.length,
                  (index) => MissionListView(
                    store: widget.store,
                    missionType: _types[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
