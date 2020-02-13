import 'dart:io' show File;

import 'package:carousel_pro/carousel_pro.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:meta/meta.dart' show required;

///
/// @author H.C.CHIANG
/// @version 2019/12/27
class BannerDisplay extends StatelessWidget {
  final List<dynamic> images;

  BannerDisplay({
    Key key,
    @required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: compute(_bannerInfoToWidgets, images),
      builder: (context, snapshot) {
        print('banner display state: '
            '${snapshot.connectionState}, error: ${snapshot.hasError}');
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return _updateBannerWall(snapshot.data);
        } else {
          if (snapshot.hasError)
            MyLogger.warn(
                msg: 'snapshot error: ${snapshot.error}', tag: 'BannerDisplay');
          return Icon(Icons.sync_problem);
        }
      },
    );
  }

  Carousel _updateBannerWall(List<Widget> widgets) {
    return Carousel(
      boxFit: BoxFit.fill,
      images: widgets,
      dotSize: 3.0,
      dotSpacing: 16.0,
      dotColor: Themes.defaultAccentColor,
      indicatorBgPadding: 4.0,
      dotBgColor: Colors.white12,
      borderRadius: false,
      animationDuration: Duration(milliseconds: 2000),
      autoplayDuration: Duration(seconds: 10),
    );
  }
}

/// Create banner widgets to display.
/// If banner has local file, create [Image] widget.
/// If banner uses url, create [ExtendedImage] widget.
/// If param contains a list, then something went wrong with banner data,
/// should show a [Icon] on the UI.
List<Widget> _bannerInfoToWidgets(List<dynamic> list) {
  List<Widget> widgets = new List();
  list.forEach((item) {
//    print('creating banner widget: $item');
    if (item is File) {
      widgets.add(Image.file(item));
    } else if (item is String) {
      widgets.add(ExtendedImage.network(
        item,
        cache: true,
      ));
    } else if (item is List) {
      widgets = list;
      return;
    } else {
      MyLogger.warn(
          msg: 'unknown switch condition!! item: $item', tag: 'BannerDisplay');
    }
  });
//  print('banner widgets: $widgets');
  return widgets;
}
