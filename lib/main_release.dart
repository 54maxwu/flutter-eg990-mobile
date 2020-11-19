import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:reflectable/reflectable.dart';

import 'env/environment.dart';
import 'main_common.dart';
import 'main_release.reflectable.dart';

Future<void> main() async {
  // setup reflectable support (build target defined in build.yaml)
  initializeReflectable();
  // Global.addAnalytics = true;
  await mainCommon(Environment.RELEASE);
}
