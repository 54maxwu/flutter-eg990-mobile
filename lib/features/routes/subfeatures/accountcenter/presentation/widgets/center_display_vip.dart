import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:relative_layout/relative_layout.dart';

import '../../data/entity/center_vip_entity.dart';
import '../../data/models/center_vip_setting_model.dart';
import '../state/center_store.dart';
import 'center_store_inherit_widget.dart';

class CenterDisplayVip extends StatefulWidget {
  @override
  _CenterDisplayVipState createState() => _CenterDisplayVipState();
}

class _CenterDisplayVipState extends State<CenterDisplayVip> {
  final Key _streamKey = new Key('vipstream');

  CenterStore _store;
  CenterVipEntity vipData;
  List<String> titles;
  List<String> blockKeys;
  List<String> levelLabels;
  List<String> sortedLevelKeys;
  Map<String, CenterVipSettingItem> levelRequirements;
  List<int> blockValue;

  Widget contentWidget;
  double contentWidth;
  double titleWidth;

  Size circleSize = const Size(90.0, 90.0);
  double progressBarHeight = 18.0;
  double progressGroupMaxWidth;
  double progressGroupMaxHeight;

  void updateData() {
    titles = vipData.getBlockTitles;
//    debugPrint('vip block title: $titles');

    blockKeys = vipData.getBlockKeys;
    // debugPrint('vip block keys: $blockKeys');

    blockValue = List.from(blockKeys.map((key) {
      debugPrint('data key: $key, data: ${vipData[key]}');
      return '${vipData[key]}'.strToInt;
    }));
    // debugPrint('vip block value: $blockValue');

    // if block value equals -1, block should not be build
    if (blockValue.contains(-1)) {
      List<int> removeIndex = new List();
      for (int i = 0; i < blockValue.length; i++) {
        if (blockValue[i] == -1) {
          removeIndex.add(i);
        }
      }
      removeIndex.forEach((index) {
        titles.removeAt(index);
        blockKeys.removeAt(index);
        blockValue.removeAt(index);
      });
    }

    sortedLevelKeys ??= new List();
    levelRequirements = vipData.getLevelRequirements;
    levelRequirements.forEach((key, value) {
      sortedLevelKeys.add(key);
//      debugPrint('vip level $key requirements: $value');
    });

    sortedLevelKeys.sort((a, b) => a.compareTo(b));
//    debugPrint('vip levels: $sortedLevelKeys');

    levelLabels = vipData.getLevelLabels;
//    debugPrint('vip level labels: $levelLabels');
  }

