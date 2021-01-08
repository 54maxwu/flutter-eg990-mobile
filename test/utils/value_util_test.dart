import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test value int', () {
    expect(ValueUtil.strToInt('100', printErrorStack: true) == 100, true);
    expect(ValueUtil.strToInt('100.00', printErrorStack: true) == 100, true);
    expect(ValueUtil.strToInt('￥100', printErrorStack: true) == 100, true);
    expect(ValueUtil.strToInt('100.50', printErrorStack: true) == 100, true);
  });

  test('test value equal', () {
    expect(ValueUtil.isEqual('100.00', '100'), true);
    expect(ValueUtil.isEqual('100', '100.00'), true);
    expect(ValueUtil.isEqual('100.50', '100'), false);
    expect(ValueUtil.isEqual('100.00', '￥100'), true);
  });

  test('test int number format', () {
    var num = 1000.00;
    expect(ValueUtil.toValueFormat(num, trimIfZero: false), '1000.00');
    expect(ValueUtil.toCreditFormat(num, trimIfZero: false), '1,000.00');
    var num2 = 0.00;
    expect(ValueUtil.toValueFormat(num2, trimIfZero: true), '0');
    expect(ValueUtil.toCreditFormat(num2, trimIfZero: true), '0');
  });

  test('test number 0 format', () {
    var num = 0.0000;
    expect(ValueUtil.format(num, trimIfZero: false), '0.00');
    expect(
        ValueUtil.format(num, trimIfZero: false, addCreditSign: true), '￥0.00');
    expect(ValueUtil.format(num, floorToInt: true), '0');
    expect(ValueUtil.format(num, floorToInt: true, addCreditSign: true), '￥0');
  });

  test('test number with decimal format', () {
    var num = 1000.50;
    expect(ValueUtil.format(num), '1,000.50');
    expect(ValueUtil.format(num, addCreditSign: true), '￥1,000.50');
    expect(ValueUtil.format(num, floorToInt: true), '1,000');
    expect(
        ValueUtil.format(num, floorToInt: true, addCreditSign: true), '￥1,000');
  });

  test('test credit format', () {
    var value = '￥1000.505';
    print('\ntest: $value');
    print('test format = ${ValueUtil.format(value)}');
    print('test credit = ${ValueUtil.format(value, addCreditSign: true)}');
    print('test format num = ${ValueUtil.toValueFormat(value.strToDouble)}');
    print('test floorToInt = ${ValueUtil.format(value, floorToInt: true)}');
    print(
        'test floorToInt credit = ${ValueUtil.format(value, floorToInt: true, addCreditSign: true)}');

    var value2 = '1000';
    print('\ntest2: $value2');
    print('test2 format = ${ValueUtil.format(value2)}');
    print('test2 credit = ${ValueUtil.format(value2, addCreditSign: true)}');
    print('test2 floorToInt = ${ValueUtil.format(value2, floorToInt: true)}');
  });
}
