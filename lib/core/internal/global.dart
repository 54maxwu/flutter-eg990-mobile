import 'dart:convert' show Encoding;

import 'package:flutter/material.dart' show kToolbarHeight;

import 'device.dart';

class Global {
  static Device device;

  static bool regLocale = false;

  static const bool IS_TEST_VER = true;
  static const String CURRENT_SERVICE =
      (IS_TEST_VER) ? TEST_BASE_URL : TY_BASE_URL;

  static const String TEST_BASE_URL = "https://www.eg990.com/";
  static const String TY_BASE_URL = "https://www.vip66729.com/";
  static const String TY_SERVICE_URL = "http://vip66741.com/";

  static const double APP_BAR_HEIGHT = kToolbarHeight - 8;
  static const double APP_TOOLS_HEIGHT = Global.APP_BAR_HEIGHT * 2 + 8;
  static const double TEST_DEVICE_HEIGHT = 785.45;
  static const double TEST_DEVICE_WIDTH = 392.72;

  static const String CACHED_COOKIE = 'CACHED_USER_COOKIE';
  static const String CACHE_LOGIN_FORM = 'CACHE_LOGIN_FORM';
  static const String WEB_MIMETYPE = 'text/html';
  static Encoding webEncoding = Encoding.getByName('utf-8');
}
