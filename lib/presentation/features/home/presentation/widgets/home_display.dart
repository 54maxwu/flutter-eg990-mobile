import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/widgets/home_shortcut_widget.dart';
import 'package:flutter_eg990_mobile/presentation/features/user/data/entity/login_status.dart';
import 'package:flutter_eg990_mobile/presentation/features/user/presentation/state/user_info_store.dart';
import 'package:provider/provider.dart';

import 'home_display_banner.dart';
import 'home_display_marquee.dart';
import 'home_display_provider.dart';

class HomeDisplay extends StatefulWidget {
  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  final GlobalKey<HomeDisplayBannerState> _bannerKey =
      new GlobalKey(debugLabel: 'banners');
  final GlobalKey<HomeDisplayBannerState> _marqueeKey =
      new GlobalKey(debugLabel: 'marquees');
  final GlobalKey<HomeDisplayBannerState> _shortcutKey =
      new GlobalKey(debugLabel: 'shortcuts');

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
          SizedBox(
            width: Global.device.width - 8.0,
            child: Selector<MainScreenProvider, bool>(
              selector: (_, provider) => provider.userInfoStore.loggedIn,
              builder: (_, loggedIn, __) {
                return HomeShortcutWidget(
                    key: _shortcutKey, loggedIn: loggedIn);
              },
            ),
          ),
        ],
      ),
    );
  }
}
