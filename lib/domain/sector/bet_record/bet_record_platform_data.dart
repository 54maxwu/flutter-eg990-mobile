import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_record_platform_data.freezed.dart';

@freezed
abstract class BetRecordPlatformData with _$BetRecordPlatformData {
  const factory BetRecordPlatformData({
    num bet,
    num valid,
    num payout,
    dynamic key,
  }) = _BetRecordPlatformData;

  static BetRecordPlatformData jsonToModel(
    Map<String, dynamic> jsonMap,
  ) =>
      _$_BetRecordPlatformData(
        bet: jsonMap['bet'] as num,
        valid: jsonMap['validbet'] as num,
        payout: jsonMap['payout'] as num,
        key: jsonMap['key'],
      );
}

extension BetRecordPlatformDataExtension on BetRecordPlatformData {
  bool isSumData() => key.toString() == 'total';
}
