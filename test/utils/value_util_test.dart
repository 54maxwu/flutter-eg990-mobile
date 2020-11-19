import 'package:flutter_eg990_mobile/utils/value_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test value int', () {
    expect(stringToInt('100') == 100, true);
    expect(stringToInt('100.00') == 100, true);
    expect(stringToInt('￥100') == 100, true);
    expect(stringToInt('100.50') == 100, true);
  });

  test('test value equal', () {
    expect(valueIsEqual('100.00', '100'), true);
    expect(valueIsEqual('100.50', '100'), false);
    expect(valueIsEqual('100.00', '￥100'), true);
  });

  test('test int number format', () {
    var num = 1000.00;
    expect(formatNum(num, trimIfZero: false, addComma: false), '1000.00');
    expect(formatNum(num, trimIfZero: false, addComma: true), '1,000.00');
    var num2 = 0.00;
    expect(formatNum(num2, trimIfZero: false), '0.00');
    expect(formatNum(num2, trimIfZero: true), '0');
  });

  test('test number 0 format', () {
    var num = 0.0000;
    expect(formatValue(num, trimIfZero: false), '0.00');
    expect(formatValue(num, trimIfZero: false, creditSign: true), '￥0.00');
    expect(formatValue(num, floorToInt: true), '0');
    expect(formatValue(num, floorToInt: true, creditSign: true), '￥0');
  });

  test('test number with decimal format', () {
    var num = 1000.50;
    expect(formatValue(num), '1,000.50');
    expect(formatValue(num, creditSign: true), '￥1,000.50');
    expect(formatValue(num, floorToInt: true), '1,000');
    expect(formatValue(num, floorToInt: true, creditSign: true), '￥1,000');
  });

  test('test credit format', () {
    var value = '￥1000.50';
    print('\ntest: $value');
    print('test format = ${formatValue(value)}');
    print('test credit = ${formatValue(value, creditSign: true)}');
    print('test floorIfInt = ${formatValue(value, floorToInt: true)}');
    print(
        'test floorIfInt credit = ${formatValue(value, floorToInt: true, creditSign: true)}');

    var value2 = '￥1000.00';
    print('\ntest2: $value2');
    print('test2 format = ${formatValue(value2)}');
    print('test2 remove credit = ${formatValue(value2, creditSign: false)}');
    print('test2 floor = ${formatValue(value2, floorToInt: true)}');
  });
}
