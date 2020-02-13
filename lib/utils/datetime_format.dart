import 'package:intl/intl.dart';

class DatetimeFormat {
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static String getDate() => DateTime.now().toDateString;

  static DateTime toDate(String date) => dateFormat.parse(date);
}

extension DateTimeExtensions on DateTime {
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  String get toDateString => dateFormat.format(this);

  bool isAfterHours(int hours) => isAfter(add(Duration(hours: hours)));

  bool isDayPassed() => this.day < DateTime.now().day;
}
