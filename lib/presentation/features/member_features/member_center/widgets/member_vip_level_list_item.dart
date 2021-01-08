import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:relative_layout/relative_layout.dart';

class MemberVipLevelListItem extends StatelessWidget {
  final String title;
  final List<String> labelList;
  final List<int> requiredList;
  final int current;

  final double contentWidth;
  final double titleWidth;

  final Size circleSize;
  final double progressBarHeight = 18.0;
  final double progressGroupMaxWidth;

  const MemberVipLevelListItem({
    @required this.title,
    @required this.labelList,
    @required this.requiredList,
    @required this.current,
    @required this.contentWidth,
    @required this.titleWidth,
    @required this.circleSize,
    @required this.progressGroupMaxWidth,
  });

  @override
  Widget build(BuildContext context) {
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
//      debugPrint('inner widgets for $title, length: ${progressWidgets.length}, processed: $value');
    }

    return Padding(
      /// block's padding
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
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
//    debugPrint('generating progress widget: $required, isFirst: $isFirst');
    double progressGroupMaxHeight;
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
      _generateCircleGroup(
          label, levelValue, current, labelOnRight, progressGroupMaxHeight),

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
    double groupHeight,
  ) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: progressGroupMaxWidth,
        maxHeight: groupHeight,
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
