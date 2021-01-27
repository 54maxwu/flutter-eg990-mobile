import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/types_grid_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/member/presentation/data/member_grid_item.dart';
import 'package:flutter_eg990_mobile/features/routes/subfeatures/accountcenter/data/models/center_category.dart';

import 'center_display_account.dart';
import 'center_display_vip.dart';

class CenterDisplay extends StatefulWidget {
  @override
  _CenterDisplayState createState() => _CenterDisplayState();
}

class _CenterDisplayState extends State<CenterDisplay> {
  final MemberGridItem pageItem = MemberGridItem.accountCenter;
  final List<CenterCategoryEnum> tabs = [
    CenterCategoryEnum.info,
    CenterCategoryEnum.vip,
  ];
  final int tabsPerRow = 3;
  final double expectTabHeight = 36.0;

  int _clicked = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TypesGridWidget<CenterCategoryEnum>(
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
              tabsPerRow: tabsPerRow,
              expectTabHeight: expectTabHeight,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _clicked,
              children: <Widget>[
                CenterDisplayAccount(),
                CenterDisplayVip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
