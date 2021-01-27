import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

class AgentLoginNavigate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1000)).whenComplete(() {
      try {
        // RouterNavigate.navigateToPage(RoutePage.agent);
        throw UnimplementedError();
      } catch (e) {
        MyLogger.warn(
          msg: 'Agent Login Navigate has exception!!',
          tag: 'AgentLoginNavigate',
        );
      }
    });
    return SizedBox.shrink();
  }
}
