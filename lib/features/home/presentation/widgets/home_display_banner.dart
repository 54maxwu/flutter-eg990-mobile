import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/home/data/entity/banner_entity.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';

///
/// Create a [Carousel] widget to display banner images
/// @author H.C.CHIANG
/// @version 2020/6/18
///
class HomeDisplayBanner extends StatelessWidget {
  final List<BannerEntity> banners;

  HomeDisplayBanner({this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners != null && banners.isNotEmpty)
      return _buildCarousel();
    else
      return Center(
          child: WarningDisplay(
        message: localeStr.messageErrorNoServerConnection,
      ));
  }

  Widget _buildCarousel() {
    List<int> promoIds = _listPromoIds();
    return Carousel(
      boxFit: BoxFit.fill,
      images: banners
          .map((banner) => networkImageBuilder(
                banner.pic,
                fit: BoxFit.fill,
              ))
          .toList(),
      showIndicator: false,
//      dotSize: 3.0,
//      dotSpacing: 16.0,
//      dotColor: Themes.defaultAccentColor,
//      indicatorBgPadding: 4.0,
//      dotBgColor: Colors.white12,
      borderRadius: false,
      animationDuration: Duration(milliseconds: 2000),
      autoplayDuration: Duration(seconds: 10),
      onImageTap: (index) {
        var id = promoIds[index];
        print('clicked image $index, promoId: $id');
        if (id != -1)
          RouterNavigate.navigateToPage(RoutePage.promo,
              arg: PromoRouteArguments(openPromoId: id));
      },
    );
  }

  List<int> _listPromoIds() {
    try {
      return banners.map((data) {
        if (data.noPromo || data.promoUrl.startsWith('promo') == false)
          return -1;
        return data.promoUrl.split('/').last.strToInt;
      }).toList();
    } on Exception catch (e) {
      MyLogger.error(
        msg: 'map banners promo id has exception: $e',
        tag: 'HomeBannerDisplay',
      );
      return [];
    }
  }
}
