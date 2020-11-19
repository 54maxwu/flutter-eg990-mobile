import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/data/shortcut_item.dart';
import 'package:flutter_eg990_mobile/presentation/features/user/presentation/state/user_info_store.dart';
import 'package:flutter_eg990_mobile/presentation/screens/main_screen_provider.dart';
import 'package:provider/provider.dart';

import 'home_display_provider.dart';
import 'home_display_size_calc.dart';

class HomeShortcutWidget extends StatefulWidget {
  final bool loggedIn;

  HomeShortcutWidget({Key key, @required this.loggedIn}) : super(key: key);

  @override
  HomeShortcutWidgetState createState() => HomeShortcutWidgetState();
}

class HomeShortcutWidgetState extends State<HomeShortcutWidget> {
  final List<ShortcutItem> shortcuts = [
    ShortcutItem.deposit,
    ShortcutItem.transfer,
    ShortcutItem.withdraw,
    ShortcutItem.vip,
  ];

  HomeDisplaySizeCalc display;
  UserInfoStore infoStore;
  Widget _shortcutWidget;

  @override
  Widget build(BuildContext context) {
    display ??=
        Provider.of<HomeDisplayProvider>(context).calc ?? HomeDisplaySizeCalc();
    _shortcutWidget ??= _buildShortcuts();
    return Container(
      height: display.shortcutMaxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<MainScreenProvider, String>(
                  selector: (_, provider) => provider.userInfoStore.userName,
                  builder: (_, name, __) {
                    return AutoSizeText(
                      (name.isNotEmpty && widget.loggedIn) ? name : '您還未登陸',
                      style: TextStyle(
                        color: themeColor.defaultTextColor,
                        fontSize: FontSize.SUBTITLE.value,
                      ),
                      minFontSize: FontSize.SMALLER.value,
                      maxFontSize: FontSize.TITLE.value,
                    );
                  },
                ),
                Selector<MainScreenProvider, String>(
                  selector: (_, provider) => provider.userInfoStore.userCredit,
                  builder: (_, credit, __) {
                    return AutoSizeText(
                      (credit.isNotEmpty && widget.loggedIn)
                          ? credit
                          : '請先登錄/註冊後查看',
                      style: TextStyle(
                        color: themeColor.defaultHintColor,
                        fontSize: FontSize.NORMAL.value,
                      ),
                      minFontSize: FontSize.SMALL.value,
                      maxFontSize: FontSize.SUBTITLE.value,
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: _shortcutWidget,
          ),
        ],
      ),
    );
  }

  Widget _buildShortcuts() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(shortcuts.length, (index) {
            return Expanded(child: _createIconButton(shortcuts[index]));
          })),
    );
  }

  Widget _createIconButton(ShortcutItem item) {
    final String label = item.value.label;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: GestureDetector(
        onTap: () {
          // (item.value.isUserOnly == false)
          //     ? AppNavigator.navigateTo(item.value.route)
          //     : (item.value.isUserOnly && isUserContent)
          //         ? AppNavigator.navigateTo(item.value.route)
          //         : toastLogin();
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: display.shortcutMaxIconSize,
              child: Icon(
                item.value.iconData,
                color: themeColor.homeBoxIconColor,
              ),
            ),
            SizedBox(
              height: display.shortcutMaxTextHeight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: AutoSizeText(
                  label,
                  style: TextStyle(
                    fontSize: FontSize.NORMAL.value,
                    color: themeColor.homeBoxIconTextColor,
                  ),
                  minFontSize: FontSize.SMALLER.value,
                  maxFontSize: FontSize.SUBTITLE.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
