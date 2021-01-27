import 'dart:convert' show Encoding;

import 'package:flutter/material.dart' show kToolbarHeight;

import 'device.dart';
import 'language_code.dart';

class Global {
  /// Device Relative
  static Device device;

  /// APP Language
  static bool initLocale = false;

  static bool lockLanguage = false;

  static LanguageCode _locale = defaultLocale;

  static String get localeJsonKey => _locale.value.contentKey;

  static String get localeCode => _locale.value.code;

  static bool get isLocaleChinese => _locale == LanguageCode.zh;

  static set setLocale(String localeCode) =>
      _locale = LanguageCode.getByCode(localeCode);

  /// Web Service
  static const bool HAS_FLEX_ROUTE = false;
  static const String CURRENT_BASE = SK_OFFICIAL_URL;
  static String currentService = SK_SERVICE_URL;

  static const String DOMAIN_NAME = "ska888.com";
  static const String SK_OFFICIAL_URL = "https://ska888.com/";
  static const String SK_BASE_URL = "http://10.20.20.11/";
  static const String SK_TEST_URL = "http://192.168.2.87:2011/";
  static const String SK_SERVICE_URL = "";

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
