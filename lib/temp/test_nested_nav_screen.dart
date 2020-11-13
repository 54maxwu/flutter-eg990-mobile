import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/temp/test_router.gr.dart';

class TestNestedNavScreen extends StatefulWidget {
  TestNestedNavScreen();

  @override
  _TestNestedNavScreenState createState() => _TestNestedNavScreenState();
}

class _TestNestedNavScreenState extends State<TestNestedNavScreen> {
  final GlobalKey<NavigatorState> testNavKey =
      new GlobalKey(debugLabel: 'testNavKey');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        appBar: ScreenMenuBar(),
//        drawer: new ScreenDrawer(),
//        bottomNavigationBar: ScreenNavigationBar(),
        body: ExtendedNavigator(
          key: testNavKey,
          initialRoute: TestRouterRoutes.testNestedNavScreenView,
          router: TestRouter(),
        ),
      ),
    );
  }
}
