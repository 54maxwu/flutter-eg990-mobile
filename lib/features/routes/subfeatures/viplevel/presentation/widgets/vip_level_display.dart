import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';

import '../../data/models/vip_level_model.dart';

class VipLevelDisplay extends StatelessWidget {
  final VipLevelModel data;

  VipLevelDisplay(this.data);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Global.device.width - 24.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: ListView.separated(
          primary: true,
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
      margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 0.46, 0.54, 1.0],
          colors: [
            themeColor.vipLinearBgColor1,
            themeColor.vipLinearBgColor2,
            themeColor.vipLinearBgColor2,
            themeColor.vipLinearBgColor1,
          ],
        ),
        color: themeColor.vipCardBackgroundColor,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Left Content (Vip badge and name)
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 36 * Global.device.widthScale,
                    ),
                    child: networkImageBuilder(
                      'images/vip/${level.img}.png',
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: FontSize.NORMAL.value * 4,
                    ),
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      level.title,
                      style: TextStyle(
                        color: themeColor.vipTitleColor,
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
                      color: themeColor.vipTitleColor,
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
//                    debugPrint('rule:$rule');

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Text(
                              option.getContent,
                              style: TextStyle(
                                color: themeColor.vipTitleColor,
                                fontSize: FontSize.SMALLER.value,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: Text(
                              '$rule',
                              style: TextStyle(
                                color: (rule == '√')
                                    ? themeColor.hintHighlightDarkRed
                                    : themeColor.vipLevelTextColor,
                                fontSize: FontSize.SMALLER.value,
                              ),
                              maxLines: 3,
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
