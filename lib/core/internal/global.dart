import 'package:flutter/material.dart' show kToolbarHeight;

import 'device.dart';

class Global {
  static Device device;

  static bool regLocale = false;

  static const String TEST_BASE_URL = "https://eg990.com/";

  static const double APP_BAR_HEIGHT = kToolbarHeight - 8;
}
