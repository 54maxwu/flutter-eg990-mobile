import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/ext//table/table_cell_text_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/models/transaction_model.dart';

class TransactionDisplayTable extends StatefulWidget {
  TransactionDisplayTable(Key key) : super(key: key);

  @override
  TransactionDisplayTableState createState() => TransactionDisplayTableState();
}

class TransactionDisplayTableState extends State<TransactionDisplayTable> {
  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  List<TransactionData> _dataList;
  List<String> _headerRowTexts;
  TableRow _headerRow;

  set updateContent(List<TransactionData> list) {
    debugPrint('transaction list length: ${list.length}');
    if (_dataList != list) {
      _dataList = list;
      setState(() {});
    }
  }

  @override
  void initState() {
    double availableHeight = Global.device.featureContentHeight -
        ThemeInterface.fieldHeight -
        Global.device.comfortButtonHeight -
        48; // 96 = padding and pager
    int availableRows =
        (availableHeight / (FontSize.NORMAL.value * 2.35)).floor();
    debugPrint('max height: $availableHeight, available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 16;
    double remainWidth = _availableWidth - 84 - 90;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(36.0),
      1: FixedColumnWidth(90.0),
      2: FixedColumnWidth(48.0),
      3: FixedColumnWidth(remainWidth * 0.525),
      4: FixedColumnWidth(remainWidth * 0.475),
    };
    super.initState();
  }

  @override
  void didUpdateWidget(TransactionDisplayTable oldWidget) {
    _headerRow = null;
    _headerRowTexts = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_dataList == null) return SizedBox.shrink();
    if (_dataList.isEmpty) {
      return SizedBox(
        height: _tableHeight,
        child: Center(
          child: Text(localeStr.messageWarnNoHistoryData),
        ),
      );
    } else {
      _headerRowTexts ??= [
        localeStr.transactionHeaderSerial,
        localeStr.transactionHeaderDate,
        localeStr.transactionHeaderType,
        localeStr.transactionHeaderDesc,
        localeStr.transactionHeaderAmount,
      ];
      _headerRow ??= TableRow(
        decoration: BoxDecoration(color: themeColor.chartPrimaryHeaderColor),
        children: List.generate(
          _headerRowTexts.length,
          (index) =>
              TableCellTextWidget(text: _headerRowTexts[index], isHeader: true),
        ),
      );
      return Container(
        constraints: BoxConstraints(
          maxWidth: _availableWidth,
          maxHeight: _tableHeight,
        ),
        child: SingleChildScrollView(
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
                  List.generate(
                    _dataList.length,
                    (index) {
                      TransactionData data = _dataList[index];
                      String explanation = (data.type == '\u8f6c\u5165')
                          ? '${data.type} ${data.to}'
                          : '${data.from} ${data.type}';
                      List<dynamic> dataTexts = [
                        data.key,
                        data.date,
                        (data.type.hasChinese)
                            ? getTranslateData(data.type)
                            : getTranslateDataEn(data.type),
                        (data.type.hasChinese)
                            ? getTranslateData(data.type)
                            : getTranslateDataEn(explanation),
                        data.amount,
                      ];
                      /* generate cell text */
                      return TableRow(
                        children: List.generate(
                          dataTexts.length,
                          (index) =>
                              TableCellTextWidget(text: '${dataTexts[index]}'),
                        ),
                      );
                    },
                  ),
            ),
          ),
        ),
      );
    }
  }

  String getTranslateDataEn(String str) {
    // debugPrint('translating transaction: $str');
    return str
        .replaceAll('centerWallet', localeStr.walletViewTitle)
        .replaceAll('out', localeStr.balanceTransferOutText)
        .replaceAll('in', localeStr.balanceTransferInText);
  }

  String getTranslateData(String str) {
    // debugPrint('translating transaction: $str');
    return str
        .replaceAll('\u4e2d\u5fc3\u94b1\u5305', localeStr.walletViewTitle)
        .replaceAll('\u8f6c\u51fa', localeStr.balanceTransferOutText)
        .replaceAll('\u8f6c\u5165', localeStr.balanceTransferInText);
  }
}
