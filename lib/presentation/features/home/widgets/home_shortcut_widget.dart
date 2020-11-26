import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';
import 'package:provider/provider.dart';

import '../data/shortcut_item.dart';
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
            child: GestureDetector(
              onTap: () => (widget.loggedIn)
                  ? null
                  : AppNavigator.navigateTo(RoutePage.login),
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
                          fontSize: FontSize.MESSAGE.value,
                        ),
                        minFontSize: FontSize.SMALLER.value,
                        maxFontSize: FontSize.TITLE.value,
                      );
                    },
                  ),
                  Selector<MainScreenProvider, String>(
                    selector: (_, provider) =>
                        provider.userInfoStore.userCredit,
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
                        maxFontSize: FontSize.MESSAGE.value,
                      );
                    },
                  ),
                ],
              ),
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
      height: display.shortcutMaxHeight - 8.0,
      child: GestureDetector(
        onTap: () {
          if (!infoStore.hasUser && item.value.isUserOnly) {
            callToastInfo(localeStr.messageErrorNotLogin);
          } else {
            AppNavigator.navigateTo(item.value.route);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: (item.value.assetPath.isNotEmpty)
                  ? Image.asset(item.value.assetPath, scale: 1.5)
                  : Icon(
                      item.value.iconData,
                      color: themeColor.homeBoxIconColor,
                      size: display.shortcutMaxIconSize,
                    ),
            ),
            AutoSizeText(
              label,
              style: TextStyle(
                fontSize: FontSize.NORMAL.value,
                color: themeColor.homeBoxIconTextColor,
              ),
              maxLines: 1,
              minFontSize: FontSize.SMALLER.value,
              maxFontSize: FontSize.MESSAGE.value,
            ),
          ],
        ),
      ),
    );
  }
}
