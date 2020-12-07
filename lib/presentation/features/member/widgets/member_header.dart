import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
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
          child: (!store.hasUser)
              ? ListTile(
                  onTap: () => AppNavigator.navigateTo(RoutePage.login),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(Res.avatar_nologin),
                  ),
                  title: AutoSizeText(
                    localeStr.messageLoginHint,
                    style: TextStyle(
                      color: themeColor.defaultTextColor,
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    maxFontSize: FontSize.TITLE.value,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: themeColor.defaultHintColor,
                  ),
                )
              : ListTile(
                  onTap: () => callToastInfo(localeStr.workInProgress),
                  leading: Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(Res.avatar_nologin),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            store.userName,
                            style: TextStyle(
                              color: themeColor.defaultTextColor,
                              fontSize: FontSize.SUBTITLE.value,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            minFontSize: FontSize.NORMAL.value,
                            maxFontSize: FontSize.TITLE.value,
                          ),
                          Container(
                            height: FontSize.MESSAGE.value,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              'assets/images/badges/vip_icon_${store.userLevel}.png',
                            ),
                          ),
                        ],
                      ),
                      // subtitle did not vertical align in center
                      AutoSizeText(
                        '加入會員第?天',
                        style: TextStyle(
                          color: themeColor.defaultHintColor,
                          fontSize: FontSize.NORMAL.value,
                        ),
                        maxLines: 1,
                        minFontSize: FontSize.SMALLER.value,
                        maxFontSize: FontSize.MESSAGE.value,
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: themeColor.defaultHintColor,
                  ),
                ),
        );
      },
    );
  }
}
