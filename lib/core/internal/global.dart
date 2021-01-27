import 'dart:convert' show Encoding;

import 'package:flutter/material.dart' show kToolbarHeight;

import 'device.dart';

class Global {
  /// Device Relative
  static Device device;

  /// BuildType
  static bool addAnalytics = false;

  /// APP Language
  static bool initLocale = false;

  static bool lockLanguage = true;

  // zh, en, vi, th
  static String _language = 'vi';

  // content_cn, content_us, content_vn, content_th
  static String _jsonContentKey = 'content_vn';

  static String get lang => _language;

  static String get jsonContentKey => _jsonContentKey;

  static set setLanguage(String langCode) {
    _language = langCode;
    switch (langCode) {
      case 'zh':
        _jsonContentKey = 'content_cn';
        break;
      case 'en':
        _jsonContentKey = 'content_us';
        break;
      case 'vi':
        _jsonContentKey = 'content_vn';
        break;
      case 'th':
        _jsonContentKey = 'content_th';
        break;
    }
  }

  /// Web Service
  static const bool HAS_FLEX_ROUTE = false;
  static const String CURRENT_BASE = VW_OFFICIAL_URL;
  static String currentService = VW_SERVICE_URL;

  static const String VW_OFFICIAL_URL = "https://vwin84.com/";
  static const String VW_BASE_URL = "http://10.20.14.11/";
  static const String VW_TEST_URL = "http://192.168.2.87:1411/";
  static const String VW_SERVICE_URL = "http://vip66747.com/";

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
