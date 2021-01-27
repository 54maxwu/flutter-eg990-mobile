import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/event/event_inject.dart';
import 'package:flutter_eg990_mobile/features/event/presentation/widgets/ad_dialog.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/routes/home/data/models/game_category_model.dart';
import 'package:flutter_eg990_mobile/features/update/presentation/state/update_store.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../state/home_store.dart';
import 'home_display_banner.dart';
import 'home_display_marquee.dart';
import 'home_display_size_calc.dart';
import 'home_display_tabs.dart';
import 'home_display_user_tabs.dart';
import 'home_shortcut_widget.dart';
import 'home_store_inherit_widget.dart';

class HomeDisplay extends StatefulWidget {
  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  final GlobalKey<HomeShortcutWidgetState> _shortcutWidgetKey =
      new GlobalKey<HomeShortcutWidgetState>();
  final GlobalKey<HomeDisplayTabsState> _tabsWidgetKey =
      new GlobalKey<HomeDisplayTabsState>();

  EventStore _eventStore;
  UpdateStore _updateStore;
  HomeStore _store;
  HomeShortcutWidget _shortcutWidget;
  HomeDisplayBanner _bannerWidget;
  HomeDisplayMarquee _marqueeWidget;
  HomeDisplaySizeCalc _sizeCalc;
  Widget _contentWidget;

  List banners;
  List marquees;
  List tabs;
  bool showingAds = false;

  void showAdsDialog(List list) {
    if (showingAds || AppNavigator.isAtHome) return;
    if (_updateStore.showingUpdateDialog) {
      Future.delayed(Duration(seconds: 2), () {
        showAdsDialog(list);
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        if (!mounted)
          showAdsDialog(list);
        else {
          showingAds = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => new AdDialog(
              ads: new List.from(list),
              initCheck: _eventStore.checkSkip,
              onClose: (skipNextTime) {
                debugPrint('ads dialog close, skip=$skipNextTime');
                showingAds = false;
                _eventStore.setAutoShowAds = false;
                _eventStore.setSkipAd(skipNextTime);
                _eventStore.adsDialogClose();
              },
            ),
          );
        }
      });
    }
  }

  void _widgetUrlNavigate(bool openGame, String url) {
    debugPrint('home widget url:$url, isGame:$openGame');
    if (openGame) {
      final gameUrl = url.substring(url.indexOf('.com/') + 4);
      debugPrint('opening game: $gameUrl');
      if (_store.hasUser) {
        _store.getGameUrl(gameUrl);
      } else {
        callToastInfo(localeStr.messageErrorNotLogin);
      }
    } else if (url.startsWith('/gamelist/')) {
      String className = url.replaceAll('/gamelist/', '').replaceAll('/', '-');
      debugPrint('searching platform name: $className');
      _tabsWidgetKey.currentState?.findPage(className.split('-')[1]);
      _store.showSearchPlatform(className);
    } else if (url.startsWith('/promo/')) {
      int promoId =
          url.substring(url.lastIndexOf('/') + 1, url.length).strToInt;
      debugPrint('url promo id: $promoId');
      AppNavigator.navigateTo(
        RoutePage.promo,
        arg: (promoId > 0) ? PromoRouteArguments(openPromoId: promoId) : null,
      );
    } else {
      RoutePage newRoute = url.urlToRoutePage;
      debugPrint('checking url to app route: $newRoute');
      if (newRoute != null) {
        AppNavigator.navigateTo(newRoute);
      }
    }
  }

  @override
  void initState() {
    _sizeCalc = HomeDisplaySizeCalc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    _eventStore ??= sl.get<EventStore>();
    _updateStore ??= sl.get<UpdateStore>();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(Global.device.width, _sizeCalc.bannerHeight),
          ),
          child: Stack(
            children: [
              StreamBuilder<List>(
                stream: _eventStore.adsStream,
                initialData: _eventStore.ads ?? [],
                builder: (ctx, snapshot) {
                  if (snapshot.data != null &&
                      snapshot.data.isNotEmpty &&
                      _eventStore.autoShowAds &&
                      _eventStore.checkSkip == false) {
                    debugPrint('stream home ads: ${snapshot.data.length}');
                    showAdsDialog(new List.from(snapshot.data));
                  }
                  return SizedBox.shrink();
                },
              ),
              StreamBuilder(
                stream: _store.bannerStream,
                builder: (ctx, _) {
                  if (banners != _store.banners) {
                    banners = _store.banners;
                    _bannerWidget = HomeDisplayBanner(
                      banners: banners,
                      onBannerClicked: (openGame, url) =>
                          _widgetUrlNavigate(openGame, url),
                    );
                  }
                  _bannerWidget ??=
                      HomeDisplayBanner(onBannerClicked: (_, __) {});
                  return _bannerWidget;
                },
              ),
              Positioned(
                bottom: 0,
                child: StreamBuilder(
                  stream: _store.marqueeStream,
                  builder: (ctx, _) {
                    if (marquees != _store.marquees) {
                      marquees = _store.marquees;
                      _marqueeWidget = HomeDisplayMarquee(
                        marquees: marquees,
                        onMarqueeClicked: (url) =>
                            _widgetUrlNavigate(false, url),
                      );
                    }
                    _marqueeWidget ??= HomeDisplayMarquee();
                    return _marqueeWidget;
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints.tight(
            Size(Global.device.width,
                Global.device.featureContentHeight - _sizeCalc.bannerHeight),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (Res.wallpaper.isNotEmpty)
                Image.asset(Res.wallpaper, fit: BoxFit.fill),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 6.0),
                    child: StreamBuilder<bool>(
                      stream: AppNavigator.routerStreams.recheckUserStream,
                      initialData: false,
                      builder: (context, snapshot) {
//                debugPrint('checking shortcut widget: ${getAppGlobalStreams.lastUser}');
                        if (_shortcutWidget == null) {
                          _shortcutWidget = HomeShortcutWidget(
                            key: _shortcutWidgetKey,
                            sizeCalc: _sizeCalc,
                            eventStore: _eventStore,
                          );
                        } else if (snapshot.data) {
                          _shortcutWidgetKey.currentState.updateUser();
                          _store.checkHomeTabs();
                          AppNavigator.resetCheckUser();
                        }
                        return _shortcutWidget;
                      },
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: _store.tabStream,
                      initialData: (_store.hasUser)
                          ? _store.homeUserTabs
                          : _store.homeTabs,
                      builder: (ctx, snapshot) {
                        if (tabs != snapshot.data) {
//                debugPrint('update display tabs: ${snapshot.data}');
                          tabs =
                              new List<GameCategoryModel>.from(snapshot.data);
                          // use different widget to avoid tab controller's dispose error
                          if (tabs.contains(favoriteCategory)) {
                            _contentWidget = new HomeDisplayUserTabs(
                              tabs: tabs,
                              sizeCalc: _sizeCalc,
                            );
                          } else {
                            _contentWidget = new HomeDisplayTabs(
                              key: _tabsWidgetKey,
                              tabs: tabs,
                              sizeCalc: _sizeCalc,
                            );
                          }
                        }
                        _contentWidget ??= HomeDisplayTabs(
                            key: _tabsWidgetKey, sizeCalc: _sizeCalc);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: _contentWidget,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
