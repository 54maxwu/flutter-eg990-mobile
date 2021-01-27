import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/checkbox_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/horizontal_radio_group_widget.dart';
import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

import '../../data/form/agent_report_form.dart';
import '../../data/enum/agent_chart_type_enum.dart';
import '../../data/models/agent_chart_model.dart';
import '../state/agent_store.dart';
import 'agent_display_chart_content.dart';
import 'agent_store_inherit_widget.dart';

class AgentDisplayChart extends StatefulWidget {
  @override
  _AgentDisplayChartState createState() => _AgentDisplayChartState();
}

class _AgentDisplayChartState extends State<AgentDisplayChart>
    with AfterLayoutMixin {
  final GlobalKey _streamKey = new GlobalKey(debugLabel: 'reportstream');

  final GlobalKey<CustomizeFieldWidgetState> _startTimeKey =
      new GlobalKey(debugLabel: 'start');
  final GlobalKey<CustomizeFieldWidgetState> _endTimeKey =
      new GlobalKey(debugLabel: 'end');
  final GlobalKey<HorizontalRadioGroupWidgetState> _radiosKey =
      new GlobalKey(debugLabel: 'radios');
  final GlobalKey<CheckboxWidgetState> _fullKey =
      new GlobalKey(debugLabel: 'full');

  AgentStore _store;
  List<String> _radioLabels;
  bool query = false;

  @override
  void initState() {
    super.initState();
    _radioLabels = [
      localeStr.agentTextChartPlatform,
      localeStr.agentTextChartCategory,
    ];
  }

  @override
  void didUpdateWidget(AgentDisplayChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    _radioLabels = [
      localeStr.agentTextChartPlatform,
      localeStr.agentTextChartCategory,
    ];
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
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

          /// Radios
          CustomizeTitledContainer(
            horizontalInset: 16.0,
            childAlignment: Alignment.centerLeft,
            prefixText: localeStr.agentTextChartOption,
            child: HorizontalRadioGroupWidget(
              _radiosKey,
              radioLabels: _radioLabels,
              radioValues: AgentChartType.LIST,
            ),
          ),

          /// Query Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(localeStr.agentTextChartQuery),
                    onPressed: () {
                      query = true;
                      _store.getReport(AgentReportForm(
                        type: _radiosKey.currentState.getSelected,
                        startTime: _startTimeKey.currentState.getInput,
                        endTime: _endTimeKey.currentState.getInput,
                      ));
                    },
                  ),
                ),
              ],
            ),
          ),

          /// Full Data Checkbox
          CheckboxWidget(
            key: _fullKey,
            label: localeStr.agentTextChartCheckFull,
            initValue: true,
          ),

          /// history data stream
          StreamBuilder<List<AgentChartModel>>(
            key: _streamKey,
            stream: _store.reportStream,
            initialData: [],
            builder: (_, snapshot) {
              if (snapshot == null ||
                  snapshot.data == null ||
                  snapshot.data.isEmpty) {
                if (query)
                  return SizedBox(
                    height: Global.device.height / 4,
                    child: Center(
                      child: Text(localeStr.messageWarnNoHistoryData),
                    ),
                  );
                else
                  return SizedBox.shrink();
              } else {
                return AgentDisplayChartContent(
                  snapshot.data,
                  _fullKey.currentState.boxChecked,
                );
              }
            },
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
  }
}
