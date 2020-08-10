import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/home/data/models/game_category_model.dart';
import 'package:flutter_eg990_mobile/features/home/presentation/widgets/home_display_size_calc.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../state/home_store.dart';
import 'home_display_ad_dialog.dart';
import 'home_display_banner.dart';
import 'home_display_marquee.dart';
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
    if (_store.showAds == false) return;
    Future.delayed(Duration(milliseconds: 500), () {
      if (!mounted)
        showAdsDialog(list);
      else
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => new HomeDisplayAdDialog(
            ads: new List.from(list),
            onClose: (skipNextTime) {
              print('ads dialog close, skip=$skipNextTime');
              showingAds = false;
              _store.setSkipAd(skipNextTime);
              _store.closeAdsDialog();
            },
          ),
        );
    });
  }

  @override
  void initState() {
    _sizeCalc = HomeDisplaySizeCalc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
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
                stream: _store.adsStream,
                initialData: _store.ads ?? [],
                builder: (ctx, snapshot) {
                  if (snapshot.data != null && snapshot.data.isNotEmpty) {
                    print('stream home ads: ${snapshot.data.length}');
                    showingAds = true;
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
                    _bannerWidget = HomeDisplayBanner(banners: banners);
                  }
                  _bannerWidget ??= HomeDisplayBanner();
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
                      _marqueeWidget = HomeDisplayMarquee(marquees: marquees);
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
                      stream: RouterNavigate.routerStreams.recheckUserStream,
                      initialData: false,
                      builder: (context, snapshot) {
//                print('checking shortcut widget: ${getRouteUserStreams.lastUser}');
                        if (_shortcutWidget == null) {
                          _shortcutWidget = HomeShortcutWidget(
                            key: _shortcutWidgetKey,
                            sizeCalc: _sizeCalc,
                          );
                        } else if (snapshot.data) {
                          _shortcutWidgetKey.currentState.updateUser();
                          _store.checkHomeTabs();
                          RouterNavigate.resetCheckUser();
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
//                print('update display tabs: ${snapshot.data}');
                          tabs =
                              new List<GameCategoryModel>.from(snapshot.data);
                          // use different widget to avoid tab controller's dispose error
                          if (tabs.contains(favoriteCategory))
                            _contentWidget = new HomeDisplayUserTabs(
                              tabs: tabs,
                              sizeCalc: _sizeCalc,
                            );
                          else
                            _contentWidget = new HomeDisplayTabs(
                              tabs: tabs,
                              sizeCalc: _sizeCalc,
                            );
                        }
                        _contentWidget ??= HomeDisplayTabs(sizeCalc: _sizeCalc);
                        return _contentWidget;
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
