import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/presentation/common/marquees/marquee_span_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/marquee_entity.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_eg990_mobile/utils/regex_util.dart';

typedef OnMarqueeClicked = void Function(String);

class HomeDisplayMarquee extends StatefulWidget {
  final List<MarqueeEntity> marquees;
  final OnMarqueeClicked onClicked;

  HomeDisplayMarquee({Key key, this.marquees, this.onClicked})
      : super(key: key);

  @override
  HomeDisplayMarqueeState createState() => HomeDisplayMarqueeState();
}

class HomeDisplayMarqueeState extends State<HomeDisplayMarquee> {
  final GlobalKey<MarqueeSpanState> _marqueeKey =
      new GlobalKey(debugLabel: 'marqueespan');
  List<String> marqueeTexts;

  void mapMarqueeTexts() {
    marqueeTexts = (widget.marquees != null && widget.marquees.isNotEmpty)
        ? widget.marquees.map((e) => e.content.replaceAll('\n', '\t')).toList()
        : [];
  }

  @override
  void initState() {
    mapMarqueeTexts();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeDisplayMarquee oldWidget) {
    if (oldWidget.marquees != widget.marquees) {
      mapMarqueeTexts();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (marqueeTexts == null || marqueeTexts.isEmpty) {
      return Icon(Icons.sync_problem);
    }
    return Container(
      color: themeColor.defaultMarqueeBarColor,
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(6.0, 0.0, 2.0, 2.0),
            height: 24.0,
            child: Image.asset(Res.marquee_loudly),
            // child: Icon(
            //   const IconData(0xf027, fontFamily: 'FontAwesome'),
            //   color: themeColor.defaultAccentColor,
            //   size: 20.0,
            // ),
          ),
          Expanded(
            child: MarqueeSpan(
              key: _marqueeKey,
              texts: marqueeTexts,
              spaceBetweenTexts: (marqueeTexts.length == 2 &&
                      widget.marquees[0].id == widget.marquees[1].id)
                  ? Global.device.width
                  : 60,
              style: TextStyle(
                fontSize: FontSize.NORMAL.value,
                color: themeColor.defaultMarqueeTextColor,
              ),
              startAfter: Duration(milliseconds: 1500),
              callback: (index) {
                // debugPrint('tapped marquee index: $index, data: ${marquees[index]}');
                if (widget.marquees[index].url.isUrl &&
                    widget.onClicked != null) {
                  String url = widget.marquees[index].url;
                  debugPrint('clicked marquee $index, url: $url');
                  // if (url.contains(Global.DOMAIN_NAME)) {
                  //   if (widget.onMarqueeClicked != null) {
                  //     widget.onMarqueeClicked(url);
                  //   }
                  // } else if (url.isUrl) {
                  //   launch(url);
                  // }
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(2.0, 2.0, 8.0, 2.0),
            height: 26.0,
            child: GestureDetector(
              onTap: () => {},
              // AppNavigator.navigateTo(RoutePage.sideNoticeBoard),
              child: Image.asset(Res.marquee_hot_game),
            ),
            // child: RaisedButton(
            //   visualDensity: VisualDensity.compact,
            //   onPressed: () => AppNavigator.navigateTo(RoutePage.sideNoticeBoard),,
            //   color: themeColor.defaultAccentColor,
            //   child: AutoSizeText(
            //     localeStr.pageTitleNotice,
            //     style: TextStyle(fontSize: FontSize.NORMAL.value),
            //     maxLines: 1,
            //     minFontSize: FontSize.SMALL.value - 4,
            //     maxFontSize: FontSize.NORMAL.value,
            //     overflow: TextOverflow.ellipsis,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}
