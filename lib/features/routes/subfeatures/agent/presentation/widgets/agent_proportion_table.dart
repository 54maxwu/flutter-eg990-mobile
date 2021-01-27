import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/ext/table/table_cell_text_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/agent/data/form/agent_proportion_form.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

typedef ChangeAgentProportion = Function(AgentProportionForm form);

class AgentProportionTable extends StatefulWidget {
  final double availableHeight;
  final ChangeAgentProportion onSubmit;

  AgentProportionTable(this.availableHeight, this.onSubmit);

  @override
  _AgentProportionTableState createState() => _AgentProportionTableState();
}

class _AgentProportionTableState extends State<AgentProportionTable>
    with AfterLayoutMixin {
  final GlobalKey<CustomizeFieldWidgetState> _cardFieldKey =
      new GlobalKey(debugLabel: 'card');
  final GlobalKey<CustomizeFieldWidgetState> _casinoFieldKey =
      new GlobalKey(debugLabel: 'casino');
  final GlobalKey<CustomizeFieldWidgetState> _fishFieldKey =
      new GlobalKey(debugLabel: 'fish');
  final GlobalKey<CustomizeFieldWidgetState> _lotteryFieldKey =
      new GlobalKey(debugLabel: 'lottery');
  final GlobalKey<CustomizeFieldWidgetState> _slotFieldKey =
      new GlobalKey(debugLabel: 'slot');
  final GlobalKey<CustomizeFieldWidgetState> _sportFieldKey =
      new GlobalKey(debugLabel: 'sport');
  final GlobalKey<CustomizeFieldWidgetState> _feeFieldKey =
      new GlobalKey(debugLabel: 'fee');

  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  Widget tableWidget;
  bool tableHasNoData = true;

  List<String> _headerRowTexts;
  List<String> _contentRowTexts;
  List<GlobalKey> _fieldKeys;
  TableRow _headerRow;

  bool _showFormatError = false;

  @override
  void initState() {
    int availableRows =
        ((widget.availableHeight - 20) / (FontSize.NORMAL.value * 2.35))
            .floor();
    debugPrint('max height: ${widget.availableHeight}, '
        'available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 48;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_availableWidth * 0.35),
      1: FixedColumnWidth(_availableWidth * 0.65),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _headerRowTexts ??= [
      localeStr.agentDownlineHeaderCategory,
      localeStr.agentDownlineHeaderProportion,
    ];

    _contentRowTexts ??= [
      localeStr.gameCategoryCard,
      localeStr.gameCategoryCasino,
      localeStr.gameCategoryFish,
      localeStr.gameCategoryLottery,
      localeStr.gameCategorySlot,
      localeStr.gameCategorySport,
      localeStr.agentDownlineHeaderFee,
    ];

    _fieldKeys ??= [
      _cardFieldKey,
      _casinoFieldKey,
      _fishFieldKey,
      _lotteryFieldKey,
      _slotFieldKey,
      _sportFieldKey,
      _feeFieldKey,
    ];

    _headerRow ??= TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(
          text: _headerRowTexts[index],
          shrinkInset: false,
        ),
      ),
    );

    tableWidget ??= _buildTable();
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
      constraints: BoxConstraints(
        maxWidth: _availableWidth,
        maxHeight: _tableHeight,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          tableWidget,
          Visibility(
            visible: _showFormatError,
            child: Text(
              localeStr.messageInvalidFormat,
              style: TextStyle(color: themeColor.defaultErrorColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: RaisedButton(
              child: Text(localeStr.btnSubmit),
              onPressed: () async {
                widget.onSubmit(AgentProportionForm(
                  cardConfig: _cardFieldKey.currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  casinoConfig: _casinoFieldKey
                          .currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  fishConfig: _fishFieldKey.currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  lotteryConfig: _lotteryFieldKey
                          .currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  slotConfig: _slotFieldKey.currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  sportConfig: _sportFieldKey
                          .currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                  administrativeFee: _feeFieldKey
                          .currentState?.getInput?.strToDouble
                          ?.toString() ??
                      0.00,
                ));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTable() {
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
              List.generate(_contentRowTexts.length, (index) {
                /* generate cell text */
                return TableRow(
                  children: List.generate(_headerRowTexts.length, (colIndex) {
                    if (colIndex == 1) {
                      return new CustomizeFieldWidget(
                        key: _fieldKeys[index],
                        hint: '',
                        persistHint: false,
                        roundCorner: false,
                        onInputChanged: (input) {
                          double percentage = input.strToDouble;
                          if (percentage > 0 &&
                              percentage < 0.01 &&
                              !_showFormatError) {
                            setState(() {
                              _showFormatError = true;
                            });
                          } else if ((percentage < 0 || percentage > 1) &&
                              !_showFormatError) {
                            setState(() {
                              _showFormatError = true;
                            });
                          } else if (_showFormatError) {
                            setState(() {
                              _showFormatError = false;
                            });
                          }
                        },
                      );
                    } else {
                      return TableCellTextWidget(
                        text: '${_contentRowTexts[index]}',
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

  @override
  void afterFirstLayout(BuildContext context) {
    _cardFieldKey.currentState?.setInput = '0.00';
    _casinoFieldKey.currentState?.setInput = '0.00';
    _fishFieldKey.currentState?.setInput = '0.00';
    _lotteryFieldKey.currentState?.setInput = '0.00';
    _slotFieldKey.currentState?.setInput = '0.00';
    _sportFieldKey.currentState?.setInput = '0.00';
    _feeFieldKey.currentState?.setInput = '0.00';
  }
}
