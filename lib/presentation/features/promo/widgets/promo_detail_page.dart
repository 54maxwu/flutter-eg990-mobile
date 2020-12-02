import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/domain/sector/promo/promo_entity.dart';
import 'package:flutter_eg990_mobile/presentation/common/window/loading_widget.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class PromoDetailPage extends StatefulWidget {
  final PromoEntity promo;

  const PromoDetailPage(this.promo);

  @override
  _PromoDetailPageState createState() => _PromoDetailPageState();
}

class _PromoDetailPageState extends State<PromoDetailPage> {
  Widget _content;

  @override
  Widget build(BuildContext context) {
    debugPrint('promo detail id: ${widget.promo?.id}');
    return WillPopScope(
      onWillPop: () async {
        debugPrint('pop promo detail');
        Future.delayed(Duration(milliseconds: 100), () => AppNavigator.back());
        return Future(() => true);
      },
      child: Scaffold(
        body: (widget.promo == null)
            ? Container(
                alignment: Alignment.center,
                child: Image.asset(Res.img_no_data_2),
              )
            : FutureBuilder<String>(
                future: _buildHtmlText(widget.promo),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    _content = Container(
                      padding:
                          const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
                      height: Global.device.featureContentHeight,
                      child: ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          HtmlWidget(snapshot.data ?? ''),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    _content = LoadingWidget();
                  }
                  _content ??= SizedBox.shrink();
                  return _content;
                }),
      ),
    );
  }
}

Future<String> _buildHtmlText(PromoEntity promo) async {
  final String _htmlBgColor = themeColor.dialogBgColor.toHexNoAlpha();
  final String _htmlTextColor = themeColor.dialogTextColor.toHexNoAlpha();
  final String _htmlTitleColor = themeColor.dialogTitleColor.toHexNoAlpha();

  final detail = await Future.wait([
    Future.value(_htmlPromoPlatform(_htmlTitleColor, promo.textContent)),
    Future.value(_htmlPromoContent(_htmlTitleColor, promo.placeContent)),
    Future.value(_htmlPromoApply(_htmlTitleColor, promo.applyContent)),
    Future.value(_htmlPromoRules(_htmlTitleColor, promo.ruleContent)),
  ]).then((list) => list.join('<br>'));
  debugPrint('promo detail:\n$detail');

  String html = '<html>'
      '<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"></head>'
      '<body bgcolor="$_htmlBgColor" text="$_htmlTextColor" style="line-height:1.2;">'
      '$detail'
      '</html>';
  return Future.value(html);
}

String _htmlPromoPlatform(String titleColor, String wrapText) {
  StringBuffer buffer = StringBuffer();
  buffer.write('<h3><font color=\"$titleColor\">');
  buffer.write(localeStr.promoDetailPlatform);
  buffer.write('</font></h3>');
  buffer.write('<p>');
  buffer.write(wrapText);
  buffer.write('</p>');
  return buffer.toString();
}

String _htmlPromoContent(String titleColor, String wrapText) {
  StringBuffer buffer = StringBuffer();
  buffer.write('<h3><font color=\"$titleColor\">');
  buffer.write(localeStr.promoDetailContent);
  buffer.write('</font></h3>');
  buffer.write(wrapText);
//    var bufferStr = buffer.toString();
//    if (bufferStr.endsWith('<p>&nbsp;</p>')) {
//      int pos = bufferStr.lastIndexOf('<p>&nbsp;</p>');
//      return Future.value(bufferStr.substring(0, pos));
//    }
  return buffer.toString().replaceAll('<p>&nbsp;</p>', '');
}

String _htmlPromoApply(String titleColor, String wrapText) {
  StringBuffer buffer = StringBuffer();
  buffer.write('<h3><font color=\"$titleColor\">');
  buffer.write(localeStr.promoDetailApply);
  buffer.write('</font></h3>');
  buffer.write('<p>');
  buffer.write(wrapText);
  buffer.write('</p>');
  return buffer.toString();
}

String _htmlPromoRules(String titleColor, String wrapText) {
  StringBuffer buffer = StringBuffer();
  buffer.write("<h3><font color=\"$titleColor\">");
  buffer.write(localeStr.promoDetailRules);
  buffer.write("</font></h3>");
  buffer.write("<p>");
  buffer.write(wrapText);
  buffer.write("</p>");
  return buffer.toString();
}
