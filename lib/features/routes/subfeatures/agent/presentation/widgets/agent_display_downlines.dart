import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/ext/table/table_cell_text_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';

import '../../data/enum/agent_level.dart';
import '../../data/models/downline_agent_model.dart';
import '../state/agent_store.dart';
import 'agent_dialog_downline_add.dart';
import 'agent_dialog_downline_detail.dart';
import 'agent_dialog_downline_porpotion.dart';

class AgentDisplayDownline extends StatefulWidget {
  final double availableHeight;
  final AgentLevel agentLevel;

  AgentDisplayDownline({this.availableHeight, this.agentLevel});

  @override
  _AgentDisplayDownlineState createState() => _AgentDisplayDownlineState();
}

class _AgentDisplayDownlineState extends State<AgentDisplayDownline> {
  static final Key _streamKey = new Key('downstream');

  final GlobalKey<DialogWidgetState> _proportionDialogKey =
      new GlobalKey(debugLabel: 'dialog');

  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  AgentStore _store;
  List<DownlineAgentModel> _dataList;
  Widget _tableWidget;
  bool tableHasNoData = true;

  List<String> _headerRowTexts;
  TableRow _headerRow;

  String _proportionHeader;
  String _downlineHint;

  @override
  void initState() {
    int availableRows =
        ((widget.availableHeight - 20) / (FontSize.NORMAL.value * 2.35))
            .floor();
    debugPrint('max height: ${widget.availableHeight}, '
        'available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 24;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_availableWidth * 0.2),
      1: FixedColumnWidth(_availableWidth * 0.15),
      2: FixedColumnWidth(_availableWidth * 0.45),
      3: FixedColumnWidth(_availableWidth * 0.2),
    };
    super.initState();
  }

  @override
  void didUpdateWidget(AgentDisplayDownline oldWidget) {
    _headerRow = null;
    _tableWidget = null;
    _headerRowTexts = null;
    _downlineHint = null;
    _proportionHeader = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _store ??= sl.get<AgentStore>();
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }

    if (_dataList == null && _store != null) {
      _store.getDownlines();
    }

    _downlineHint ??= widget.agentLevel.getDownlineAddHint;
    _proportionHeader ??= widget.agentLevel.getDownlineTableProportionHeader;

    _headerRowTexts ??= [
      localeStr.agentDownlineHeaderAccount,
      localeStr.agentDownlineHeaderStatus,
      _proportionHeader,
      localeStr.agentDownlineHeaderMore,
    ];

    _headerRow ??= TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(
            text: _headerRowTexts[index], shrinkInset: false),
      ),
    );

    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 4.0),
      constraints: BoxConstraints(
        maxWidth: _availableWidth,
        maxHeight: _tableHeight,
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AgentDialogDownlineAdd(
                    onSubmit: (form) => _store.postDownline(form),
                    onRefresh: () => _store.getDownlines(),
                  ),
                ),
                child: Text(localeStr.agentDownlineButtonAdd),
                visualDensity: VisualDensity(horizontal: 2.0),
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.start,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: _downlineHint,
                    style: TextStyle(
                      color: themeColor.hintHyperLink,
                      fontSize: FontSize.SMALLER.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<List<DownlineAgentModel>>(
            key: _streamKey,
            stream: _store.downlinesStream,
            builder: (context, snapshot) {
              if (_dataList != snapshot.data) {
                _dataList = snapshot.data;
                debugPrint('agent downlines length: ${_dataList.length}');
                if ((_dataList == null || _dataList.isEmpty) &&
                    tableHasNoData) {
                  // skip rebuild
                } else {
                  _tableWidget = _buildTable();
                }
              }
              _tableWidget ??= _buildTable();
              return _tableWidget;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    tableHasNoData = _dataList == null || _dataList.isEmpty;
    if (tableHasNoData) {
      /// No Data UI
      return SingleChildScrollView(
        child: ColoredBox(
          color: themeColor.chartBgColor,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: _tableWidthMap,
            border: TableBorder.all(
              color: themeColor.chartBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            /* create table header and generate rows */
            children: <TableRow>[_headerRow],
          ),
        ),
      );
    } else {
      /// Normal UI
      return SingleChildScrollView(
        child: ColoredBox(
          color: themeColor.chartBgColor,
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: _tableWidthMap,
            border: TableBorder.all(
              color: themeColor.chartBorderColor,
              width: 2.0,
              style: BorderStyle.solid,
            ),
            /* create table header and generate rows */
            children: <TableRow>[_headerRow] +
                List.generate(_dataList.length, (index) {
                  DownlineAgentModel data = _dataList[index];
                  List<dynamic> dataTexts = [
                    data.account,
                    data.status,
                    '',
                    '',
                  ];
                  /* generate cell text */
                  return TableRow(
                    children: List.generate(dataTexts.length, (index) {
                      if (index == 2) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                              child:
                                  Text(localeStr.agentDownlineButtonProportion),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) =>
                                      AgentDialogDownlineProportion(
                                          dialogKey: _proportionDialogKey,
                                          data: data,
                                          onSubmit: (form) async {
                                            bool success = await _store
                                                .editProportion(form);
                                            if (success) {
                                              _proportionDialogKey.currentState
                                                  ?.closeDialog();
                                              callToast(
                                                  localeStr.messageSuccess);
                                            } else {
                                              callToast(
                                                  localeStr.messageFailed);
                                            }
                                          }),
                                );
                              }),
                        );
                      } else if (index == 3) {
                        return Container(
                          margin:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 8.0),
                          child: RaisedButton(
                            child: Text(localeStr.agentDownlineHeaderMore),
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    AgentDialogDownlineDetail(data),
                              );
                            },
                          ),
                        );
                      } else {
                        return TableCellTextWidget(
                          text: '${dataTexts[index]}',
                          shrinkInset: false,
                        );
                      }
                    }),
                  );
                }),
          ),
        ),
      );
    }
  }
}
