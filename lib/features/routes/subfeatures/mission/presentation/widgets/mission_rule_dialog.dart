import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class MissionRulesDialog extends StatelessWidget {
  final String rules;

  MissionRulesDialog({@required this.rules});

  final String htmlBgColor = themeColor.dialogBgTransparent.toHexNoAlpha();
  final String htmlTextColor = themeColor.missionRuleTextColor.toHexNoAlpha();

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      customBg: themeColor.missionDialogBackgroundColor,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.double_arrow_sharp,
                    color: themeColor.missionDialogDecorColor,
                    size: FontSize.TITLE.value,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
                    child: Text(
                      localeStr.missionTextRule,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        fontWeight: FontWeight.w500,
                        color: themeColor.missionDialogTitleColor,
                      ),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.double_arrow_sharp,
                      color: themeColor.missionDialogDecorColor,
                      size: FontSize.TITLE.value,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.white, thickness: 1, height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      HtmlWidget(_buildHtmlText()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _buildHtmlText() {
    return '<html>'
        '<head><meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"></head>'
        '<body bgcolor="$htmlBgColor" text="$htmlTextColor" style="line-height:1.2;">'
        '$rules'
        '</html>';
  }
}
