import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/res.dart';

class AboutCert extends StatelessWidget {
  final List<String> _certImages = [
    Res.cert_gc,
    Res.cert_mga,
    Res.cert_pagcor,
    Res.cert_bvi,
  ];

  final List<String> _certLabel = [
    localeStr.aboutCertTitleGC,
    localeStr.aboutCertTitleMGA,
    localeStr.aboutCertTitlePGC,
    localeStr.aboutCertTitleBVI,
  ];

  @override
  Widget build(BuildContext context) {
    SliverGrid _sliver = SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 6.0,
        childAspectRatio: 0.85,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, index) {
          String path = _certImages[index];
          return (path.isEmpty)
              ? SizedBox.shrink()
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Image.asset(path)),
                    ),
                    SizedBox(
                      height: FontSize.SMALLER.value * 4,
                      child: RichText(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: _certLabel[_certImages.indexOf(path)],
                          style: TextStyle(
                            fontSize: FontSize.SMALLER.value,
                            color: themeColor.defaultTextColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
        childCount: _certImages.length,
      ),
    );
    return Column(
      children: [
        Text(
          '官方认证',
          style: TextStyle(
            fontSize: FontSize.TITLE.value,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(height: 8.0),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomScrollView(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            slivers: [_sliver],
          ),
        ),
      ],
    );
  }
}
