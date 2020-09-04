import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/pager_widget.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';

import '../../data/enum/bet_record_time_enum.dart';
import '../../data/form/bet_record_form.dart';
import '../../data/models/bet_record_model.dart';
import '../../data/models/bet_record_type_model.dart';
import '../state/bet_record_store.dart';
import 'bet_record_display_table.dart';

class BetRecordDisplay extends StatefulWidget {
  final BetRecordStore store;

  BetRecordDisplay({@required this.store});

  @override
  _BetRecordDisplayState createState() => _BetRecordDisplayState();
}

class _BetRecordDisplayState extends State<BetRecordDisplay>
    with AfterLayoutMixin {
  final GlobalKey _streamKey = new GlobalKey(debugLabel: 'betstream');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  final GlobalKey<CustomizeDropdownWidgetState> _platformKey =
      new GlobalKey(debugLabel: 'platform');
  final GlobalKey<CustomizeDropdownWidgetState> _timeKey =
      new GlobalKey(debugLabel: 'time');
  final GlobalKey<CustomizeFieldWidgetState> _startTimeKey =
      new GlobalKey(debugLabel: 'start');
  final GlobalKey<CustomizeFieldWidgetState> _endTimeKey =
      new GlobalKey(debugLabel: 'end');

  double gridRatio;
  List<String> categories;
  List<String> platforms;

  /// current tab
  String _category;

  /// current tab index, controls tab color
  int _categorySelected;

  /// platform drop down widget's current value
  String _platform;

  /// platform drop down widget's init value
  int _allPlatformIndex;

  /// time drop down widget's current value
  BetRecordTimeEnum _timeSelected;

  /// pager's current total page, update pager if not match
  int totalPage;

  /// current table's page, update pager if not match
  int tablePage;

  /// widget as variable, rebuild when data change
  Widget tableWidget;

  /// current [tableWidget]'s data
  dynamic currentTableData;

  /// true after first layout has finished,
  /// global widget state should be initialized
  bool layoutReady = false;

  /// table type, has effect on table and pager's height
  bool allDataTable = true;

  void getPageData(int page, bool force) {
    if (widget.store == null) return;
    if (widget.store.waitForRecordResponse) return;
    if (tablePage == page && !force) return;
    if (_timeSelected == BetRecordTimeEnum.custom &&
        !checkDateRange(_startTimeKey.currentState.getInput,
            _endTimeKey.currentState.getInput)) {
      Future.delayed(Duration(milliseconds: 200)).then(
        (value) => callToastError(localeStr.betsFieldDateError),
      );
      return;
    }
    BetRecordForm form = BetRecordForm(
      categoryId: widget.store.typeList
          .singleWhere((type) => type.label == _category)
          .categoryId,
      platform: (_platform == platforms[_allPlatformIndex])
          ? 'all'
          : _platform.toLowerCase(),
      time: _timeSelected,
      page: page,
      startTime: (_timeSelected == BetRecordTimeEnum.custom)
          ? _startTimeKey.currentState.getInput
          : null,
      endTime: (_timeSelected == BetRecordTimeEnum.custom)
          ? _endTimeKey.currentState.getInput
          : null,
    );
    print('bet query form: $form');
    widget.store.getRecord(form);
  }

  /// update drop down values when tab change
  void switchCategory(int categoryIndex) {
    if (_categorySelected == categoryIndex) return;
    // set selected category
    _categorySelected = categoryIndex;
    _category = categories[_categorySelected];

    // reset platform drop down
    _platform = null;
    _allPlatformIndex = null;
    if (_platformKey.currentState != null)
      _platformKey.currentState.setSelected = _platform;

    // build platform list
    Map platformMap = widget.store.typeList
        .singleWhere((element) => element.label == _category)
        .platformMap;
    platforms = (platformMap != null && platformMap.isNotEmpty)
        ? platformMap.values.map((value) => '$value').toList()
        : [];

    // set platform to ALL
    if (platforms.isNotEmpty && platforms.contains('ALL')) {
      var allIndex = platforms.indexOf('ALL');
      platforms.removeAt(allIndex);
      platforms.insert(allIndex, localeStr.betsSpinnerOptionAllPlatform);
      _platform = platforms[allIndex];
      _allPlatformIndex = allIndex;
      print('$_category platforms: ${platforms.length}');
//      print('$_category platform: $platforms');
      print('reset selected platform: $_platform, index: $_allPlatformIndex');
    }

    // update drop down value after view had rebuild
    if (platforms.isNotEmpty && _platformKey.currentState != null)
      Future.delayed(Duration(milliseconds: 100), () {
        _platformKey.currentState.setSelected = _platform;
      });

    // update view
    setState(() {});
  }

  /// update table and pager height when table type changes
  void checkTableHeight() {
    if (_platform == platforms[_allPlatformIndex] && !allDataTable) {
      allDataTable = true;
      Future.delayed(Duration(milliseconds: 100), () {
        print('update state');
        setState(() {});
      });
    } else if (_platform != platforms[_allPlatformIndex] &&
        allDataTable != false) {
      allDataTable = false;
      Future.delayed(Duration(milliseconds: 100), () {
        print('update state');
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    if (widget.store != null) {
      categories = (widget.store.hasValidData)
          ? widget.store.typeList.map((e) => e.label).toList()
          : [];
      if (categories.isNotEmpty) {
        switchCategory(0);
        print('bet categories: ${categories.length}');
      }
    }
    _timeSelected = BetRecordTimeEnum.today;

    double gridItemWidth = (Global.device.width - 8 * 6 - 12) / 4;
    gridRatio = gridItemWidth / 36;
    print('grid item width: $gridItemWidth, gridRatio: $gridRatio');
    if (gridRatio > 4.16) gridRatio = 4.16;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store == null || categories == null || categories.isEmpty) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    tableWidget ??= _buildTableWidget([]);
    return Container(
      padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 4.0),
      alignment: Alignment.topCenter,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /* Category Tabs */
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: gridRatio,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 24),
                child: RaisedButton(
                  color: (_categorySelected == index)
                      ? Themes.buttonPrimaryColor
                      : Themes.buttonSecondaryColor,
                  textColor: (_categorySelected == index)
                      ? Themes.buttonTextPrimaryColor
                      : Themes.defaultTextColor,
                  child: Text(categories[index]),
                  onPressed: () => switchCategory(index),
                ),
              );
            },
          ),
          SizedBox(height: 12.0),
          /* Platform Option */
          if (platforms != null && platforms.isNotEmpty)
            CustomizeDropdownWidget(
              key: _platformKey,
              horizontalInset: 12.0,
              prefixText: localeStr.betsSpinnerTitlePlatform,
              titleLetterSpacing: 4,
              optionValues: platforms,
              defaultValueIndex: _allPlatformIndex,
              changeNotify: (data) {
                // clear text field focus
                FocusScope.of(context).unfocus();
                // set selected data
                _platform = data;
              },
            ),
          /* Time Option */
          CustomizeDropdownWidget(
            key: _timeKey,
            horizontalInset: 12.0,
            prefixText: localeStr.betsSpinnerTitleTime,
            titleLetterSpacing: 4,
            optionValues: BetRecordTimeEnum.list,
            optionStrings: BetRecordTimeEnum.list.map((e) => e.label).toList(),
            changeNotify: (data) {
              // clear text field focus
              FocusScope.of(context).unfocus();
              // set selected data
              _timeSelected = data;
            },
          ),
          if (_timeSelected == BetRecordTimeEnum.custom)
            /* Start Date Field */
            //TODO add calender chooser as postfix
            new CustomizeFieldWidget(
              key: _startTimeKey,
              horizontalInset: 12.0,
              fieldType: FieldType.Date,
              maxInputLength: 10,
              hint: localeStr.centerTextTitleDateHint,
              persistHint: false,
              prefixText: localeStr.betsFieldTitleStartTime,
              titleLetterSpacing: 4,
            ),
          if (_timeSelected == BetRecordTimeEnum.custom)
            /* End Date Field */
            //TODO add calender chooser as postfix
            new CustomizeFieldWidget(
              key: _endTimeKey,
              horizontalInset: 12.0,
              fieldType: FieldType.Date,
              maxInputLength: 10,
              hint: localeStr.centerTextTitleDateHint,
              persistHint: false,
              prefixText: localeStr.betsFieldTitleEndTime,
              titleLetterSpacing: 4,
            ),
          /* Query Button */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: Global.device.comfortButtonHeight,
                    child: RaisedButton(
                      child: Text(localeStr.btnQueryNow),
                      onPressed: () => getPageData(1, true),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 8.0),
            child: StreamBuilder(
              key: _streamKey,
              stream: widget.store.dataStream,
              builder: (_, snapshot) {
//                print(snapshot.data);
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot.data != currentTableData) {
                  print('building table, type: ${snapshot.data.runtimeType}');
                  currentTableData = snapshot.data;
                  if (snapshot.data == null) {
                    tableWidget = _buildTableWidget([]);
                  } else if (snapshot.data is List) {
                    totalPage = 0;
                    tablePage = 0;
                    print('update list table, reset pager widget');
                    if (layoutReady && pagerKey.currentState != null) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        pagerKey.currentState.updateTotalPage = 0;
                      });
                    }
                    checkTableHeight();
                    tableWidget = _buildTableWidget(snapshot.data);
                  } else if (snapshot.data is BetRecordModel) {
                    totalPage = snapshot.data.lastPage;
                    tablePage = snapshot.data.currentPage;
                    print('update model table, page: $tablePage/$totalPage');
                    if (layoutReady && pagerKey.currentState != null) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        pagerKey.currentState.updateTotalPage = totalPage;
                        pagerKey.currentState.updateCurrentPage =
                            snapshot.data.currentPage;
                      });
                    }
                    checkTableHeight();
                    tableWidget = _buildTableWidget(snapshot.data.data);
                  }
                }
                return tableWidget;
              },
            ),
          ),
          SizedBox(
            height: (allDataTable) ? 1 : 34,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PagerWidget(
                  pagerKey,
                  onAction: (page) => getPageData(page, false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableWidget(List list) {
    return BetRecordDisplayTable(
      dataList: list,
      isAllData: allDataTable,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    layoutReady = true;
  }
}
