import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/state/event_store.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/widgets/ad_dialog.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'feature_screen_inherited_widget.dart';
import 'screen_menu_bar_action.dart';
import 'screen_menu_lang_widget.dart';

///@author H.C.CHIANG
///@version 2020/2/26
class ScreenMenuBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _ScreenMenuBarState createState() => _ScreenMenuBarState();

  @override
  Size get preferredSize => Size(Global.device.width, Global.APP_MENU_HEIGHT);
}

class _ScreenMenuBarState extends State<ScreenMenuBar> {
  FeatureScreenInheritedWidget _viewState;
  List<ReactionDisposer> _disposers;
  EventStore _eventStore;

  bool _hideActions = false;
  bool _hideLangOption = false;

  void initDisposers() {
    _disposers = [
      reaction(
          // Observe in page
          // Tell the reaction which observable to observe
          (_) => _viewState.store.pageInfo.hideLanguageOption,
          // Run some logic with the content of the observed field
          (bool disable) {
        if (disable != _hideLangOption) {
          if (mounted) {
            setState(() {
              _hideLangOption = disable;
            });
          } else {
            _hideLangOption = disable;
          }
        }
      }),
      reaction(
          // Observe in page
          // Tell the reaction which observable to observe
          (_) => _viewState.store.pageInfo.hideAppbarActions,
          // Run some logic with the content of the observed field
          (bool hide) {
        if (hide != _hideActions) {
          if (mounted) {
            setState(() {
              _hideActions = hide;
            });
          } else {
            _hideActions = hide;
          }
        }
      }),
    ];
  }

  @override
  void didUpdateWidget(ScreenMenuBar oldWidget) {
    _viewState = null;
    _eventStore = null;
    if (_disposers != null) {
      _disposers.forEach((d) => d());
      _disposers.clear();
      _disposers = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _viewState ??= FeatureScreenInheritedWidget.of(context);
    _eventStore ??= _viewState?.eventStore;
    if (_disposers == null) initDisposers();
    return AppBar(
      /* App bar Icon */
      title: Container(
          width: Global.device.width * 0.225,
          height: Global.APP_MENU_HEIGHT,
          child: Image.asset(Res.icon_bar_logo, scale: 2.5)),
      titleSpacing: 0,
      centerTitle: false,
      /* Appbar Title */
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: SizedBox(
          width: Global.device.width * 0.275,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Observer(builder: (_) {
                final page = _viewState.store.pageInfo ?? RoutePage.home.value;
                return AutoSizeText.rich(
                  TextSpan(
                    text: (page.id == RouteEnum.HOME) ? '' : page.id.title,
                    style: TextStyle(fontSize: FontSize.MESSAGE.value),
                  ),
                  maxLines: (Global.lang == 'zh') ? 1 : 2,
                  maxFontSize: FontSize.MESSAGE.value,
                  minFontSize: FontSize.SMALLER.value,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                );
              }),
            ],
          ),
        ),
        titlePadding: EdgeInsetsDirectional.only(
          start: Global.APP_MENU_HEIGHT / 3,
        ),
      ),
      /* App bar Left Actions */
      leading: Observer(
        builder: (_) {
          if (_viewState.store.showMenuDrawer) {
            return IconButton(
              icon: Icon(Icons.menu, color: themeColor.drawerIconColor),
              tooltip: localeStr.btnMenu,
              onPressed: () {
                _viewState.scaffoldKey.currentState.openDrawer();
              },
            );
          } else {
            return IconButton(
              icon:
                  Icon(Icons.arrow_back, color: themeColor.drawerIconSubColor),
              tooltip: localeStr.btnBack,
              onPressed: () {
                Future.delayed(
                    Duration(milliseconds: 100), () => AppNavigator.back());
              },
            );
          }
        },
      ),
      /* App bar Right Actions */
      actions: <Widget>[
        if (_eventStore != null)
          Container(
//            padding: const EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Transform.scale(
              scale: 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36.0),
                child: GestureDetector(
                  onTap: () {
                    if (_eventStore.canShowAds) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => new AdDialog(
                          ads: _eventStore.ads,
                          initCheck: _eventStore.checkSkip,
                          onClose: (skipNextTime) {
                            debugPrint('ads dialog close, skip=$skipNextTime');
                            _eventStore.setSkipAd(skipNextTime);
                            _eventStore.adsDialogClose();
                          },
                        ),
                      );
                    }
                  },
                  child: networkImageBuilder(
                    'images/AD_ICON2.png',
                    imgScale: 3.0,
                  ),
                ),
              ),
            ),
          ),
        Visibility(
          visible: !_hideLangOption,
          maintainState: true,
          child: Align(
            alignment: Alignment.center,
            child: ScreenMenuLangWidget(),
          ),
        ),
        Visibility(
          visible: !_hideActions,
          maintainState: true,
          child: Align(
            alignment: Alignment.center,
            child: ScreenMenuBarAction(_viewState),
          ),
        ),
      ],
    );
  }
}
