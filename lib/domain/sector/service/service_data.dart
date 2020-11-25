import 'package:flutter_eg990_mobile/application/global.dart';

import 'service_model.dart';

class ServiceData {
  static ServiceModel data;

  static String get cs => data.cs ?? Global.YABO_SERVICE_URL;
  static String get fb => data.fb ?? '';
  static String get zalo => data.zalo ?? '';
  static String get mail => data.mail ?? '';
  static String get app => data.appUrl ?? '';

  static String get zaloPic => data.zaloPic ?? '';
  static String get appPic => data.appPic ?? '';
}
