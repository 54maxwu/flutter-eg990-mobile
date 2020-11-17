import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

class HomeDisplayTabAbout extends StatelessWidget {
  final Function onNavigateCallBack;

  HomeDisplayTabAbout({@required this.onNavigateCallBack});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 100), () {
      // do something to prevent reroute again on back press
      onNavigateCallBack();
      // route to promo page
      AppNavigator.navigateTo(RoutePage.about);
    });
    return Center(child: CircularProgressIndicator());
  }
}
