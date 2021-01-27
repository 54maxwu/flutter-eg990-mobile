import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_ledger_form.freezed.dart';

@freezed
abstract class AgentLedgerForm with _$AgentLedgerForm {
  const factory AgentLedgerForm({
    @required String startTime,
    @required String endTime,
    @Default('') String account,
    @Default(false) bool depositOnly,
    @Default(1) int page,
    @Default('') String select,
  }) = _AgentLedgerForm;
}

extension AgentLedgerFormExtension on AgentLedgerForm {
  /// This method is not reversible
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'starttime': this.startTime,
      'endtime': this.endTime,
      'accountcode': this.account,
      'depositonly': (this.depositOnly) ? 1 : 0,
      'page': this.page,
      'select': this.select,
    };
  }
}
