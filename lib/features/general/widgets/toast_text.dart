import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general/enum/toast_duration.dart';

void callToast(
  String message, {
  ToastDuration duration = ToastDuration.DEFAULT,
  int delayedMilli = 100,
  bool lightBg = false,
}) {
  Future.delayed(Duration(milliseconds: delayedMilli), () {
    BotToast.showText(
      text: message,
      textStyle: TextStyle(color: (lightBg) ? Colors.black : Colors.white),
      clickClose: true,
      backButtonBehavior: BackButtonBehavior.none,
      duration: duration.value,
      contentColor: (lightBg) ? Colors.white60 : Colors.black54,
      align: Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.95),
    );
  });
}
