import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/agent_chart_type_enum.dart';

part 'agent_report_form.freezed.dart';

@freezed
abstract class AgentReportForm with _$AgentReportForm {
  const factory AgentReportForm({
    @required AgentChartType type,
    @required String startTime,
    @required String endTime,
  }) = _AgentReportForm;
}

extension AgentReportFormExtension on AgentReportForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'searchType': this.type.value,
      'starttime': this.startTime,
      'endtime': this.endTime ?? '',
    };
  }
}
