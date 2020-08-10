import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

import 'center_display_account.dart';
import 'center_display_lotto.dart';
import 'center_display_vip.dart';

class CenterDisplay extends StatefulWidget {
  @override
  _CenterDisplayState createState() => _CenterDisplayState();
}

class _CenterDisplayState extends State<CenterDisplay> {
  final List<String> tabs = [
    localeStr.centerViewTitleData,
    localeStr.centerViewTitleLotto,
    localeStr.centerViewTitleVip,
  ];

  int _clicked = 0;
  double gridRatio;

  @override
  void initState() {
    double gridItemWidth = (Global.device.width - 6 * 5 - 12) / 3;
    gridRatio = gridItemWidth / 36;
    print('grid item width: $gridItemWidth, gridRatio: $gridRatio');
    if (gridRatio > 4.16) gridRatio = 4.16;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              childAspectRatio: gridRatio,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tabs.length,
            itemBuilder: (_, index) {
              return ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: Global.device.comfortButtonHeight,
                ),
                child: RaisedButton(
                  visualDensity: VisualDensity.compact,
                  color: (_clicked == index)
                      ? Themes.buttonPrimaryColor
                      : Themes.buttonSecondaryColor,
                  textColor: (_clicked == index)
                      ? Themes.buttonTextPrimaryColor
                      : Themes.defaultTextColor,
                  child: Text(tabs[index]),
                  onPressed: () {
                    if (_clicked == index) return;
                    setState(() {
                      _clicked = index;
                    });
                  },
                ),
              );
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _clicked,
              children: <Widget>[
                CenterDisplayAccount(),
                CenterDisplayLotto(),
                CenterDisplayVip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
