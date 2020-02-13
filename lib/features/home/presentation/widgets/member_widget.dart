import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';
import 'package:flutter_ty_mobile/utils/string_util.dart';

import '../../../widget_res_export.dart'
    show
        FontSize,
        Global,
        Res,
        RouterNavigate,
        RouterPage,
        Themes,
        localeStr,
        sl;

///@author H.C.CHIANG
///@version 2020/2/13
class MemberWidget extends StatefulWidget {
  MemberWidget({Key key}) : super(key: key);

  @override
  MemberWidgetState createState() => MemberWidgetState();
}

class MemberWidgetState extends State<MemberWidget> {
  UserData _userData;

  void updateUser() {
    print('updating member area data...');
    setState(() {
      _userData = sl.get<UserData>();
    });
  }

  @override
  void initState() {
    _userData = sl.get<UserData>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        /* Outside border */
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Themes.defaultAccentColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        /* Area frame */
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Themes.defaultAccentColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(4.0),
                      ),
                    ),
                    /* Area title message */
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 12.0, 6.0),
                      child: Text(
                        (_userData.isLoggedIn)
                            ? localeStr.homeHintWelcome
                            : localeStr.homeHintWelcomeLogin,
                        style: TextStyle(color: Themes.defaultTextColorBlack),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  /* Area Content */
                  child: Container(
                    height: Themes.homeMemberAreaHeight,
                    decoration: BoxDecoration(
                      color: Themes.defaultAppbarColor,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(6.0),
                      ),
                    ),
                    child: _buildMemberArea(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberArea() {
    return Row(
      children: <Widget>[
        _buildLeftContent(),
        VerticalDivider(
          thickness: 2.0,
          color: Themes.defaultAccentColor,
        ),
        _buildRightContent(),
      ],
    );
  }

  Widget _buildLeftContent() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 4.0),
      child: (_userData.isLoggedIn)
          ? Padding(
              /// if logged in, show member info
              padding: EdgeInsets.only(left: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: Themes.homeMemberAreaHeight * 0.9,
                          maxWidth: Themes.homeMemberAreaHeight * 1.5,
                        ),
                        child: Text(
                          _userData.user.account,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: FontSize.NORMAL.value - 2,
                            color: Themes.defaultAccentColor,
                          ),
                        ),
                      ),
                      Text(localeStr.homeHintWelcome,
                          style:
                              TextStyle(fontSize: FontSize.NORMAL.value - 2)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        localeStr.homeHintMemberCreditLeft,
                        style: TextStyle(fontSize: FontSize.NORMAL.value - 2),
                      ),
                      Text(
                        _userData.user.credit
                            .trimValue(floorIfInt: true, creditSign: true),
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: FontSize.NORMAL.value - 2,
                          color: Themes.defaultAccentColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : RaisedButton(
              /// if not logged in, show a login button
              child: Text(
                localeStr.pageTitleLogin2,
                style: TextStyle(color: Themes.defaultAccentColor),
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Themes.defaultAccentColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Themes.defaultAppbarColor,
              onPressed: () =>
                  RouterNavigate.navigateToPage(RouterPage.LoginRoute),
            ),
    );
  }

  Widget _buildRightContent() {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _createIconButton(Res.homeMemberAreaIconDeposit,
                  localeStr.pageTitleDeposit, () => {}),
              _createIconButton(Res.homeMemberAreaIconWithdraw,
                  localeStr.pageTitleMemberWithdraw, () => {}),
              _createIconButton(Res.homeMemberAreaIconTransfer,
                  localeStr.pageTitleMemberTransfer, () => {}),
              _createIconButton(Res.homeMemberAreaIconVip, 'VIP', () => {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createIconButton(String urlIconName, String label, Function func) {
    return GestureDetector(
      onTap: func,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: 30),
            child: Image.network('${Global.TEST_BASE_URL}$urlIconName'),
          ),
          Text(
            label,
            style: TextStyle(
                color: Themes.defaultTextColor,
                fontSize: FontSize.NORMAL.value - 2),
          ),
        ],
      ),
    );
  }
}
