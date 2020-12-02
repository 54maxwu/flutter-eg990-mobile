import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/router/app_navigator.dart';
import 'package:flutter_eg990_mobile/presentation/screens/main_screen_provider.dart';
import 'package:flutter_eg990_mobile/presentation/screens/user/user_info_store.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:provider/provider.dart';

class MemberHeader extends StatefulWidget {
  @override
  _MemberHeaderState createState() => _MemberHeaderState();
}

class _MemberHeaderState extends State<MemberHeader> {
  @override
  Widget build(BuildContext context) {
    return Selector<MainScreenProvider, UserInfoStore>(
      selector: (_, provider) => provider.userInfoStore,
      builder: (_, store, __) {
        return Container(
          color: themeColor.defaultBackgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Image.asset(
                        Res.avatar_nologin,
                        scale: 2.5 / Global.device.widthScale,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GestureDetector(
                          onTap: () => AppNavigator.navigateTo(RoutePage.login),
                          child: AutoSizeText(
                            localeStr.messageLoginHint,
                            style: TextStyle(
                                fontSize: FontSize.SUBTITLE.value,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            maxFontSize: FontSize.TITLE.value,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: themeColor.defaultHintColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
