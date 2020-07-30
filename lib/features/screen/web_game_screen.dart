import 'package:after_layout/after_layout.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/orientation_helper.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/screen/web_game_screen_store.dart';
import 'package:flutter_ty_mobile/injection_container.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_game_screen_float_button.dart';

class WebGameScreen extends StatefulWidget {
  final String startUrl;

  WebGameScreen({this.startUrl = 'https://eg990.com/'});

  @override
  _WebGameScreenState createState() => _WebGameScreenState();
}

class _WebGameScreenState extends State<WebGameScreen> with AfterLayoutMixin {
  GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(debugLabel: 'webgame');

  WebViewController _controller;
  WebGameScreenStore _store;

  String parsedHtml;
  bool isForm = false;
  bool showButtonHint = true;

  void _returnHome() {
    ScreenNavigate.switchScreen(
      force: true,
      screen: ScreenEnum.Feature,
    );
    _store.stopSensor();
  }

  ///
  /// Used in BB games
  ///
  void _rewriteHtml(String htmlStr) {
    String formStr =
        htmlStr.substring(htmlStr.indexOf('<form'), htmlStr.indexOf('</form>'));
    formStr = formStr.substring(0, formStr.indexOf('>'));
    String formName = formStr
        .substring(formStr.indexOf('name='), formStr.indexOf(' method='))
        .replaceAll('\'', '');
    print('form button id: $formName');

    parsedHtml = htmlStr.replaceAll(
        '</head>',
        '<script type="text/javascript">' +
            'function submitForm() { document.$formName.submit(); }' +
            'setTimeout(submitForm, 300);' +
            '</script>' +
            '</head>');
    print('rewrite html form complete');
    print(parsedHtml);
  }

  @override
  void initState() {
    print('web url: ${widget.startUrl}');
    _store ??= sl.get<WebGameScreenStore>();

    isForm =
        widget.startUrl.contains('</form>') && widget.startUrl.isHtmlFormat;
    print('web url is form: $isForm');
    if (isForm) _rewriteHtml(widget.startUrl);
    super.initState();
  }

  @override
  void dispose() {
    MyLogger.debug(msg: 'dispose web game screen', tag: 'WebGameScreen');
    try {
      _store.stopSensor();
      OrientationHelper.restoreUI();
    } catch (e) {}
    // edit the source code in FlutterWebView
    // (under external lib -> webview_flutter -> android
    // -> src.main -> java.io.flutter.plugins.webviewflutter)
//    @Override
//    public void dispose() {
//    if(webView != null){
//    webView.clearCache(true);
//    webView.removeAllViews();
//    }
//    methodChannel.setMethodCallHandler(null);
//    webView.dispose();
//    webView.destroy();
//    }
//    /// Load empty page and clear cache
//    await _store.stopSensor();
//    _controller.loadUrl(Uri.dataFromString(
//      '',
//      mimeType: Global.WEB_MIMETYPE,
//      encoding: Global.webEncoding,
//    ).toString());
//    await _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
//          drawer: WebGameScreenDrawer(
//            scaffoldKey: _scaffoldKey,
//            store: _store,
//          ),
          floatingActionButton: FutureBuilder(
            future: Future.delayed(
                Duration(seconds: (showButtonHint) ? 5 : 2), () => true),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (showButtonHint) {
                  showButtonHint = false;
                  Future.delayed(Duration(milliseconds: 1500), () {
                    FLToast.showText(
                      text: '单击显示，长按离开 ↗',
                      style: FLToastStyle.light,
                      position: FLToastPosition.bottom,
                      showDuration: ToastDuration.DEFAULT.value,
                    );
                  });
                }
                return GestureDetector(
                  onLongPress: () => _returnHome(),
                  child: WebGameScreenFloatButton(
                    scaffoldKey: _scaffoldKey,
                    store: _store,
                    onReturnHome: () => _returnHome(),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          body:
//          GestureDetector(
//            onDoubleTap: () => _scaffoldKey.currentState.openDrawer(),
//            child:
              WebView(
            initialUrl: widget.startUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) async {
              _controller = controller;
              if (isForm) {
                _controller.loadUrl(Uri.dataFromString(
                  parsedHtml,
                  mimeType: Global.WEB_MIMETYPE,
                  encoding: Global.webEncoding,
                ).toString());
              } else if (widget.startUrl.isUrl == false) {
                _controller.loadUrl(Uri.dataFromString(
                  widget.startUrl,
                  mimeType: Global.WEB_MIMETYPE,
                  encoding: Global.webEncoding,
                ).toString());
              }
            },
            onPageFinished: (String url) async {
              print('web page loaded: $url');
              if (url.isUrl == false) return;
              if (isForm) isForm = false;

              String pageTitle = await _controller.getTitle();
              print('web page title: $pageTitle');
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
          ),
        ),
//        ),
        onWillPop: () async {
          MyLogger.debug(msg: 'pop web game screen', tag: 'WebGameScreen');
          return Future(() => true);
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    try {
      _store.initSensorStream();
    } catch (e, s) {
      FLToast.showError(
        text: 'Cannot Enable Sensor',
        showDuration: ToastDuration.DEFAULT.value,
      );
      print('init sensor error: $e\n$s');
    }
  }
}
