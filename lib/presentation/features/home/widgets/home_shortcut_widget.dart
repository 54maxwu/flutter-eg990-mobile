import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';

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
            callToastInfo(localeStr.hintActionLogin);
          } else {
            AppNavigator.navigateTo(shortcut.value.route);
          }
        } else {
          callToastInfo(localeStr.msgWorkInProgress);
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
                    Row(
                      children: [
                        AutoSizeText(
                          _infoStore.userName,
                          style: TextStyle(
                            color: themeColor.defaultHintColor,
                            fontSize: FontSize.MESSAGE.value,
                          ),
                          minFontSize: FontSize.SMALLER.value,
                          maxFontSize: FontSize.TITLE.value,
                        ),
                        Container(
                          height: FontSize.MESSAGE.value,
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset(
                            'assets/images/badges/vip_icon_${_infoStore.userLevel}.png',
                          ),
                        ),
                      ],
                    ),
                    Observer(
                      builder: (_) => AutoSizeText(
                        _infoStore.userCredit,
                        style: TextStyle(
                          color: themeColor.defaultTextColor,
                          fontSize: FontSize.TITLE.value,
                          fontWeight: FontWeight.w600,
                        ),
                        minFontSize: FontSize.NORMAL.value,
                        maxFontSize: FontSize.HEADER.value,
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                child: (item.value.assetPath.isNotEmpty)
                    ? Image.asset(item.value.assetPath, scale: 1.75)
                    : Icon(
                        item.value.iconData,
                        color: themeColor.homeBoxIconColor,
                        size: _display.shortcutIconSize,
                      ),
              ),
            ),
            AutoSizeText(
              label,
              style: TextStyle(
                fontSize: FontSize.MESSAGE.value,
                color: themeColor.homeBoxIconTextColor,
              ),
              maxLines: 1,
              minFontSize: FontSize.SMALLER.value,
              maxFontSize: FontSize.SUBTITLE.value,
            ),
          ],
        ),
      ),
    );
  }
}
