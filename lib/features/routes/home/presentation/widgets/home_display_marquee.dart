import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/entity/marquee_entity.dart';

import 'marquee_widget.dart';

class HomeDisplayMarquee extends StatelessWidget {
  final List<MarqueeEntity> marquees;

  HomeDisplayMarquee({this.marquees});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(Global.device.width, 30.0),
      ),
      color: Themes.defaultMarqueeBarColor,
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 2.0, 2.0),
            child: Icon(
              const IconData(0xf027, fontFamily: 'FontAwesome'),
              color: Colors.white,
              size: 20.0,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: compute(_marqueeToString, marquees),
              builder: (context, snapshot) {
//        print('marquee display state: ${snapshot.connectionState}, '
//            'error: ${snapshot.hasError}');
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return MarqueeWidget(
                    text: snapshot.data,
                    style: TextStyle(
                      fontSize: FontSize.NORMAL.value,
                      color: Themes.defaultMarqueeTextColor,
                    ),
                    loop: true,
                    velocity: 0.8,
                    height: 28,
                    padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                  );
                } else {
                  if (snapshot.hasError) {
                    MyLogger.warn(
                        msg: 'snapshot error: ${snapshot.error}',
                        tag: 'MarqueeDisplay');
                  }
                  return Icon(Icons.sync_problem);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 2.0),
            child: ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 64.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: RaisedButton(
                child: Text(
                  localeStr.pageTitleNotice,
                  style: TextStyle(
                    fontSize: FontSize.NORMAL.value,
                    color: Themes.buttonTextPrimaryColor,
                  ),
                ),
                visualDensity: VisualDensity(horizontal: -2.0, vertical: -3.0),
                onPressed: () =>
                    RouterNavigate.navigateToPage(RoutePage.noticeBoard),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Process [MarqueeEntity] content to string
String _marqueeToString(List<dynamic> list) {
  if (list == null || list.isEmpty) return '';
  String separator = '        ';
  List<String> contents = new List();
  list.forEach((item) {
    try {
      contents.add(item.content.replaceAll('\n', '\t'));
//      print('add marquee content to list: ${item.id}');
    } catch (e) {
      print(e);
    }
  });
//  print('computed list: $contents');
  if (list.isNotEmpty && contents.isEmpty) {
    MyLogger.warn(
        msg: 'error marquee type condition!! item: $list',
        tag: 'MarqueeDisplay');
  }
  return '$separator${contents.join(separator)}';
}
