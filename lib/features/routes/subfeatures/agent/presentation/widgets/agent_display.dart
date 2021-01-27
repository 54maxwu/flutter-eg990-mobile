import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/types_grid_widget.dart';

import '../data/agent_view_type.dart';
import '../../data/enum/agent_level.dart';
import '../state/agent_store.dart';
import 'agent_display_bankcard.dart';
import 'agent_display_chart.dart';
import 'agent_display_commission.dart';
import 'agent_display_downlines.dart';
import 'agent_display_ledger.dart';
import 'agent_store_inherit_widget.dart';

class AgentDisplay extends StatefulWidget {
  @override
  _AgentDisplayState createState() => _AgentDisplayState();
}

class _AgentDisplayState extends State<AgentDisplay> {
  AgentStore _store;

  List<AgentViewTypeEnum> tabs;

  final int tabsPerRow = 3;
  final double expectTabHeight = 36.0;

  int _clicked = 0;
  double gridRatio;
  double tableMaxHeight;

  Widget _typeGrid;
  Widget _infoWidget;

  @override
  void initState() {
    _store = sl.get<AgentStore>();
    double gridItemWidth = (Global.device.width - 6 * 5 - 12) / 3;
    gridRatio = gridItemWidth / 36;
    print('grid item width: $gridItemWidth, gridRatio: $gridRatio');
    if (gridRatio > 4.16) gridRatio = 4.16;

    tableMaxHeight =
        Global.device.featureContentHeight - (gridItemWidth / gridRatio * 2);
    super.initState();
  }

  @override
  void didUpdateWidget(AgentDisplay oldWidget) {
    _infoWidget = null;
    _typeGrid = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _infoWidget ??= buildInfoWidget();
    _typeGrid ??= buildTypeGrid();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _infoWidget,
          _typeGrid,
          Expanded(
            child: AgentStoreInheritedWidget(
              store: _store,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: IndexedStack(
                  index: _clicked,
                  children: <Widget>[
                    AgentDisplayChart(),
                    AgentDisplayLedger(tableMaxHeight),
                    AgentDisplayCommission(tableMaxHeight),
                    if (tabs.length > 4)
                      AgentDisplayDownline(
                          availableHeight: tableMaxHeight,
                          agentLevel: _store.agent.level),
                    AgentDisplayBankcard(_store),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 12.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(6.0),
                    child: networkImageBuilder('images/footer/ftico_user.png',
                        imgColor: themeColor.memberIconColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text:
                          '${_store.agent.level.getAccountTitle}: ${_store.agent.account}',
                      style: TextStyle(
                        color: themeColor.defaultTextColor,
                        fontSize: FontSize.TITLE.value,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: RaisedButton(
              color: themeColor.buttonDisabledColor,
              child: Text(
                localeStr.memberGridTitleLogout,
                style: TextStyle(
                  fontSize: FontSize.NORMAL.value,
                  color: themeColor.buttonTextSubColor,
                ),
              ),
              visualDensity: VisualDensity(horizontal: -2.0, vertical: -2.0),
              onPressed: () async {
                await _store.logoutAgent();
                Future.delayed(Duration(milliseconds: 200),
                    () => RouterNavigate.navigateBack());
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTypeGrid() {
    AgentViewTypeEnum listTab;
    AgentViewTypeEnum cardTab;
    switch (_store.agent.level.value) {
      case 1:
        listTab = AgentViewTypeEnum.LIST_GRAND;
        break;
      case 2:
        listTab = AgentViewTypeEnum.LIST_MASTER;
        break;
      case 3:
        listTab = AgentViewTypeEnum.LIST_AGENT;
        break;
      case 4:
        listTab = AgentViewTypeEnum.LIST_MEMBER;
        break;
    }

    if (_store.bankcard.hasCard) {
      cardTab = AgentViewTypeEnum.VIEW_CARD;
    } else {
      cardTab = AgentViewTypeEnum.EDIT_CARD;
    }

    if (listTab != null) {
      tabs = [
        AgentViewTypeEnum.CHART,
        AgentViewTypeEnum.LEDGER,
        AgentViewTypeEnum.COMMISSION,
        listTab,
        cardTab,
      ];
    } else {
      tabs = [
        AgentViewTypeEnum.CHART,
        AgentViewTypeEnum.LEDGER,
        AgentViewTypeEnum.COMMISSION,
        cardTab,
      ];
    }

    return TypesGridWidget<AgentViewTypeEnum>(
      types: tabs,
      titleKey: 'label',
      onTypeGridTap: (_, type) {
        int index = tabs.indexOf(type);
        if (index != _clicked) {
          setState(() {
            _clicked = index;
          });
        }
      },
      tabsPerRow: tabsPerRow,
      expectTabHeight: expectTabHeight,
      itemSpace: 12.0,
      itemSpaceHorFactor: 0.5,
    );
  }
}
