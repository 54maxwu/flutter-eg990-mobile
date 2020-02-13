import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';

import '../../widget_res_export.dart';

///
/// @author H.C.CHIANG
/// @version 2020/1/31
class AppBarDrawerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> barKey;

  AppBarDrawerWidget({Key key, this.barKey}) : super(key: key);

  @override
  _AppBarDrawerWidgetState createState() => _AppBarDrawerWidgetState();
}

class _AppBarDrawerWidgetState extends State<AppBarDrawerWidget> {
  final double screenWidth = Global.device.width;
  Widget _drawerHeader;
  bool hasUser = false;

  final List<Widget> _menuIcons = [
    Icon(
      IconData(0xf015, fontFamily: 'FontAwesome'),
      color: Themes.iconColor,
    ),
  ];

  final List<RouterPage> _menuRoute = [
    RouterPage.HomeRoute,
  ];

  void onMenuTapped(int index) {
    if (RouterNavigate.current == _menuRoute[index].info.route) return;
    if (widget.barKey.currentState.isDrawerOpen)
      Navigator.pop(context); // close the drawer
    RouterNavigate.navigateToPage(_menuRoute[index]);
  }

  void checkHeader() {
    var data = sl.get<UserData>();
    print('app bar drawer user data: $data');
    setState(() {
      if (!hasUser && data.isLoggedIn)
        _drawerHeader = userHeader(data.user);
      else if (hasUser && !(data.isLoggedIn) || _drawerHeader == null)
        _drawerHeader = welcomeHeader();
    });
  }

  @override
  void initState() {
    checkHeader();
    super.initState();
  }

  @override
  void didUpdateWidget(AppBarDrawerWidget oldWidget) {
    checkHeader();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Themes.defaultBackgroundColor),
            child: Expanded(
              child: _drawerHeader,
            ),
          ),
          Container(
            height: double.maxFinite,
            child: ListView.builder(
              itemCount: _menuRoute.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 8.0),
                    child: Transform.scale(
                      scale: 1.05,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Themes.iconColor)),
                        child: Transform.scale(
                            scale: 0.75, child: _menuIcons[index]),
                      ),
                    ),
                  ),
                  title: Text(
                    _menuRoute[index].info.title,
                    style: TextStyle(fontSize: FontSize.MESSAGE.value),
                  ),
                  onTap: () => onMenuTapped(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget userHeader(UserEntity user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Image.asset(
            'assets/images/vip/user_vip_${user.vip}.png',
          ),
        ),
        SizedBox(height: 8),
        Text(localeStr.messageWelcomeUser(user.account),
            style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget welcomeHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(localeStr.messageWelcome, style: TextStyle(color: Colors.white)),
        SizedBox(height: 8),
        ButtonTheme(
          child: RaisedButton(
            color: HexColor.fromHex('#f4daa3'),
            textColor: Themes.defaultTextColorBlack,
            child: Text(localeStr.pageTitleLogin2),
            onPressed: () {
              if (widget.barKey.currentState.isDrawerOpen)
                Navigator.pop(context);
              RouterNavigate.navigateToPage(RouterPage.LoginRoute);
            },
          ),
        ),
      ],
    );
  }
}
