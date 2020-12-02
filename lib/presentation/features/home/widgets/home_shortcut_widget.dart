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
  HomeShortcutWidget({Key key}) : super(key: key);

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

  UserInfoStore _infoStore;
  HomeDisplaySizeCalc _display;
  Widget _shortcutWidget;

  Function onClickShortcut(ShortcutItem shortcut) => () {
        if (shortcut.value.route != null) {
          if (shortcut.value.isUserOnly && !_infoStore.hasUser) {
            callToastInfo(localeStr.messageErrorNotLogin);
          } else {
            AppNavigator.navigateTo(shortcut.value.route);
          }
        } else {
          callToastInfo(localeStr.workInProgress);
        }
      };

  List<ReactionDisposer> _disposers;

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  List<ReactionDisposer> initDisposer() {
    if (_infoStore == null) return null;
    return [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _infoStore.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _infoStore.askRecheckInfo,
        // Run some logic with the content of the observed field
        (check) {
          if (mounted && check) {
            Future.delayed(Duration(milliseconds: 200), () {
              setState(() {});
              _infoStore.setRecheck = false;
            });
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _infoStore ??= Provider.of<MainScreenProvider>(context).userInfoStore;
    _disposers ??= initDisposer();
    _display ??= Provider.of<HomeDisplayProvider>(context).calc;
    _shortcutWidget ??= _buildShortcuts();
    return Container(
      height: _display.shortcutMaxHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!_infoStore.hasUser)
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => AppNavigator.navigateTo(RoutePage.login),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      '您還未登陸',
                      style: TextStyle(
                        color: themeColor.defaultTextColor,
                        fontSize: FontSize.MESSAGE.value,
                      ),
                      minFontSize: FontSize.SMALLER.value,
                      maxFontSize: FontSize.TITLE.value,
                    ),
                    AutoSizeText(
                      '請先登錄/註冊後查看',
                      style: TextStyle(
                        color: themeColor.defaultHintColor,
                        fontSize: FontSize.NORMAL.value,
                      ),
                      minFontSize: FontSize.SMALL.value,
                      maxFontSize: FontSize.MESSAGE.value,
                    ),
                  ],
                ),
              ),
            ),
          if (_infoStore.hasUser)
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => _infoStore.getUserCredit(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      _infoStore.userName,
                      style: TextStyle(
                        color: themeColor.defaultTextColor,
                        fontSize: FontSize.MESSAGE.value,
                      ),
                      minFontSize: FontSize.SMALLER.value,
                      maxFontSize: FontSize.TITLE.value,
                    ),
                    Observer(
                      builder: (_) => AutoSizeText(
                        _infoStore.userCredit,
                        style: TextStyle(
                          color: themeColor.defaultHintColor,
                          fontSize: FontSize.NORMAL.value,
                        ),
                        minFontSize: FontSize.SMALL.value,
                        maxFontSize: FontSize.MESSAGE.value,
                      ),
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
      height: _display.shortcutMaxHeight - 8.0,
      child: GestureDetector(
        onTap: onClickShortcut(item),
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
                      size: _display.shortcutMaxIconSize,
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
