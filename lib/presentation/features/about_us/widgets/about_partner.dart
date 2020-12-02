import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/res.dart';

class AboutPartner extends StatelessWidget {
  final List<String> _teamsImages = [
    Res.teams_mcu,
    Res.teams_ita1,
    Res.teams_fcb,
    Res.teams_lcc,
    Res.teams_afa,
    Res.teams_hbsc,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '赞助伙伴',
          style: TextStyle(
            fontSize: FontSize.TITLE.value,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(height: 8.0),
        GridView.count(
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          children: _teamsImages
              .map((path) => (path.isEmpty)
                  ? SizedBox.shrink()
                  : Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset(path),
                      ),
                    ))
              .toList(),
        ),
      ],
    );
  }
}
