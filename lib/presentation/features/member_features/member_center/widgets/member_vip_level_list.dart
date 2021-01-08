import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/domain/core/failure_type.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/vip/member_vip_data.dart';
import 'package:flutter_eg990_mobile/domain/sector/member_center/vip/member_vip_settings.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/loading_widget.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../state/member_center_store.dart';
import 'member_center_inherited_widget.dart';
import 'member_vip_level_list_item.dart';

class MemberVipLevelList extends StatefulWidget {
  @override
  _MemberVipLevelListState createState() => _MemberVipLevelListState();
}

class _MemberVipLevelListState extends State<MemberVipLevelList>
    with AutomaticKeepAliveClientMixin {
  Future _initFuture;

  List<String> titles;
  List<String> blockKeys;
  List<String> levelLabels;
  List<String> sortedLevelKeys;
  Map<String, MemberVipSettings> levelRequirements;
  List<int> blockValue;

  Widget contentWidget;
  double contentWidth;
  double titleWidth;

  Size circleSize = const Size(90.0, 90.0);
  double progressGroupMaxWidth;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    contentWidth = Global.device.width - 16.0;
    titleWidth = (contentWidth * 0.4).floorToDouble();
    progressGroupMaxWidth = circleSize.width + FontSize.NORMAL.value * 6 + 16;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MemberCenterStore store =
        MemberCenterInheritedWidget.of(context)?.store;
    if (store == null) {
      return WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
          widthFactor: 1,
          highlight: false);
    }
    super.build(context);

    _initFuture ??= Future.microtask(() => _processData(store.memberVipData));
    return FutureBuilder(
      future: _initFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == true) {
          contentWidget ??= Padding(
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
                      MemberVipSettings setting =
                          levelRequirements[sortedLevelKeys[index]];
                      int value = '${setting.toJson()[blockKey]}'.strToInt;
                      if (value == -1) blockLevelLabels.removeAt(index);
                      return value;
                    });
                    blockLevelRequirements.removeWhere((value) => value == -1);

                    /// combine level list
                    List<String> blockLevel = new List();
                    for (int i = 0; i < blockLevelRequirements.length; i++) {
                      blockLevel.add(
                          '${blockLevelLabels[i]}=${blockLevelRequirements[i]}');
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
                    debugPrint('--------------------------------------\n\n\n');

                    /// generate block
                    return MemberVipLevelListItem(
                      title: titles[index],
                      labelList: blockLevelLabels,
                      requiredList: blockLevelRequirements,
                      current: blockValue[index],
                      contentWidth: contentWidth,
                      titleWidth: titleWidth,
                      circleSize: circleSize,
                      progressGroupMaxWidth: progressGroupMaxWidth,
                    );
                  },
                ),
              ),
            ),
          );
          return contentWidget;
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data == false) {
          return WarningDisplay(
              message: localeStr.errorInternal,
              widthFactor: 1,
              highlight: false);
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Future<bool> _processData(MemberVipData vipData) async {
    // debugPrint('start processing vip data: $vipData');
    try {
      blockKeys = vipData.getBlockKeys;
      debugPrint('vip block keys: $blockKeys');

      titles = vipData.getBlockTitles;
      for (int ti = 0; ti < titles.length; ti++) {
        // debugPrint('title $ti check: ${titles[ti] == 'null'}');
        if (titles[ti] == 'null') {
          titles.replaceRange(ti, ti + 1, [_getTitleByKey(blockKeys[ti])]);
        }
      }
      debugPrint('vip block title: $titles');
    } catch (e) {
      print('failed on process vip block title:$e');
      return Future.value(false);
    }

    try {
      sortedLevelKeys ??= new List();
      levelRequirements = vipData.getLevelRequirements;
      levelRequirements.forEach((key, value) {
        sortedLevelKeys.add('$key');
        // debugPrint('vip level $key requirements: $value');
      });

      sortedLevelKeys.sort((a, b) => a.compareTo(b));
      // debugPrint('vip levels: $sortedLevelKeys');

      levelLabels = vipData.getLevelLabels;
      debugPrint('vip level labels: $levelLabels');
    } catch (e) {
      print('failed on process vip level:$e');
      return Future.value(false);
    }

    try {
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
    } catch (e) {
      print('failed on process vip block value:$e');
      return Future.value(false);
    }
    return Future.value(true);
  }

  String _getTitleByKey(String key) {
    switch (key) {
      case 'allgame':
        return localeStr.textCategoryAll;
      case 'casinogame':
        return localeStr.textCategoryCasino;
      case 'slotgame':
        return localeStr.textCategorySlot;
      case 'sportgame':
        return localeStr.textCategorySport;
      case 'fishgame':
        return localeStr.textCategoryFish;
      case 'cardgame':
        return localeStr.textCategoryCard;
      case 'lotterygame':
        return localeStr.textCategoryLottery;
      default:
        return '??';
    }
  }
}
