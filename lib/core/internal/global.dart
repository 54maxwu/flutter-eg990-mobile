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
  // zh, th, en, vi
  static String _language = 'zh';
  // content_cn, content_th, content_us, content_vn
  static String _jsonContentKey = 'content_zh';

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
      default:
        _jsonContentKey = 'content';
        break;
    }
  }

  /// Web Service
  static const bool HAS_FLEX_ROUTE = false;
  static const String CURRENT_BASE = YABO_TEST_URL;

  static const String DOMAIN_NAME = "";
  static const String YABO_BASE_URL = "";
  static const String YABO_OFFICIAL_URL = "";
  static const String YABO_TEST_URL = "http://192.168.2.87:2023/";
  static const String YABO_SERVICE_URL = "";

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
