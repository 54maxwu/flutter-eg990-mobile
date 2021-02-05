import 'dart:convert' show Encoding;

import 'package:flutter/material.dart' show kToolbarHeight;

import 'device.dart';
import 'language.dart';

class Global {
  /// Device Relative
  static Device device;

  /// APP Language
  static Language lang;

  /// Web Service
  static const bool HAS_FLEX_ROUTE = false;
  static const String CURRENT_BASE = BKK_TEST_URL;
  static String currentService = CS_SERVICE_URL;

  static const String DOMAIN_NAME = "192.168.2.87:1635";
  static const String BKK_OFFICIAL_URL = "https://vip66686.com/";
  static const String BKK_BASE_URL = "http://10.20.16.35/";
  static const String BKK_TEST_URL = "http://192.168.2.87:1635/";
  static const String CS_SERVICE_URL = "";

  /// HIVE table name
  static const String CACHED_COOKIE = 'CACHED_USER_COOKIE';
  static const String CACHE_LOGIN_FORM = 'CACHE_LOGIN_FORM';
  static const String CACHE_APP_DATA = 'CACHE_APP_DATA';

  static const String CACHE_APP_DATA_KEY_LANG = 'lang';
  static const String CACHE_APP_DATA_KEY_THEME = 'theme';

  /// Other static value
  static const double APP_MENU_HEIGHT = kToolbarHeight - 8.0;
  static const double APP_NAV_HEIGHT = kToolbarHeight + 12.0;
  static const double APP_BARS_HEIGHT = Global.APP_MENU_HEIGHT + APP_NAV_HEIGHT;
  static const double TEST_DEVICE_HEIGHT = 785.45;
  static const double TEST_DEVICE_WIDTH = 392.72;

  static const String WEB_MIMETYPE = 'text/html';
  static Encoding webEncoding = Encoding.getByName('utf-8');
}
