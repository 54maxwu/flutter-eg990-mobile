import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/ext//table/table_cell_text_widget.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../../data/models/rollback_model.dart';

class RollbackDisplayTable extends StatefulWidget {
  RollbackDisplayTable(Key key) : super(key: key);

  @override
  RollbackDisplayTableState createState() => RollbackDisplayTableState();
}

class RollbackDisplayTableState extends State<RollbackDisplayTable> {
  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  List<RollbackModel> _dataList;
  List<String> _headerRowTexts;
  TableRow _headerRow;
  List<String> _totalRowTexts;
  TableRow _totalRow;

  double totalAmount = 0;
  double totalTurnOver = 0;
  double totalRollOver = 0;
  double totalBetResult = 0;

  set updateContent(List<RollbackModel> list) {
    debugPrint('flow list length: ${list.length}');
    if (_dataList != list) {
      _dataList = list;
      if (_dataList.isNotEmpty) countTotal();
      setState(() {});
    }
  }

  void countTotal() {
    totalAmount = 0;
    totalTurnOver = 0;
    totalRollOver = 0;
    totalBetResult = 0;
    _dataList.forEach((data) {
      totalAmount += data.amount.strToDouble;
      totalTurnOver += data.turnOver.strToDouble;
      totalRollOver += data.rollOver.strToDouble;
      totalBetResult += data.betResult.strToDouble;
    });
    _totalRow = updateTotalRow();
  }

  TableRow updateTotalRow() {
    _totalRowTexts = [
      localeStr.flowHeaderTextTotal,
      '',
      '',
      formatValue(totalAmount, floorIfInt: true, creditSign: true),
      '',
      '',
      formatValue(totalTurnOver, floorIfInt: true, creditSign: true),
      formatValue(totalRollOver, floorIfInt: true, creditSign: true),
      formatValue(totalBetResult, floorIfInt: true, creditSign: true),
    ];
    return TableRow(
      children: List.generate(
        _totalRowTexts.length,
        (index) => TableCellTextWidget(text: _totalRowTexts[index]),
      ),
    );
  }

  @override
  void initState() {
    int availableRows = ((Global.device.featureContentHeight - 16) /
            (FontSize.NORMAL.value * 2.35))
        .floor();
    debugPrint('available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 16;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_availableWidth * 0.175),
      1: FixedColumnWidth(_availableWidth * 0.125),
      2: FixedColumnWidth(_availableWidth * 0.075),
      3: FixedColumnWidth(_availableWidth * 0.125),
      4: FixedColumnWidth(_availableWidth * 0.075),
      5: FixedColumnWidth(_availableWidth * 0.075),
      6: FixedColumnWidth(_availableWidth * 0.1),
      7: FixedColumnWidth(_availableWidth * 0.1),
      8: FixedColumnWidth(_availableWidth * 0.15),
    };
    super.initState();
  }

  @override
  void didUpdateWidget(RollbackDisplayTable oldWidget) {
    _headerRow = null;
    _headerRowTexts = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _headerRowTexts ??= [
      localeStr.flowHeaderTextTime,
      localeStr.flowHeaderTextCode,
      localeStr.flowHeaderTextType,
      localeStr.flowHeaderTextAmount,
      localeStr.flowHeaderTextMultiple,
      localeStr.flowHeaderTextPromo,
      localeStr.flowHeaderTextRequire,
      localeStr.flowHeaderTextCurrent,
      localeStr.flowHeaderTextNeed,
    ];
    _headerRow ??= TableRow(
      decoration: BoxDecoration(color: themeColor.chartHeaderBgColor),
      children: List.generate(
        _headerRowTexts.length,
        (index) =>
            TableCellTextWidget(text: _headerRowTexts[index], isHeader: true),
      ),
    );
    _totalRow ??= updateTotalRow();

    bool isEmptyTable = _dataList == null || _dataList.isEmpty;
    return Container(
      constraints: BoxConstraints(
        maxWidth: (isEmptyTable) ? _availableWidth : _availableWidth * 2,
        maxHeight: _tableHeight,
      ),
      child: (isEmptyTable) ? _buildEmptyTable() : _buildTable(),
    );
  }

  Widget _buildEmptyTable() {
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
          children: <TableRow>[_headerRow, _totalRow],
        ),
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
              List.generate(_dataList.length, (index) {
                RollbackModel data = _dataList[index];
                List<dynamic> dataTexts = [
                  "${data.startTime}\n｜\n${data.endTime}",
                  data.code,
                  data.index,
                  formatValue(data.amount, creditSign: true),
                  '${data.multiply}',
                  '${data.promoSimplified}',
                  formatValue(data.turnOver, creditSign: true),
                  formatValue(data.rollOver, creditSign: true),
                  formatValue(data.betResult, creditSign: true),
                ];
                /* generate cell text */
                return TableRow(
                  children: List.generate(
                    dataTexts.length,
                    (index) => TableCellTextWidget(text: '${dataTexts[index]}'),
                  ),
                );
              }) +
              <TableRow>[_totalRow],
        ),
      ),
    );
  }
}
