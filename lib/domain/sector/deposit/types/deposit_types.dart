import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/domain/interface/data_operator.dart';
import 'package:flutter_eg990_mobile/utils/json_util.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart' show required;

import 'deposit_method.dart';

part 'deposit_types.freezed.dart';

@freezed
abstract class DepositType implements _$DepositType, DataOperator {
  const DepositType._();

  const factory DepositType({
    @required int key,
    List<DepositMethod> dataList,
  }) = _DepositType;

  @override
  String operator [](String key) => label;

  static List<DepositType> decodeDepositType(Map<String, dynamic> json) {
    List<DepositType> list = new List();
    json.forEach((key, value) {
      // debugPrint('decoding deposit type, key:$key');
      list.add(
          DepositType(key: '$key'.strToInt, dataList: _decodeTypeData(value)));
    });
    list.sort((a, b) => a.key.compareTo(b.key));
    return list;
  }

  static List<DepositMethod> _decodeTypeData(dynamic str) =>
      JsonUtil.decodeMapToModelList(
        str,
        (jsonMap) => DepositMethod.fromJson(jsonMap),
        tag: 'DepositType',
      );
}

extension DepositTypeExtension on DepositType {
  String get label {
    switch (key) {
      case 1:
        return localeStr?.depositPaymentTitleBank ?? 'Bank';
      case 2:
        return localeStr?.depositPaymentTitleOnline ?? 'Online';
      default:
        return 'Unknown';
    }
  }
}
