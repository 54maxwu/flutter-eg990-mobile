import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart' as HtmlStyle;
import 'package:flutter_ty_mobile/features/export_internal_file.dart';

class RollerDisplayRules extends StatelessWidget {
  final double buttonWidgetWidth = Global.device.width - 16;
  final double buttonWidgetHeight = Global.device.comfortButtonHeight * 1.35;
  final Color secondBlockColor = HexColor.fromHex('#e7c080');
  final Color titleColor = HexColor.fromHex('#f06666');
  final Color contentColor = HexColor.fromHex('#cce0f5');
  final String rules;
  final Function onButtonTap;

  RollerDisplayRules(this.rules, {this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Html(
                data: """$rules""",
                style: {
                  "h1": HtmlStyle.Style(
                    fontSize: HtmlStyle.FontSize(18.0),
                    fontWeight: FontWeight.normal,
                    color: titleColor,
                    textAlign: TextAlign.center,
                    alignment: Alignment.topCenter,
                  ),
                  "p": HtmlStyle.Style(
                    fontSize: HtmlStyle.FontSize(17.25),
                    fontWeight: FontWeight.normal,
                    color: contentColor,
                    textAlign: TextAlign.center,
                    alignment: Alignment.topCenter,
                  ),
                },
              ),
            ),
          ],
        ),
//        /// Debug Widget
//        Padding(
//          padding: const EdgeInsets.only(top: 12.0),
//          child: Row(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: [
//              Expanded(
//                child: Text(rules),
//              )
//            ],
//          ),
//        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: ButtonTheme(
            minWidth: buttonWidgetWidth / 1.5,
            height: buttonWidgetHeight * 0.85,
            buttonColor: secondBlockColor,
            disabledColor: Themes.buttonDisabledColorDark,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              side: BorderSide(
                color: Themes.hintHighlightDarkRed,
                width: 3.0,
              ),
            ),
            child: RaisedButton(
              elevation: 2.0,
              onPressed:
                  (onButtonTap != null) ? () => onButtonTap() : () => null,
              child: Text(
                localeStr.wheelTextTitleGet,
                style: TextStyle(
                  color: Themes.hintHighlightDarkRed,
                  fontSize: FontSize.TITLE.value,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
