import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/table_cell_text_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart' as HtmlStyle;

import '../state/point_store.dart';
import 'point_store_inherit_widget.dart';

class StoreDisplayRules extends StatefulWidget {
  final double maxViewHeight;

  StoreDisplayRules(this.maxViewHeight);

  @override
  _StoreDisplayRulesState createState() => _StoreDisplayRulesState();
}

class _StoreDisplayRulesState extends State<StoreDisplayRules> {
  final String htmlBgColor = Themes.defaultBackgroundColor.toHexNoAlpha();
  final String htmlTextColor = Themes.dialogTextColor.toHexNoAlpha();

  PointStore _store;
  Widget pointWidget;
  int memberPoints;

  Map<int, TableColumnWidth> _tableWidthMap;
  double _tableCellWidth;
  double _tableHeight;
  BorderSide _tableBorder;
  List<String> _headerRowTexts;
  TableRow _headerRow;
  String _htmlContent;

  void updateContent() {
    _tableCellWidth = (1.0 / _store.rulesModel.platformRules.length)
        .toStringAsFixed(3)
        .strToDouble;
    print('table cell width: $_tableCellWidth');

    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_tableCellWidth),
      1: FixedColumnWidth(_tableCellWidth),
      2: FixedColumnWidth(_tableCellWidth),
      3: FixedColumnWidth(_tableCellWidth),
      4: FixedColumnWidth(_tableCellWidth),
      5: FixedColumnWidth(_tableCellWidth),
    };

    _headerRowTexts = List.generate(
      6,
      (index) => '${localeStr.storeRuleTableTitle(
        '\n${_store.rulesModel.platformRules[index].platform}',
      )}',
    );
    _headerRow = TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(text: _headerRowTexts[index]),
      ),
    );
    _htmlContent = _buildHtmlText();
  }

  @override
  void initState() {
    _tableHeight = FontSize.NORMAL.value * 1.8 * 3.5;
    _tableBorder = BorderSide(
      color: Themes.chartBorderColor,
      width: 1.0,
      style: BorderStyle.solid,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= PointStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.STORE)).message,
        ),
      );
    }

    if (_store.rulesModel == null)
      return WarningDisplay(
        message: localeStr.messageErrorServerData,
      );

    if (_htmlContent == null) updateContent();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      constraints: BoxConstraints.tight(
        Size(
          Global.device.width - 24,
          widget.maxViewHeight,
        ),
      ),
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  localeStr.storeTextTitlePoint,
                  style: TextStyle(color: Themes.defaultHintColor),
                ),
                StreamBuilder<num>(
                  stream: _store.pointStream,
                  initialData: _store.memberPoints,
                  builder: (_, snapshot) {
                    print('store point stream: ${snapshot?.data}');
                    if (snapshot == null || snapshot.data == null)
                      return SizedBox.shrink();
                    if (memberPoints != snapshot.data || pointWidget == null) {
                      memberPoints = snapshot.data;
                      pointWidget = Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 2.0),
                        child: Text(
                          '$memberPoints',
                          style:
                              TextStyle(color: Themes.storeHighlightTextColor),
                        ),
                      );
                    }
                    return pointWidget;
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 0.0),
            constraints:
                BoxConstraints.tightFor(width: Global.device.width - 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Themes.defaultAccentColor,
                    border: Border(
                      left: _tableBorder,
                      right: _tableBorder,
                      top: _tableBorder,
                    ),
                  ),
                  child: Center(
                      child: Text(
                    localeStr.storeRuleTableHeader,
                    style: TextStyle(
                      color: Themes.buttonTextPrimaryColor,
                    ),
                  )),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: _tableHeight),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: _tableWidthMap,
                    border: TableBorder.all(
                      color: Themes.chartBorderColor,
                      width: 1.0,
                      style: BorderStyle.solid,
                    ),
                    /* create table header and generate rows */
                    children: <TableRow>[
                      _headerRow,
                      TableRow(
                        children: List.generate(
                          6,
                          (index) => TableCellTextWidget(
                              text:
                                  '${_store.rulesModel.platformRules[index].dollar}'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 2.0),
            child: Html(
              data: """$_htmlContent""",
              style: {
                "span": HtmlStyle.Style(
                  fontSize: HtmlStyle.FontSize.large,
                  color: Themes.defaultAccentColor,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  String _buildHtmlText() {
    return '<html>'
        '<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"></head>'
        '<body bgcolor="$htmlBgColor" text="$htmlTextColor" style="line-height:1.2;">'
        '${_store.rulesModel.rules[0].content}'
        '</html>';
  }
}
