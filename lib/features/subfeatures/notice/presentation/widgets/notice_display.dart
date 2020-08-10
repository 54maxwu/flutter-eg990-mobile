import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/warning_display.dart';

import '../state/notice_store.dart';
import 'notice_display_content.dart';

class NoticeDisplay extends StatefulWidget {
  final NoticeStore store;

  NoticeDisplay(this.store);

  @override
  _NoticeDisplayState createState() => _NoticeDisplayState();
}

class _NoticeDisplayState extends State<NoticeDisplay> {
  final List<String> tabs = [
    localeStr.noticeTabGeneral,
    localeStr.noticeTabMaintenance,
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
    if (widget.store.dataModel == null || widget.store.dataModel.code != '0')
      return WarningDisplay(
        message: widget.store.dataModel.msg,
        infiniteHeight: true,
      );
    else
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
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
                  NoticeDisplayContent(dataList: widget.store.getMarqueeList),
                  NoticeDisplayContent(
                      dataList: widget.store.getMaintenanceList),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
