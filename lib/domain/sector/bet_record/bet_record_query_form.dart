import 'package:dartz/dartz.dart';
import 'package:flutter_eg990_mobile/domain/sector/bet_record/bet_record_query_form_data.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show required, immutable;

@immutable
class BetRecordQueryForm with FormzMixin {
  BetRecordQueryForm({
    @required this.option,
    @required this.target,
    this.page = 1,
  });

  final BetQueryTarget target;
  final BetQueryOption option;
  final int page;

  @override
  List<FormzInput> get inputs => [target, option];

  @override
  String toString() {
    return 'BetRecordQueryForm(target: $target, option: $option, page: $page)' +
        '\nBetRecordQueryForm Status: ${this.status}';
  }

  Either<BetRecordQueryInputError, Unit> get validate =>
      (this.status == FormzStatus.valid)
          ? right(unit)
          : left(this.target.error ?? this.option.error);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'platform': target.value.platform,
        'page': page,
        'time': option.value.timeEnum.value,
        'starttime': option.value.startDate,
        'endtime': option.value.endDate,
      };

  bool get queryAllPlatform => target.value.platform.toLowerCase() == 'all';
}
