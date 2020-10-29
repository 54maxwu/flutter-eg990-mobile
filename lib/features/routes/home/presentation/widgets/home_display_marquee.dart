import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/marquee_span_widget.dart';

import '../../data/entity/marquee_entity.dart';

class HomeDisplayMarquee extends StatelessWidget {
  final List<MarqueeEntity> marquees;

  HomeDisplayMarquee({this.marquees});

  @override
  Widget build(BuildContext context) {
    if (marquees == null || marquees.isEmpty) return SizedBox.shrink();
    return Container(
      constraints: BoxConstraints.tight(Size(Global.device.width, 30.0)),
      color: themeColor.defaultMarqueeBarColor,
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
            child: MarqueeSpan(
              texts: marquees
                  .map((e) => e.content.replaceAll('\n', '\t'))
                  .toList(),
              spaceBetweenTexts:
                  (marquees.length == 2 && marquees[0].id == marquees[1].id)
                      ? Global.device.width
                      : 60,
              style: TextStyle(
                fontSize: FontSize.NORMAL.value,
                color: themeColor.defaultMarqueeTextColor,
              ),
              startAfter: Duration(milliseconds: 1500),
              callback: (index) {
                // debugPrint('tapped marquee index: $index, data: ${marquees[index]}');
                if (marquees[index].url.isUrl) {
                  String url = marquees[index].url;
                  debugPrint('tapped marquee index: $index, url: $url');
                  String pageName = url.substring(url.indexOf('.com/') + 4);
                  // debugPrint('marquee url page name: $pageName');
                  final route = pageName.urlToRoutePage;
                  if (route != null) {
                    if (route.isUserOnly &&
                        getAppGlobalStreams.hasUser == false) {
                      AppNavigator.navigateTo(RoutePage.login);
                    } else {
                      AppNavigator.navigateTo(route);
                    }
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