  @override
  void initState() {
    contentWidth = Global.device.width - 16.0;
    titleWidth = (contentWidth * 0.4).floorToDouble();
    progressGroupMaxWidth = circleSize.width + FontSize.NORMAL.value * 6 + 16;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= CenterStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
        ),
      );
    }
    return StreamBuilder(
      key: _streamKey,
      stream: _store.vipStream,
      builder: (_, snapshot) {
//        debugPrint('vip stream snapshot: $snapshot');
        if (contentWidget == null || _store.accountVip != vipData) {
          vipData = _store.accountVip;
          updateData();
          contentWidget = _buildView();
        }
        return contentWidget;
      },
    );
  }

  Widget _buildView() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Global.device.height / 2,
            maxWidth: Global.device.width - 16,
          ),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: titles.length,
            itemBuilder: (_, index) {
              /// prepare block data
              String blockKey = blockKeys[index];
              debugPrint('sorting block: $blockKey');
              List<String> blockLevelLabels = new List.from(levelLabels);
              List<int> blockLevelRequirements =
                  new List.generate(sortedLevelKeys.length, (index) {
                CenterVipSettingItem setting =
                    levelRequirements[sortedLevelKeys[index]];
                int value = '${setting.toJson()[blockKey]}'.strToInt;
                if (value == -1) blockLevelLabels.removeAt(index);
                return value;
              });
              blockLevelRequirements.removeWhere((value) => value == -1);

              /// combine level list
              List<String> blockLevel = new List();
              for (int i = 0; i < blockLevelRequirements.length; i++) {
                blockLevel
                    .add('${blockLevelLabels[i]}=${blockLevelRequirements[i]}');
              }

              /// sort block data
              blockLevel.sort((a, b) {
                int aValue = a.split('=')[1].strToInt;
                int bValue = b.split('=')[1].strToInt;
                int cp = aValue.compareTo(bValue);
                return cp;
              });

              /// split level list
              blockLevelLabels.clear();
              blockLevelRequirements.clear();
              blockLevel.forEach((level) {
                var split = level.split('=');
                blockLevelRequirements.add(split[1].strToInt);
                blockLevelLabels.add(split[0]);
              });

              debugPrint('----------sorted: ${titles[index]}----------');
              debugPrint('sorted level labels: $blockLevelLabels');
              debugPrint('sorted level values: $blockLevelRequirements');
              print('--------------------------------------\n\n\n');

              /// generate block
              return _generateBlock(
                titles[index],
                blockLevelLabels,
                blockLevelRequirements,
                blockValue[index],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _generateBlock(String title, List<String> labelList,
      List<int> requiredList, int current) {
    print('$title block: $labelList \<-\> $requiredList');
    if (labelList.length != requiredList.length)
      MyLogger.warn(msg: '$title block data length not match');

    List<Widget> progressWidgets = new List();
    for (int i = 0; i < labelList.length; i++) {
      progressWidgets.addAll(_generateProgress(
        label: labelList[i],
        current: current,
        levelValue: requiredList[i],
        nextLevelValue:
            (i >= requiredList.length - 1) ? null : requiredList[i + 1],
        isFirst: i == 0,
        isLast: i == requiredList.length - 1,
        labelOnRight: i % 2 == 1,
      ));
//      print('inner widgets for $title, length: ${progressWidgets.length}, processed: $value');
    }

    return Padding(
      /// block's padding
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: themeColor.vipCardBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                Container(
                    width: titleWidth,
                    padding: EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 14.0),
                    decoration: BoxDecoration(
                      color: themeColor.vipTitleBackgroundColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(8.0)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: title,
                        style: TextStyle(color: themeColor.vipIconTextColor),
                      ),
                      textAlign: TextAlign.left,
                    )),
                Positioned(
                  left: titleWidth,
                  top: 0,
                  bottom: 0,
                  width: contentWidth - titleWidth - 16.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: themeColor.vipTitleBackgroundSubColor,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(8.0)),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text('$current'),
                  ),
                ),
              ],
            ),
            Column(
              children: progressWidgets,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _generateProgress({
    @required String label,
    @required int current,
    @required int levelValue,
    int nextLevelValue,
    bool isFirst = false,
    bool isLast = false,
    bool labelOnRight = false,
  }) {
//    print('generating progress widget: $required, isFirst: $isFirst');
    if (isLast) {
      progressGroupMaxHeight = circleSize.height;
    } else {
      progressGroupMaxHeight =
          circleSize.height + progressBarHeight - (circleSize.height / 5);
    }
    double progress;
    if (nextLevelValue == null) {
      progress = 0;
    } else if (current > nextLevelValue) {
      progress = 1;
    } else if (current > levelValue) {
      progress = (current - levelValue) / (nextLevelValue - levelValue);
    } else {
      progress = 0;
    }

    /// circle and label
    return [
      if (isFirst) SizedBox(height: 12.0),
      _generateCircleGroup(label, levelValue, current, labelOnRight),

      /// progress bar
      (!isLast)
          ? RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                width: progressBarHeight,
                height: 10,
                child: LinearProgressIndicator(
                  backgroundColor: themeColor.vipIconBackgroundColor,
                  value: progress,
                  valueColor:
                      AlwaysStoppedAnimation(themeColor.defaultAccentColor),
                ),
              ),
            )
          : SizedBox(height: 12.0),
    ];
  }

  Widget _generateCircleGroup(
    String label,
    int required,
    int current,
    bool labelOnRight,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: progressGroupMaxWidth,
        maxHeight: progressGroupMaxHeight,
      ),
      child: RelativeLayout(
        children: <Widget>[
          LayoutId(
            id: RelativeId('C'),
            child: Container(
              constraints: BoxConstraints.tight(circleSize),
              decoration: BoxDecoration(
                color: (current >= required)
                    ? themeColor.vipIconColor
                    : themeColor.vipIconBackgroundColor,
                shape: BoxShape.circle,
                border: new Border.all(
                  color: themeColor.vipIconBackgroundColor,
                  width: 6.0,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black54,
                    spreadRadius: 0.6,
                    blurRadius: 4,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  required.toString(),
                  style: TextStyle(
                    color: (current >= required)
                        ? themeColor.vipIconTextColor
                        : themeColor.vipLevelTextColor,
                  ),
                ),
              ),
            ),
          ),
          (labelOnRight)
              ? LayoutId(
                  id: RelativeId(
                    'T',
                    toRightOf: 'C',
                    alignment: Alignment.center,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(label,
                        style: TextStyle(color: themeColor.vipLevelTextColor)),
                  ),
                )
              : LayoutId(
                  id: RelativeId(
                    'T',
                    toLeftOf: 'C',
                    alignment: Alignment.center,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(label,
                        style: TextStyle(color: themeColor.vipLevelTextColor)),
                  ),
                ),
        ],
      ),
    );
  }
}
