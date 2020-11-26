import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/features/about_us/data/about_data.dart';

import 'about_cert.dart';
import 'about_partner.dart';

class AboutDesc extends StatelessWidget {
  // final AboutData data = AboutData(title: localeStr.aboutDataTitle1, contents: [
  //   localeStr.aboutDataDesc10,
  //   localeStr.aboutDataDesc11,
  //   localeStr.aboutDataDesc12,
  // ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //     color: themeColor.defaultLayeredBackgroundColor,
      //     borderRadius: BorderRadius.circular(8.0)),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: TextStyle(
              fontSize: FontSize.SUBTITLE.value,
              color: themeColor.defaultMessageColor),
          children: [
            // TextSpan(text: data.contents[0]),
            WidgetSpan(child: AboutCert()),
            // TextSpan(text: data.contents[1]),
            // TextSpan(text: data.contents[2]),
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
                child: AboutPartner(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
