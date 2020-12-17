import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/features/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../../data/model/service_model.dart';

enum _ButtonType { OPEN, COPY }

class ServiceDisplay extends StatelessWidget {
  final ServiceModel data;

  ServiceDisplay(this.data);

  @override
  Widget build(BuildContext context) {
    bool addAppQr = data.appUrl.isNotEmpty && data.appPic.isNotEmpty;
    bool addLineQr = data.line.isNotEmpty && data.linePic.isNotEmpty;
    bool addZaloQr = data.zalo.isNotEmpty && data.zaloPic.isNotEmpty;
    return Container(
      constraints: BoxConstraints(
        maxHeight: Global.device.featureContentHeight,
        maxWidth: Global.device.width,
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Res.wallpaper), fit: BoxFit.fill)),
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
                      color: themeColor.defaultTextColor)),
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
          if (data.fb.isNotEmpty)
            _buildBox(
                iconData: IconCode.csFacebook,
                title: localeStr.serviceTitleFacebook,
                content: data.fb,
                data: data.fb,
                buttonType: _ButtonType.OPEN),
          if (data.line.isNotEmpty)
            _buildBox(
                imgUrl: Res.iconLine,
                title: localeStr.serviceTitleLine,
                content: data.line,
                data: data.line,
                buttonType: _ButtonType.COPY),
          if (data.skype.isNotEmpty)
            _buildBox(
                iconData: IconCode.csSkype,
                title: localeStr.serviceTitleSkype,
                content: data.skype,
                data: data.skype,
                buttonType: _ButtonType.COPY),
          if (data.zalo.isNotEmpty)
            _buildBox(
                iconData: IconCode.csZalo,
                title: localeStr.serviceTitleZalo,
                content: data.zalo,
                data: data.zalo,
                buttonType: _ButtonType.COPY),
          if (data.qq.isNotEmpty)
            _buildBox(
                iconData: IconCode.csQQ,
                title: 'QQ',
                content: data.qq,
                data: data.qq,
                buttonType: _ButtonType.COPY),
          if (addAppQr || addLineQr || addZaloQr)
            _buildBox(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (addLineQr)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Line QRCODE',
                              style: TextStyle(
                                  fontSize: FontSize.MESSAGE.value,
                                  color: themeColor.defaultTextColor)),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              constraints: BoxConstraints.tight(
                                  Size(144, 144) * Global.device.widthScale),
                              child: networkImageBuilder(data.linePic)),
                        ],
                      ),
                    ),
                  if (addLineQr) SizedBox(width: 16.0),
                  if (addZaloQr)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Zalo QRCODE',
                              style: TextStyle(
                                  fontSize: FontSize.MESSAGE.value,
                                  color: themeColor.defaultTextColor)),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              constraints: BoxConstraints.tight(
                                  Size(144, 144) * Global.device.widthScale),
                              child: networkImageBuilder(data.zaloPic)),
                        ],
                      ),
                    ),
                  if (addZaloQr) SizedBox(width: 16.0),
                  if (addAppQr)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('App QRCODE',
                              style: TextStyle(
                                  fontSize: FontSize.MESSAGE.value,
                                  color: themeColor.defaultTextColor)),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              constraints: BoxConstraints.tight(
                                  Size(144, 144) * Global.device.widthScale),
                              alignment: Alignment.center,
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
                  style: TextStyle(fontSize: FontSize.SUBTITLE.value)),
              onPressed: () {
                AppNavigator.navigateTo(RoutePage.serviceWeb,
                    arg: WebRouteArguments(startUrl: data.cs));
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
            color: themeColor.moreGridColor,
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(12.0),
        child: child ??
            Row(
              children: [
                if (iconData != null)
                  Icon(iconData, color: themeColor.navigationColor, size: 30),
                if (iconData == null && imgUrl != null)
                  SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: (imgUrl.startsWith('assets/'))
                          ? Image.asset(imgUrl)
                          : networkImageBuilder(imgUrl)),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                        height: 54.0,
                        width: 2.0,
                        color: themeColor.defaultDividerColor)),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(title),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(content),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: themeColor.moreGridColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: themeColor.navigationColor),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  visualDensity: VisualDensity(vertical: -1.0),
                  child: RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: (buttonType == _ButtonType.OPEN)
                          ? localeStr.btnGo
                          : localeStr.btnCopy,
                      style: TextStyle(
                        fontSize: FontSize.SUBTITLE.value,
                        color: themeColor.navigationColor,
                      ),
                    ),
                  ),
                  onPressed: () {
                    debugPrint('button: $title, data: $data');
                    if (buttonType == _ButtonType.COPY) {
                      Clipboard.setData(new ClipboardData(text: data))
                          .whenComplete(() => callToast(localeStr.messageCopy));
                    } else {
                      AppNavigator.navigateTo(RoutePage.serviceWeb,
                          arg: WebRouteArguments(
                              startUrl: data, hideHtmlBars: true));
                    }
                  },
                )
              ],
            ),
      ),
    );
  }
}