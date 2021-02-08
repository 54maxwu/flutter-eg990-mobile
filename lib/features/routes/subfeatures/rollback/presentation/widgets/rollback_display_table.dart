import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/ext/table/table_cell_text_widget.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../../data/models/rollback_model.dart';

class RollbackDisplayTable extends StatefulWidget {
  RollbackDisplayTable(Key key) : super(key: key);

  @override
  RollbackDisplayTableState createState() => RollbackDisplayTableState();
}

class RollbackDisplayTableState extends State<RollbackDisplayTable> {
  double _availableWidth;
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
      localeStr.rollbackHeaderTextTotal,
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
    _availableWidth = Global.device.width - 16;
    double remainWidth = _availableWidth * 1.5 - 96 - 48 - 64 - 36;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(96),
      1: FixedColumnWidth(48),
      2: FixedColumnWidth(64),
      3: FixedColumnWidth(remainWidth * 0.15),
      4: FixedColumnWidth(36),
      5: FixedColumnWidth(remainWidth * 0.25),
      6: FixedColumnWidth(remainWidth * 0.2),
      7: FixedColumnWidth(remainWidth * 0.2),
      8: FixedColumnWidth(remainWidth * 0.2),
    };
    super.initState();
  }

  @override
  void didUpdateWidget(RollbackDisplayTable oldWidget) {
    _headerRow = null;
    _headerRowTexts = null;
    _totalRow = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _headerRowTexts ??= [
      localeStr.rollbackHeaderTextTime,
      localeStr.rollbackHeaderTextCode,
      localeStr.rollbackHeaderTextType,
      localeStr.rollbackHeaderTextAmount,
      localeStr.rollbackHeaderTextMultiple,
      localeStr.rollbackHeaderTextPromo,
      localeStr.rollbackHeaderTextRequire,
      localeStr.rollbackHeaderTextCurrent,
      localeStr.rollbackHeaderTextNeed,
    ];
    _headerRow ??= TableRow(
      decoration: BoxDecoration(color: themeColor.chartPrimaryHeaderColor),
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
        maxHeight: Global.device.featureContentHeight - 16,
      ),
      child: (isEmptyTable) ? _buildEmptyTable() : _buildTable(),
    );
  }

  Widget _buildEmptyTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
                    "${data.startTime} ~ ${data.endTime}",
                    data.code ?? data.key,
                    getStatusIndex(data.index),
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
                      (index) =>
                          TableCellTextWidget(text: '${dataTexts[index]}'),
                    ),
                  );
                }) +
                <TableRow>[_totalRow],
          ),
        ),
      ),
    );
  }

  String getStatusIndex(String state) {
    switch (state.toLowerCase()) {
      case 'webbank':
        return localeStr.memberGridTitleTransfer;
      case '存款':
      case 'deposit':
        return localeStr.rollbackIndexDeposit;
      case '优惠':
      case 'promo':
        return localeStr.rollbackIndexPromo;
      case 'adjustdeposit':
        return localeStr.dealsDetailTypeAdjustDeposit;
      case 'adjustwithdraw':
        return localeStr.dealsDetailTypeAdjustWithdraw;
      case 'cashadjustment':
        return localeStr.dealsDetailTypeAdjustCash;
      case '退水':
      case 'rollback':
        return localeStr.rollbackIndexRollback;
      default:
        return state;
    }
  }
}
