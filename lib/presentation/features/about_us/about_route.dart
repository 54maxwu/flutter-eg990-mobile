import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'widgets/about_display.dart';

class AboutRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop about route');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Res.wallpaper),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: AboutDisplay(),
        ),
      ),
    );
  }
}
