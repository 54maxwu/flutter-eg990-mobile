import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebRoute extends StatefulWidget {
  final String startUrl;
  final bool hideBars;

  const WebRoute({@required this.startUrl, this.hideBars = false});

  @override
  _WebRouteState createState() => _WebRouteState();
}

class _WebRouteState extends State<WebRoute> {
  WebViewController _controller;
  num _stackToView = 1;

  @override
  void initState() {
    super.initState();
    debugPrint('opening url: ${widget.startUrl}');
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 15), () {
      if (_stackToView == 1) {
        _controller.loadUrl(
          Uri.dataFromString(
            '${localeStr.messageErrorLoadingPay}',
            mimeType: Global.WEB_MIMETYPE,
            encoding: Global.webEncoding,
          ).toString(),
        );
      }
    });
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop web route');
        if (AppNavigator.isWebRoute) {
          Future.delayed(
            Duration(milliseconds: 200),
            () => AppNavigator.back(),
          );
        }
        return Future(() => true);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _stackToView,
          children: <Widget>[
            Container(
              child: WebView(
//            initialUrl: widget.startUrl,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) async {
                  _controller = controller;
//                  if (widget.startUrl == Global.currentService)
//                    _controller.loadUrl(widget.startUrl +
//                        '?token=${_jwtInterface?.token ?? ''}');
//                  else
                  _controller.loadUrl(widget.startUrl);
                },
                onPageStarted: (String url) {
                  debugPrint('start loading: $url');
                },
                onPageFinished: (String url) async {
                  if (_stackToView == 1) {
                    setState(() {
                      _stackToView = 0;
                    });
                  }
                  if (widget.hideBars) {
                    debugPrint('hiding web page bars');
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('el-header')[0].style.display='none';");
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('el-footer')[0].style.display='none';");
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('footer_bg')[0].style.display = 'none';");
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('header_bg')[0].style.display = 'none';");
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('aside_bars')[0].style.display='none';");
                    _controller.evaluateJavascript(
                        "document.getElementsByClassName('page_title')[0].remove();");
                  }

                  debugPrint('web page loaded: $url');
                  if (url.isUrl == false) return;

                  String pageTitle = await _controller.getTitle();
                  debugPrint('web page title: $pageTitle');
                  //TODO check the normal page title or 404
                  // Error 500 Title: 500 Internal Server Error
                  if (pageTitle.contains('Error') ||
                      pageTitle.contains('Exception')) {
                    if (pageTitle.startsWith('500')) {
                      _controller.loadUrl(Uri.dataFromString(
                        pageTitle,
                        mimeType: Global.WEB_MIMETYPE,
                        encoding: Global.webEncoding,
                      ).toString());
                    }
                  }
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
              ),
            ),
            Container(
              color: themeColor.defaultBackgroundColor,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          debugPrint('JS channel: $message');
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
