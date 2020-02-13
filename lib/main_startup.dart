import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general/general_widget.dart';

import 'core/internal/device.dart';
import 'core/internal/global.dart';
import 'core/internal/local_strings.dart';
import 'injection_container.dart' show sl;

///@author H.C.CHIANG
///@version 2020/2/5
class MainStartup extends StatelessWidget {
  void registerLocale(BuildContext context) {
    sl.registerSingleton<LocalStrings>(LocalStrings(context));
    Global.regLocale = true;
    print('test locale res:${localeStr.pageTitleHome}');
//    sl.get<LocalStrings>().init().then((value) {
//      print('test locale res1:${S.of(context).pageHomeRoute}');
//      print('test locale res2:${sl.get<LocalStrings>().res.pageHomeRoute}');
//    });
  }

  void getDeviceInfo(BuildContext context) {
    Global.device = Device(MediaQuery.of(context),
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    print('Device Size: ${Global.device}');
  }

  @override
  Widget build(BuildContext context) {
    if (Global.device == null) getDeviceInfo(context);
    if (Global.regLocale == false) registerLocale(context);
    return GeneralWidget();
  }
}
