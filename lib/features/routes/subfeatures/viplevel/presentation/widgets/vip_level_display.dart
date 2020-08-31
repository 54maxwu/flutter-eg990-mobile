import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/models/vip_level_model.dart';

class VipLevelDisplay extends StatelessWidget {
  final VipLevelModel data;

  VipLevelDisplay(this.data);

  final double itemMaxHeight = 484.0;
  final double itemMaxWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    double padVertical =
        (Global.device.featureContentHeight - itemMaxHeight) / 2;
    if (padVertical > 18.0) padVertical = 18.0;

    double padHorizontal = (Global.device.width - itemMaxWidth) / 2;
    if (padHorizontal > 30) padHorizontal = 30;

    return Container(
      constraints: BoxConstraints(
        maxHeight: Global.device.featureContentHeight,
        maxWidth: Global.device.width,
      ),
      alignment: Alignment.topCenter,
      margin: EdgeInsets.symmetric(
        horizontal: padHorizontal,
        vertical: padVertical,
      ),
      child: Container(
        constraints: BoxConstraints(
          // stretch the background
          maxWidth: Global.device.width - padHorizontal * 2,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, _) {
            return SizedBox(height: 30.0);
          },
          itemCount: data.levels.length,
          itemBuilder: (_, index) => _buildLevel(data.levels[index]),
        ),
      ),
    );
  }

  Widget _buildLevel(VipLevelName level) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: itemMaxHeight,
        maxWidth: itemMaxWidth - 8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 0.46, 0.54, 1.0],
          colors: [
            Themes.vipLinearBgColor1,
            Themes.vipLinearBgColor2,
            Themes.vipLinearBgColor2,
            Themes.vipLinearBgColor1,
          ],
        ),
        color: Themes.vipCardBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 2.15,
            blurRadius: 3.0,
            offset: Offset(5, 5), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 20.0, 12.0, 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Left Content (Vip badge and name)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  networkImageBuilder(
                    'images/vip/${level.img}.png',
                    imgScale: 1.75,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: FontSize.NORMAL.value * 4,
                    ),
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      level.title,
                      style: TextStyle(
                        color: Themes.vipTitleColor,
//                        fontSize: FontSize.SMALL.value,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: (level.title.length > 4) ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            /// Right Content (level conditions)
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 0.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, _) {
                    // add divider between options
                    return Divider(
                      color: Themes.vipTitleColor,
                      height: 10.0,
                    );
                  },
                  itemCount: data.options.length + 1,
                  itemBuilder: (_, optionIndex) {
                    if (optionIndex == data.options.length) {
                      // will add separator on the bottom
                      return SizedBox.shrink();
                    }

                    VipLevelOption option = data.options[optionIndex];
                    dynamic rule = data.rules[option.key][level.key];
                    if (option.type == 'switch')
                      rule = ('$rule' == '0') ? 'X' : '√';
//                    print('rule:$rule');

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Text(
                              option.ch,
                              style: TextStyle(
                                color: Themes.vipTitleColor,
                                fontSize: FontSize.SMALLER.value,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Text(
                              '$rule',
                              style: TextStyle(
                                color: (rule == '√')
                                    ? Themes.hintHighlightDarkRed
                                    : Themes.vipTextColor,
                                fontSize: FontSize.SMALLER.value,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
