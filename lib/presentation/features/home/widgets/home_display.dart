import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';

import 'home_display_banner.dart';
import 'home_display_marquee.dart';
import 'home_display_provider.dart';
import 'home_display_tabs.dart';
import 'home_shortcut_widget.dart';

class HomeDisplay extends StatefulWidget {
  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  final GlobalKey<HomeDisplayBannerState> _bannerKey =
      new GlobalKey(debugLabel: 'banners');
  final GlobalKey<HomeDisplayMarqueeState> _marqueeKey =
      new GlobalKey(debugLabel: 'marquees');
  final GlobalKey<HomeShortcutWidgetState> _shortcutKey =
      new GlobalKey(debugLabel: 'shortcuts');
  final GlobalKey<HomeDisplayTabsState> _tabviewKey =
      new GlobalKey(debugLabel: 'tabview');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        children: [
          ///
          /// BANNER
          ///
          SizedBox(
            width: Global.device.width - 8.0,
            height: context.select<HomeDisplayProvider, double>(
                (provider) => provider.calc.bannerHeight),
            child: Selector<HomeDisplayProvider, List>(
              selector: (_, provider) => provider.homeStore.banners,
              builder: (_, banners, __) {
                return HomeDisplayBanner(
                  key: _bannerKey,
                  banners: banners,
                  onClicked: (url) => _widgetUrlCheck(context, url),
                );
              },
            ),
          ),

          ///
          /// MARQUEE
          ///
          SizedBox(
            width: Global.device.width - 8.0,
            height: context.select<HomeDisplayProvider, double>(
                (provider) => provider.calc.marqueeHeight),
            child: Selector<HomeDisplayProvider, List>(
              selector: (_, provider) => provider.homeStore.marquees,
              builder: (_, marquees, __) {
                return HomeDisplayMarquee(
                  key: _marqueeKey,
                  marquees: marquees,
                  onClicked: (url) => _widgetUrlCheck(context, url),
                );
              },
            ),
          ),

          ///
          /// SHORTCUTS
          ///
          SizedBox(
            width: Global.device.width - 8.0,
            child: HomeShortcutWidget(key: _shortcutKey),
          ),

          ///
          /// GAMES
          ///
          Container(
            width: Global.device.width - 8.0,
            height: context.select<HomeDisplayProvider, double>(
                (provider) => provider.calc.pageMaxHeight),
            child: Selector<HomeDisplayProvider, List>(
              selector: (_, provider) => provider.homeStore.homeTabs,
              builder: (_, tabs, __) {
                if (tabs != null) {
                  return HomeDisplayTabs(key: _tabviewKey, tabs: tabs);
                } else {
                  return LoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _widgetUrlCheck(BuildContext ctx, String url) {
    debugPrint('tapped widget url: $url');
    String fixUrl;
    if (url.contains(Global.DOMAIN_NAME)) {
      fixUrl = url.substring(
          url.indexOf(Global.DOMAIN_NAME) + Global.DOMAIN_NAME.length);
    } else if (!url.startsWith('/')) {
      fixUrl = '/$url';
    } else {
      fixUrl = url;
    }
    _widgetUrlNavigate(
      ctx,
      url.contains('/api/open/'),
      fixUrl.replaceAll('/api/open/', ''),
    );
  }

  void _widgetUrlNavigate(BuildContext ctx, bool openGame, String url) {
    debugPrint('home widget url: $url, isGame: $openGame');
    bool hasUser = context.read<MainScreenProvider>().userInfoStore.hasUser;
    if (openGame) {
      if (!hasUser) {
        callToastInfo(localeStr.hintActionLogin);
      } else {
        bool success = Provider.of<HomeDisplayProvider>(ctx).openGame(url);
        if (!success) {
          callToast(localeStr.msgUrlNavNotSupported);
          MyLogger.debug(msg: 'Found unsupported Game URL: $url');
        }
      }
    } else {
      callToast(localeStr.msgUrlNavNotSupported);
    }

    //  /// Show game category view
    // } else if (url.startsWith('/gamelist/')) {
    //   callToast(localeStr.msgUrlNavNotSupported);
    //   MyLogger.debug(msg: 'Found unsupported Game URL: $url');
    //
    //   /// Jump to promo page with promo id if provided
    // } else if (url.startsWith('/promo/')) {
    //   int itemId = url.substring(url.lastIndexOf('/') + 1, url.length).strToInt;
    //   debugPrint('url promo id: $itemId');
    //   AppNavigator.navigateTo(
    //     RoutePage.promo,
    //     arg: (itemId > 0) ? PromoDetailPageArguments(promo: itemId) : null,
    //   );
    //
    //   /// Jump to store page with product id if provided
    //   } else if (url.startsWith('/mall/')) {
    //     int itemId = url.substring(url.lastIndexOf('/') + 1, url.length).strToInt;
    //
    //     if (!getAppGlobalStreams.hasUser) {
    //       callToastInfo(localeStr.messageErrorNotLogin);
    //       return;
    //     }
    //     debugPrint('url mall id: $itemId');
    //     AppNavigator.navigateTo(
    //       RoutePage.sideStore,
    //       arg: (itemId > 0) ? StoreRouteArguments(showProductId: itemId) : null,
    //     );
    //
    //   /// Jump to route page if path name exist
    // } else {
    //   RoutePage newRoute = url.urlToRoutePage;
    //   debugPrint('checking url to app route: $newRoute');
    //   if (newRoute != null) {
    //     AppNavigator.navigateTo(newRoute);
    //   } else {
    //     callToast(localeStr.msgUrlNavNotSupported);
    //     MyLogger.debug(msg: 'Found unsupported Route URL: $url');
    //   }
    // }
  }
}
