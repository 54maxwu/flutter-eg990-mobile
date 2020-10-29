import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/types_grid_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/warning_display.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/notice/data/models/notice_type.dart';

import '../state/notice_store.dart';
import 'notice_display_content.dart';

class NoticeDisplay extends StatefulWidget {
  final NoticeStore store;

  NoticeDisplay(this.store);

  @override
  _NoticeDisplayState createState() => _NoticeDisplayState();
}

class _NoticeDisplayState extends State<NoticeDisplay> {
  final int tabsPerRow = 3;
  final double expectTabHeight = 36.0;

  final List<NoticeTypeEnum> tabs = [
    NoticeTypeEnum.general,
    NoticeTypeEnum.maintenance,
  ];

  int _clicked = 0;

  @override
  void didUpdateWidget(NoticeDisplay oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store.dataModel == null || widget.store.dataModel.code != '0')
      return WarningDisplay(message: widget.store.dataModel.msg);
    else
      return SizedBox(
        width: Global.device.width - 12.0,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
              child: TypesGridWidget<NoticeTypeEnum>(
                types: tabs,
                titleKey: 'label',
                onTypeGridTap: (_, type) {
                  int index = tabs.indexOf(type);
                  if (index != _clicked) {
                    setState(() {
                      _clicked = index;
                    });
                  }
                },
                round: true,
                tabsPerRow: tabsPerRow,
                itemSpace: 6.0,
                expectTabHeight: expectTabHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
