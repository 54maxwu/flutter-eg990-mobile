import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/pager_widget.dart';

import '../../data/form/store_exchange_history_form.dart';
import '../../data/models/store_exchange_model.dart';
import '../state/point_store.dart';
import 'point_store_inherit_widget.dart';
import 'store_display_record_table.dart';

class StoreDisplayRecord extends StatefulWidget {
  final double maxViewHeight;

  StoreDisplayRecord(this.maxViewHeight);

  @override
  _StoreDisplayRecordState createState() => _StoreDisplayRecordState();
}

class _StoreDisplayRecordState extends State<StoreDisplayRecord>
    with AfterLayoutMixin {
  final List<int> _showItemValues = [5, 10, 25, 50, 100];

  final GlobalKey<CustomizeDropdownWidgetState> _showItemKey =
      new GlobalKey(debugLabel: 'show');
  final GlobalKey<CustomizeFieldWidgetState> _searchFieldKey =
      new GlobalKey(debugLabel: 'search');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  PointStore _store;
  Widget _pointWidget;
  Widget _tableWidget;
  int _memberPoints;
  int _showItemSelected;

  StoreExchangeModel tableData;

  void getRecord({int page}) {
    _store.getRecord(
      form: StoreExchangeHistoryQuery(
        page: page ?? 1,
        perPage: _showItemSelected,
        search: _searchFieldKey.currentState.getInput,
      ),
    );
  }

  @override
  void initState() {
    _showItemSelected = _showItemValues[0];
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0),
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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    if (_memberPoints != snapshot.data ||
                        _pointWidget == null) {
                      _memberPoints = snapshot.data;
                      _pointWidget = Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 2.0),
                        child: Text(
                          '$_memberPoints',
                          style: TextStyle(
                              color: Themes.hintHighlightOrangeStrong),
                        ),
                      );
                    }
                    return _pointWidget;
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localeStr.storeRecordSpinnerTitle1),
              Container(
                width: 72,
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomizeDropdownWidget(
                  key: _showItemKey,
                  optionValues: _showItemValues,
                  optionStrings: _showItemValues.map((e) => '$e').toList(),
                  changeNotify: (data) {
                    // clear text field focus
                    FocusScope.of(context).requestFocus(new FocusNode());
                    // set selected data
                    _showItemSelected = data;
                  },
                  minusHeight: 16.0,
                  whiteBox: true,
                  scaleText: true,
                ),
              ),
              Text(localeStr.storeRecordSpinnerTitle2),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Global.device.width / 3,
                child: new CustomizeFieldWidget(
                  key: _searchFieldKey,
                  hint: localeStr.storeRecordFieldHint,
                  persistHint: false,
                  minusHeight: 16.0,
                  whiteField: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: RaisedButton(
                  visualDensity: VisualDensity.compact,
                  color: Colors.black87,
                  child: Text(
                    localeStr.storeRecordButtonTitle,
                    style: TextStyle(color: Themes.defaultTextColorWhite),
                  ),
                  onPressed: () => getRecord(),
                ),
              ),
            ],
          ),
          StreamBuilder<StoreExchangeModel>(
            stream: _store.recordStream,
            builder: (_, snapshot) {
              if (snapshot != null && tableData != snapshot.data) {
                tableData = snapshot.data;
                pagerKey.currentState.currentPage = tableData.currentPage;
                pagerKey.currentState.updateTotalPage = tableData.lastPage;
                _tableWidget = _buildTable();
              }
              _tableWidget ??= _buildTable();
              return _tableWidget;
            },
          )
        ],
      ),
    );
  }

  Widget _buildTable() {
    bool hasData = tableData != null &&
        tableData.data != null &&
        tableData.data.isNotEmpty;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: StoreDisplayRecordTable(tableData: tableData),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(localeStr.storeRecordTableDetailItem(
            tableData?.from ?? '',
            tableData?.to ?? '',
            tableData?.total ?? '',
          )),
        ),
        Padding(
          padding:
              (hasData) ? const EdgeInsets.only(top: 8.0) : EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              PagerWidget(
                pagerKey,
                onAction: (page) => getRecord(page: page),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (tableData == null) _store.getRecord();
  }
}
