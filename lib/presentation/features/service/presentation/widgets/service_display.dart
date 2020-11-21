import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_eg990_mobile/application/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/cached_network_image.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/features/service/data/model/service_model.dart';
import 'package:flutter_eg990_mobile/presentation/router/app_navigator_export.dart';
import 'package:flutter_eg990_mobile/res.dart';

enum _ButtonType { OPEN, COPY }

class ServiceDisplay extends StatelessWidget {
  final ServiceModel data;

  ServiceDisplay(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: Global.device.featureContentHeight,
        maxWidth: Global.device.width,
      ),
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage(Res.wallpaper), fit: BoxFit.fill)),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  child: Container(
                      height: 24.0,
                      width: 6.0,
                      color: themeColor.defaultPrimaryColor)),
              Text(localeStr.serviceRouteHint,
                  style: TextStyle(
                      fontSize: FontSize.MESSAGE.value,
                      color: themeColor.defaultTextColor)),
            ],
          ),
          _buildBox(
              iconData: IconCode.csService,
              title: localeStr.serviceTitleCustomerService,
              content: localeStr.serviceDescCustomerService,
              data: data.cs,
              buttonType: _ButtonType.OPEN),
          if (data.mail.isNotEmpty)
            _buildBox(
                iconData: IconCode.csEmail,
                title: localeStr.serviceTitleEmail,
                content: data.mail,
                data: data.mail,
                buttonType: _ButtonType.COPY),
          if (data.phone.isNotEmpty)
            _buildBox(
                iconData: IconCode.csPhone,
                title: localeStr.serviceTitlePhone,
                content: data.phone,
                data: data.phone,
                buttonType: _ButtonType.COPY),
          if (data.zalo.isNotEmpty)
            _buildBox(
                iconData: IconCode.csZalo,
                title: localeStr.serviceTitleZalo,
                content: data.zalo,
                data: data.zalo,
                buttonType: _ButtonType.COPY),
          if (data.line.isNotEmpty)
            _buildBox(
                imgUrl: 'images/icon_line.png',
                title: localeStr.serviceTitleLine,
                content: data.line,
                data: data.line,
                buttonType: _ButtonType.COPY),
          if (data.fb.isNotEmpty)
            _buildBox(
                iconData: IconCode.csFacebook,
                title: localeStr.serviceTitleFacebook,
                content: data.fb,
                data: data.fb,
                buttonType: _ButtonType.OPEN),
          _buildBox(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Zalo QRCODE',
                          style: TextStyle(
                              fontSize: FontSize.MESSAGE.value,
                              color: themeColor.defaultTextColor)),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          height: 144,
                          width: 144,
                          child: networkImageBuilder(data.zaloPic)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('App QRCODE',
                          style: TextStyle(
                              fontSize: FontSize.MESSAGE.value,
                              color: themeColor.defaultTextColor)),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          height: 144,
                          width: 144,
                          child: networkImageBuilder(data.appPic)),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text(localeStr.serviceButtonContact,
                  style: TextStyle(fontSize: FontSize.MESSAGE.value)),
              onPressed: () {
                // AppNavigator.navigateTo(RoutePage.serviceWeb,
                //     arg: WebRouteArguments(
                //         startUrl: data.cs, hideHtmlBars: true));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBox({
    IconData iconData,
    String imgUrl,
    String title,
    String content,
    String data,
    _ButtonType buttonType,
    Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: themeColor.defaultLayeredBackgroundColor,
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(12.0),
        child: child ??
            Row(
              children: [
                if (iconData != null)
                  Icon(iconData,
                      color: themeColor.defaultBorderColor, size: 30),
                if (iconData == null && imgUrl != null)
                  SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: networkImageBuilder(imgUrl)),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                        height: 42.0,
                        width: 1.0,
                        color: themeColor.navigationColorFocus)),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(title),
                      Text(content),
                    ],
                  ),
                ),
                RaisedButton(
                  color: themeColor.defaultLayeredBackgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: themeColor.defaultMarqueeBarColor),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: (buttonType == _ButtonType.OPEN)
                          ? localeStr.btnGo
                          : localeStr.btnCopy,
                      style: TextStyle(
                        fontSize: (Global.lang == 'vi')
                            ? FontSize.SUBTITLE.value
                            : FontSize.MESSAGE.value,
                        color: themeColor.defaultMarqueeBarColor,
                      ),
                    ),
                  ),
                  onPressed: () {
                    debugPrint('button: $title, data: $data');
                    // if (buttonType == _ButtonType.COPY) {
                    //   Clipboard.setData(new ClipboardData(text: data))
                    //       .whenComplete(() => callToast(localeStr.messageCopy));
                    // } else {
                    //   AppNavigator.navigateTo(RoutePage.serviceWeb,
                    //       arg: WebRouteArguments(
                    //           startUrl: data, hideHtmlBars: true));
                    // }
                  },
                )
              ],
            ),
      ),
    );
  }
}
