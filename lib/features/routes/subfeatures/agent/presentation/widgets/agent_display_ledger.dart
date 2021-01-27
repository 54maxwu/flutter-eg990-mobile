import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/checkbox_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/pager_widget.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/form/agent_ledger_form.dart';
import '../../data/models/agent_ledger_model.dart';
import '../state/agent_store.dart';
import 'agent_display_ledger_table.dart';
import 'agent_store_inherit_widget.dart';

class AgentDisplayLedger extends StatefulWidget {
  final double availableHeight;

  AgentDisplayLedger(this.availableHeight);

  @override
  _AgentDisplayLedgerState createState() => _AgentDisplayLedgerState();
}

class _AgentDisplayLedgerState extends State<AgentDisplayLedger>
    with AfterLayoutMixin {
  final GlobalKey _streamKey = new GlobalKey(debugLabel: 'ledgerstream');
  final GlobalKey<CustomizeFieldWidgetState> _startTimeKey =
      new GlobalKey(debugLabel: 'start');
  final GlobalKey<CustomizeFieldWidgetState> _endTimeKey =
      new GlobalKey(debugLabel: 'end');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CheckboxWidgetState> _depositCheckKey =
      new GlobalKey(debugLabel: 'deposit');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  AgentStore _store;
  bool layoutReady = false;
  int totalPage;
  double tableMaxHeight;

  AgentLedgerForm _form;

  void getPageData(int page, bool requestNewData) {
    if (_store == null) return;
    if (!requestNewData && page == pagerKey.currentState.currentPage) return;
    if (!requestNewData) {
      _form.copyWith(page: page);
    } else {
      _form = AgentLedgerForm(
        startTime: _startTimeKey.currentState.getInput,
        endTime: _endTimeKey.currentState.getInput,
        account: _nameFieldKey.currentState.getInput,
        depositOnly: _depositCheckKey.currentState.boxChecked,
      );
    }
    _store.getLedger(_form);
  }

  @override
  void initState() {
    tableMaxHeight = widget.availableHeight -
        ThemeInterface.fieldHeight * 4 -
        Global.device.comfortButtonHeight;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= AgentStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 4.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          /// Start Date Field
          new CustomizeFieldWidget(
            key: _startTimeKey,
            horizontalInset: 12.0,
            fieldType: FieldType.Date,
            maxInputLength: InputLimit.DATE,
            hint: localeStr.centerTextTitleDateHint,
            persistHint: false,
            prefixText: localeStr.betsFieldTitleStartTime,
            titleLetterSpacing: 4,
            errorMsg: localeStr.messageInvalidFormat,
            validCondition: (input) => input.isDate,
          ),

          /// End Date Field
          new CustomizeFieldWidget(
            key: _endTimeKey,
            horizontalInset: 12.0,
            fieldType: FieldType.Date,
            maxInputLength: InputLimit.DATE,
            hint: localeStr.centerTextTitleDateHint,
            persistHint: false,
            prefixText: localeStr.betsFieldTitleEndTime,
            titleLetterSpacing: 4,
            errorMsg: localeStr.messageInvalidFormat,
            validCondition: (input) => input.isDate,
          ),

          /// Name Field
          new CustomizeFieldWidget(
            key: _nameFieldKey,
            horizontalInset: 16.0,
            hint: localeStr.hintAccountInput,
            persistHint: false,
            prefixText: localeStr.agentLedgerHeaderAccount,
            maxInputLength: 12,
            minusHeight: 12.0,
          ),

          /// Deposit Check
          CustomizeTitledContainer(
            horizontalInset: 16.0,
            childAlignment: Alignment.centerLeft,
            prefixText: localeStr.agentLedgerFieldTitleDepositCheck,
            child: CheckboxWidget(
              key: _depositCheckKey,
              label: '',
              initValue: false,
            ),
          ),

          /// Query Button
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(localeStr.btnQuery),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      getPageData(1, true);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 10.0),
            child: StreamBuilder<AgentLedgerModel>(
              key: _streamKey,
              stream: _store.ledgerStream,
              initialData: AgentLedgerModel(data: []),
              builder: (_, snapshot) {
                if (snapshot != null &&
                    snapshot.data != null &&
                    snapshot.data.lastPage != null) {
                  totalPage = snapshot.data.lastPage;
                  debugPrint('update total page: $totalPage');

                  if (layoutReady && totalPage != null) {
                    Future.delayed(Duration(milliseconds: 200), () {
                      pagerKey.currentState.updateTotalPage = totalPage;
                      pagerKey.currentState.updateCurrentPage =
                          snapshot.data.currentPage;
                    });
                  }
                }
                return AgentDisplayLedgerTable(
                  dataList: snapshot.data.data,
                  sumColumn: snapshot.data.sumEachColumn,
                  availableHeight: tableMaxHeight,
                  page: snapshot.data.currentPage,
                  perPage: snapshot.data.perPage,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PagerWidget(
                pagerKey,
                onAction: (page) => getPageData(page, false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    String today = DateTime.now().toDateString;
    _startTimeKey.currentState?.setInput = today;
    _endTimeKey.currentState?.setInput = today;
    layoutReady = true;
  }
}
