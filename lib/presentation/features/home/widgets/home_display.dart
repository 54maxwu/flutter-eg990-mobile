import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:provider/provider.dart';

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
                  onClicked: (url) => debugPrint('banner url: $url'),
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
                  onClicked: (url) => debugPrint('marquee url: $url'),
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
}
