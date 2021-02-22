import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/general/ext/table/table_cell_text_widget.dart';

import '../../data/models/roller_record_model.dart';

class RollerDisplayRecord extends StatefulWidget {
  final List<RollerRecordModel> initRecord;
  final Stream recordStream;

  RollerDisplayRecord({
    @required this.recordStream,
    this.initRecord,
  });

  @override
  _RollerDisplayRecordState createState() => _RollerDisplayRecordState();
}

class _RollerDisplayRecordState extends State<RollerDisplayRecord> {
  final double dialogHeightFactor = 0.75;
  final double dialogTitleHeight = 54.0;

  final List<String> _headerRowTexts = [
    localeStr.wheelRecordTableTextTime,
    localeStr.wheelRecordTableTextOperate,
    localeStr.wheelRecordTableTextCount,
    localeStr.wheelRecordTableTextContent,
  ];

  ScrollController _scrollController;
  Widget contentWidget;
  List<RollerRecordModel> currentData;

  double tableMinHeight;
  double tableWidth;
  Map<int, TableColumnWidth> _tableWidthMap;
  BorderSide tableBorder;

  @override
  void initState() {
    double availableWidth = Global.device.width - 32;
    // double availableHeight =
    //     Global.device.height * dialogHeightFactor - dialogTitleHeight;

    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    tableMinHeight = FontSize.NORMAL.value * 2.15 * 2;
    tableWidth = availableWidth - 16;
    _tableWidthMap ??= {
      //指定索引及固定列宽
      0: FixedColumnWidth(tableWidth * 0.4),
      1: FixedColumnWidth(tableWidth * 0.2),
      2: FixedColumnWidth(tableWidth * 0.2),
      3: FixedColumnWidth(tableWidth * 0.2),
    };

    tableBorder ??= BorderSide(
      color: HexColor.fromHex('#d2080e'),
      width: 1.0,
      style: BorderStyle.solid,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      heightFactor: dialogHeightFactor,
      customBg: HexColor.fromHex('#de4d41'),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: dialogTitleHeight,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#d2080e'),
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(16.0),
                        topRight: const Radius.circular(16.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      localeStr.wheelTextTitleRecord,
                      style: TextStyle(
                        color: themeColor.defaultAccentColor,
                        fontSize: FontSize.TITLE.value,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<List<RollerRecordModel>>(
                  stream: widget.recordStream,
                  initialData: widget.initRecord,
                  builder: (context, snapshot) {
                    if (snapshot != null && currentData != snapshot.data) {
                      currentData = snapshot.data;
                      contentWidget = _buildTable();
                    }
                    contentWidget ??= Center(
                      child: CircularProgressIndicator(),
                    );
                    return contentWidget;
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTable() {
    _scrollController = new ScrollController();
    return Container(
      constraints: BoxConstraints(
        maxWidth: tableWidth,
        minHeight: tableMinHeight,
        // maxHeight: tableHeight,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: _tableWidthMap,
            border: TableBorder(
              horizontalInside: tableBorder,
              bottom: tableBorder,
            ),
            /* create table header and generate rows */
            children: _buildContent(),
          ),
        ),
      ),
    );
  }

  List<TableRow> _buildContent() {
    List<TableRow> rows = new List();
    if (currentData != null && currentData.length > 0) {
      rows.addAll(_buildContentRows());
      rows.insert(0, _buildHeaderRow());
    } else {
      rows.add(_buildHeaderRow());
    }
    return rows;
  }

  List<TableRow> _buildContentRows() {
    return List.generate(currentData.length, (index) {
      RollerRecordModel data = currentData[index];
      List<dynamic> dataTexts = [
        data.date,
        data.methodCh,
        data.count,
        data.name,
      ];
      /* generate cell text */
      return TableRow(
        decoration: BoxDecoration(color: themeColor.chartBgColor),
        children: List.generate(
          dataTexts.length,
          (index) => TableCellTextWidget(
            text: '${dataTexts[index]}',
            textColor: themeColor.hintHighlightOrangeStrong,
          ),
        ),
      );
    });
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(
          text: _headerRowTexts[index],
        ),
      ),
    );
  }
}
