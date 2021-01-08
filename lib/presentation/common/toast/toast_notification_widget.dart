import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';

CancelFunc callToastNotification({
  String title,
  String subtitle,
  bool crossPage = true,
  bool enableSlideOff = true,
  duration = const Duration(seconds: 5),
}) {
  return BotToast.showNotification(
    backgroundColor: themeColor.defaultWidgetColor,
    leading: (_) => SizedBox.fromSize(
      size: const Size(40, 40),
      child: Image.asset(Res.icon_bar_logo),
    ),
    title: (_) => Text(title ?? localeStr.appTitle),
    subtitle: (_) => Text(
      subtitle,
      style: TextStyle(color: themeColor.secondaryTextColor1),
    ),
    trailing: (cancel) => IconButton(
      icon: Icon(Icons.cancel, color: themeColor.defaultTextColor),
      onPressed: cancel,
    ),
    enableSlideOff: enableSlideOff,
    crossPage: crossPage,
    duration: duration,
  );
}

/// Show Loading toast as child widget
///@author H.C.CHIANG
///@version 2020/7/29
class ToastNotificationWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool crossPage;
  final bool enableSlideOff;
  final Duration duration;

  ToastNotificationWidget({
    this.title,
    this.subtitle = '',
    this.duration = const Duration(seconds: 5),
    this.crossPage = true,
    this.enableSlideOff = true,
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      BotToast.showNotification(
        backgroundColor: themeColor.defaultWidgetColor,
        leading: (_) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: Image.asset(Res.icon_bar_logo),
        ),
        title: (_) => Text(title ?? localeStr.appTitle),
        subtitle: (_) => Text(
          subtitle,
          style: TextStyle(color: themeColor.secondaryTextColor1),
        ),
        trailing: (cancel) => IconButton(
          icon: Icon(Icons.cancel, color: themeColor.defaultTextColor),
          onPressed: cancel,
        ),
        enableSlideOff: enableSlideOff,
        crossPage: crossPage,
        duration: duration,
      );
    });
    return SizedBox.shrink();
  }
}
