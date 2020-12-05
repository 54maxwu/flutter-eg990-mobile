import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:provider/provider.dart';

enum AppBarActionType { MESSAGES, SETTINGS, SEARCH, TUTORIAL, NONE }

class ScreenMenuBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _ScreenMenuBarState createState() => _ScreenMenuBarState();

  @override
  Size get preferredSize => Size(Global.device.width, Global.APP_MENU_HEIGHT);
}

class _ScreenMenuBarState extends State<ScreenMenuBar> {
  List<ReactionDisposer> _disposers;
  MainScreenProvider _screenProvider;

  MainScreenAppBarTypes _barType;
  AppBarActionType _actionType;

  bool get showBackAction => _barType.index > 2;

  @override
  void didUpdateWidget(ScreenMenuBar oldWidget) {
    // update app bar when language changed
    // if (_disposers != null) {
    //   _disposers.forEach((d) => d());
    //   _disposers.clear();
    //   _disposers = null;
    // }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _screenProvider = null;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    try {
      _disposers.forEach((d) => d());
      _disposers.clear();
      _disposers = null;
    } on Exception {}
    super.dispose();
  }

  AppBarActionType setActionType(MainScreenAppBarTypes type) {
    switch (type) {
      case MainScreenAppBarTypes.LOGO_AND_MESSAGE_CENTER:
        return AppBarActionType.MESSAGES;
      case MainScreenAppBarTypes.TITLE_AND_SETTINGS:
        return AppBarActionType.SETTINGS;
      case MainScreenAppBarTypes.BACK_TITLE_SEARCH:
        return AppBarActionType.SEARCH;
      case MainScreenAppBarTypes.BACK_TITLE_TUTORIAL:
        return AppBarActionType.TUTORIAL;
      default:
        return AppBarActionType.NONE;
    }
  }

  void initDisposers() {
    _disposers = [
      reaction(
        (_) => _screenProvider.getPageInfo,
        (RouteInfo page) {
          if (mounted && _barType != page.appBarType) {
            setState(() {
              _barType = page.appBarType;
              _actionType = setActionType(page.appBarType);
            });
          }
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _screenProvider ??= Provider.of<MainScreenProvider>(context);
    _barType ??= _screenProvider.getPageInfo.appBarType;
    _actionType ??= setActionType(_barType);
    if (_disposers == null) initDisposers();
    return AppBar(
      /// App bar Icon
      titleSpacing: 0,
      centerTitle: false,
      elevation: 0.0,
      title: (_barType == MainScreenAppBarTypes.LOGO_AND_MESSAGE_CENTER)
          ? Container(
              width: Global.device.width * 0.2,
              height: Global.APP_MENU_HEIGHT,
              child: Image.asset(Res.icon_bar_logo, scale: 2.0))
          : SizedBox.shrink(),

      /// Appbar Title
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: SizedBox(
          width: Global.device.width * 0.5,
          child: AutoSizeText(
            context.select<MainScreenProvider, String>((value) {
              debugPrint('debug app bar title: ${value.getPageInfo.id}');
              return value.getPageInfo.pageTitle;
            }),
            maxLines: 1,
            minFontSize: FontSize.NORMAL.value,
            maxFontSize: FontSize.SUBTITLE.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
        titlePadding: EdgeInsetsDirectional.only(
          bottom: Global.APP_MENU_HEIGHT / 4,
        ),
      ),

      /// App bar Left Actions
      leading: (!showBackAction)
          ? null
          : IconButton(
              icon:
                  Icon(Icons.arrow_back, color: themeColor.drawerIconSubColor),
              tooltip: localeStr.actionBack,
              onPressed: () {
                Future.delayed(
                    Duration(milliseconds: 100), () => AppNavigator.back());
              },
            ),

      /// App bar Right Actions
      actions: <Widget>[
        if (_actionType == AppBarActionType.SEARCH)
          IconButton(
            icon: Icon(Icons.search, color: themeColor.drawerIconSubColor),
            tooltip: localeStr.actionSearch,
            onPressed: () => callToastInfo(localeStr.workInProgress),
          ),
        if (_actionType == AppBarActionType.TUTORIAL)
          GestureDetector(
            onTap: () => callToastInfo(localeStr.workInProgress),
            child: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Row(
                children: [
                  Text(
                    localeStr.actionHelp,
                    style: TextStyle(fontSize: FontSize.MESSAGE.value),
                  ),
                  Container(
                      height: FontSize.SUBTITLE.value * 1.5,
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(Res.icon_colored_help)),
                ],
              ),
            ),
          ),
        if (_actionType == AppBarActionType.SETTINGS)
          IconButton(
            icon: Icon(Icons.settings, color: themeColor.drawerIconSubColor),
            tooltip: localeStr.actionSetting,
            onPressed: () => callToastInfo(localeStr.workInProgress),
          ),
        if (_actionType == AppBarActionType.MESSAGES ||
            _actionType == AppBarActionType.SETTINGS)
          IconButton(
            icon: Image.asset(Res.icon_colored_message, scale: 1.75),
            tooltip: localeStr.actionNotify,
            onPressed: () => AppNavigator.navigateTo(RoutePage.notice_board),
          ),
      ],
    );
  }
}
