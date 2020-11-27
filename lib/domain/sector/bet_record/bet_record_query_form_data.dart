import 'package:flutter_eg990_mobile/utils/datetime_format.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart' show immutable, required;

import 'bet_record_time_enum.dart';

enum BetRecordQueryInputError { TARGET, OPTION }

@immutable
class BetQueryTargetData {
  final String category;
  final String platform;

  const BetQueryTargetData({this.category = '', this.platform = ''});

  bool get isValid => category.isNotEmpty && platform.isNotEmpty;
}

@immutable
class BetQueryOptionData {
  final BetRecordTimeEnum timeEnum;
  final String startDate;
  final String endDate;

  const BetQueryOptionData({
    this.timeEnum = BetRecordTimeEnum.today,
    this.startDate = '0000-00-00',
    this.endDate = '0000-00-00',
  });

  bool get isValid =>
      (timeEnum.value >= 0 && timeEnum.value < 4) ||
      (timeEnum.value == 4 && checkDateRange(startDate, endDate));
}

class BetQueryTarget
    extends FormzInput<BetQueryTargetData, BetRecordQueryInputError> {
  // Call super.pure to represent an unmodified form input.
  const BetQueryTarget.pure() : super.pure(const BetQueryTargetData());

  // Call super.dirty to represent a modified form input.
  const BetQueryTarget.dirty({@required BetQueryTargetData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  BetRecordQueryInputError validator(BetQueryTargetData data) {
    return data.isValid ? null : BetRecordQueryInputError.TARGET;
  }
}

class BetQueryOption
    extends FormzInput<BetQueryOptionData, BetRecordQueryInputError> {
  // Call super.pure to represent an unmodified form input.
  const BetQueryOption.pure() : super.pure(const BetQueryOptionData());

  // Call super.dirty to represent a modified form input.
  const BetQueryOption.dirty({@required BetQueryOptionData data})
      : super.dirty(data);

  // Override validator to handle validating a given input value.
  @override
  BetRecordQueryInputError validator(BetQueryOptionData data) {
    return data.isValid ? null : BetRecordQueryInputError.OPTION;
  }
}
