import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/banner/banner_entity.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/customize_carousel.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_display_widget.dart';

typedef OnBannerClicked = void Function(String);

class HomeDisplayBanner extends StatefulWidget {
  final List<BannerEntity> banners;
  final OnBannerClicked onClicked;

  HomeDisplayBanner({Key key, this.banners, this.onClicked}) : super(key: key);

  @override
  HomeDisplayBannerState createState() => HomeDisplayBannerState();
}

class HomeDisplayBannerState extends State<HomeDisplayBanner> {
  final GlobalKey<CustomizeCarouselState> _carouselKey =
      new GlobalKey(debugLabel: 'carousel');

  List<String> bannerUrls;

  @override
  void initState() {
    bannerUrls = _listBannerUrls();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeDisplayBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners == null || widget.banners.isEmpty) {
      return Container(
        color: themeColor.defaultBackgroundColor,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 34.0),
        child: WarningDisplay(
          message: localeStr.messageErrorNoServerConnection,
          widthFactor: 1,
          largerText: true,
          highlight: true,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CustomizeCarousel(
          key: _carouselKey,
          boxFit: BoxFit.fill,
          images: widget.banners
              .map((banner) =>
                  NetworkImageBuilder(banner.pic, fit: BoxFit.fill, scale: 1.5))
              .toList(),
          showIndicator: true,
          indicatorSize: 24.0,
          indicatorColor: themeColor.defaultAccentColor,
          indicatorPadding: const EdgeInsets.only(bottom: 12.0),
          animationDuration: Duration(milliseconds: 1000),
          autoplayDuration: Duration(seconds: 6),
          jumpOnEndPage: true,
          onImageTap: (index) {
            String url = bannerUrls[index];
            debugPrint('clicked image $index, url: $url');
            // if (url.contains(Global.DOMAIN_NAME)) {
            //   if (widget.onClicked != null) {
            //     widget.onClicked(url);
            //   }
            // } else if (url.isUrl) {
            //   launch(url);
            // }
          },
        ),
      ),
    );
  }

  List<String> _listBannerUrls() {
    try {
      return widget.banners?.map((data) {
            return data.promoUrl;
          })?.toList() ??
          new List();
    } on Exception catch (e) {
      MyLogger.error(
        msg: 'map banners jump url has exception: $e',
        tag: 'HomeBannerDisplay',
      );
      return [];
    }
  }
}
