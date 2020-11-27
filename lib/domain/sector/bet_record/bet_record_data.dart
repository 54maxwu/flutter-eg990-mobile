import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_record_data.freezed.dart';

@freezed
abstract class BetRecordData with _$BetRecordData {
  const factory BetRecordData({
    @JsonKey(name: 'activebet') String activeBet,
    @JsonKey(name: 'validbet') String validBet,
    String bet,
    @JsonKey(name: 'betno') String betNo,
    String payout,
    String site,
    @JsonKey(name: 'starttime') String startTime,
    String type,
    dynamic key,
  }) = _BetRecordData;

  static BetRecordData jsonToModel(Map<String, dynamic> jsonMap) =>
      _$_BetRecordData(
        activeBet: jsonMap['activebet'] as String,
        validBet: jsonMap['validbet'] as String,
        bet: jsonMap['bet'] as String,
        betNo: jsonMap['betno'] as String,
        payout: jsonMap['payout'] as String,
        site: jsonMap['site'] as String,
        startTime: jsonMap['starttime'] as String,
        type: jsonMap['type'] as String,
        key: jsonMap['key'],
      );
}

extension BetRecordDataExtension on BetRecordData {
  bool isSumData() => key.toString() == 'sumTotal';
}
