import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator_export.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadAreaRoute extends StatelessWidget {
  final List<String> appImages = [
    '/images/download/cgp_and.jpg',
    '/images/download/cgp_ios.jpg',
    '/images/download/dns_and.jpg',
    '/images/download/dns_ios.jpg',
  ];
  final List<String> appLabels = [
    localeStr.downloadAndroidCgpay,
    localeStr.downloadIosCgpay,
    localeStr.downloadAndroidDns,
    localeStr.downloadIosDns,
  ];
  final List<String> appHints = [
    localeStr.downloadHintPlatformAndroid,
    localeStr.downloadHintPlatformIos,
  ];
  final List<String> appLinks = [
    'https://mobile.cgpay.io/cgpdownload.aspx?type=android',
    'https://mobile.cgpay.io/cgpdownload.aspx?type=IOS',
    'https://play.google.com/store/apps/details?id=com.cloudflare.onedotonedotonedotone',
    'https://itunes.apple.com/us/app/1-1-1-1-faster-internet/id1423538627?mt=8',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        debugPrint('pop download route');
        AppNavigator.back();
        return Future(() => true);
      },
      child: Scaffold(
        body: (appLinks.length != appImages.length)
            ? WarningDisplay(
                message: Failure.internal(
                        FailureCode(type: FailureType.DOWNLOAD_AREA))
                    .message,
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                child: ListView.builder(
                  itemCount: appLinks.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '${appLabels[index]}\n',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    TextSpan(
                                      text: (index % 2 == 0)
                                          ? appHints[0]
                                          : appHints[1],
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 120,
                              maxWidth: Global.device.width - 32,
                            ),
                            child: Center(
                              child: GestureDetector(
                                child: networkImageBuilder(appImages[index]),
                                onTap: () async {
                                  if (appLinks[index].isNotEmpty) {
                                    String url = appLinks[index];
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      callToastError(
                                          localeStr.messageErrorLink(url));
                                    }
                                  }
                                },
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
