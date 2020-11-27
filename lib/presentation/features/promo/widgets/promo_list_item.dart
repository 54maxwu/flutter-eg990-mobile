import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/sector/promo/promo_entity.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/network_image.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';

class PromoListItem extends StatelessWidget {
  final PromoEntity promo;

  const PromoListItem({Key key, @required this.promo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppNavigator.navigateTo(
        RoutePage.promo_detail,
        arg: PromoDetailPageArguments(promo: promo),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Global.device.width,
          maxHeight: Global.device.width * 0.45,
        ),
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: themeColor.defaultBackgroundColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            NetworkImageBuilder(
              promo.bannerMobile,
              addLoadingIcon: true,
              fit: BoxFit.fill,
              roundCorner: true,
            ),
            Positioned(
              bottom: 10.0,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: FontSize.MESSAGE.value * 1.5,
                  minWidth: FontSize.MESSAGE.value * 13,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: themeColor.secondaryTextColor1,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: themeColor.secondaryTextColor2,
                      fontSize: FontSize.NORMAL.value,
                      fontWeight: FontWeight.w500,
                    ),
                    children: <InlineSpan>[
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.access_time,
                            color: themeColor.secondaryTextColor2,
                            size: FontSize.NORMAL.value,
                          ),
                        ),
                      ),
                      // TextSpan(text: '2020-11-25 至 2020-12-30'),
                      TextSpan(text: promo.activeDate.trim()),
                    ],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
