import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/marquee_span_widget.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/entity/marquee_entity.dart';

typedef OnMarqueeClicked = void Function(String);

class HomeDisplayMarquee extends StatelessWidget {
  final List<MarqueeEntity> marquees;
  final OnMarqueeClicked onMarqueeClicked;

  HomeDisplayMarquee({this.marquees, this.onMarqueeClicked});

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
                String url = marquees[index].url;
                debugPrint('clicked marquee $index, url: $url');
                if (url.isUrl == false) return;
                if (url.contains(Global.DOMAIN_NAME)) {
                  if (onMarqueeClicked != null) {
                    onMarqueeClicked(url);
                  }
                } else if (url.isUrl) {
                  launch(url);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
