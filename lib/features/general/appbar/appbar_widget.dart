import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/users/domain/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/users/presentation/user_data.dart';

import '../../widget_res_export.dart';

///
/// @author H.C.CHIANG
/// @version 2020/1/31
class AppBarWidget extends StatefulWidget {
  final RouterWidgetStreams routerStreams;
  final GlobalKey<ScaffoldState> barKey;

  AppBarWidget({Key key, this.routerStreams, this.barKey}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final double screenWidth = Global.device.width;
  bool hasUser = false;
  bool showBack = false;
  Widget _lastActionWidget;

  Either<bool, UserEntity> _checkUser() {
    var data = sl.get<UserData>();
    print('app bar user data: $data');

    if (!hasUser && data.isLoggedIn)
      return Right(data.user);
    else if (hasUser && !(data.isLoggedIn))
      return Right(null);
    else
      return Left(false);
  }

  @override
  void initState() {
    _lastActionWidget = buttonGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: StreamBuilder<bool>(
        stream: widget.routerStreams.backStream,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            return IconButton(
                icon: Icon(Icons.menu, color: Themes.defaultAccentColor),
                tooltip: localeStr.btnMenu,
                onPressed: () {
                  widget.barKey.currentState.openDrawer();
                });
          } else {
            return IconButton(
                icon: Icon(Icons.arrow_back, color: Themes.iconColor),
                tooltip: localeStr.btnBack,
                onPressed: () {
                  RouterNavigate.navigateBack();
                });
          }
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: StreamBuilder<String>(
          stream: widget.routerStreams.titleStream,
          initialData: localeStr.pageTitleHome,
          builder: (context, snapshot) {
//            print('app bar title snapshot: ${snapshot.data}');
            return Text(snapshot.data,
                style: TextStyle(fontSize: FontSize.MESSAGE.value));
          },
        ),
        titlePadding: EdgeInsetsDirectional.only(
          start: Global.APP_BAR_HEIGHT / 3,
          bottom: (Global.APP_BAR_HEIGHT / 3) - 4,
        ),
      ),
      title: Image.asset(
        Res.iconBarLogoEg,
        scale: 4,
      ),
      titleSpacing: 0,
      actions: <Widget>[
        StreamBuilder<bool>(
            stream: widget.routerStreams.actionStream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Container();
              } else {
                return _checkUser().fold((l) => _lastActionWidget,
                    (r) => r == null ? buttonGroup() : userGroup(r));
              }
            }),
      ],
    );
  }

  Widget userGroup(UserEntity user) {
    hasUser = true;
    _lastActionWidget = Container();
//    _lastActionWidget = Container(
//      child: Padding(
//        padding: const EdgeInsets.only(top: 2.0, right: 3.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.end,
//          children: <Widget>[
//            Row(
//              children: <Widget>[Text(user.account)],
//            ),
//            Row(
//              children: <Widget>[Text(user.credit.trimValue(creditSign: true))],
//            ),
//          ],
//        ),
//      ),
//    );
    return _lastActionWidget;
  }

  Widget buttonGroup() {
    hasUser = false;
    _lastActionWidget = Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: <Widget>[
            ButtonTheme(
              height: 30,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0),
              ),
              child: RaisedButton(
                color: Themes.defaultAccentColor,
                child: new Text(
                  localeStr.pageTitleRegister2,
                  style: TextStyle(
                      fontSize: FontSize.NORMAL.value - 1,
                      color: Themes.defaultTextColorBlack),
                ),
                visualDensity: VisualDensity(horizontal: -3.0),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
    return _lastActionWidget;
  }

  @override
  void dispose() {
    widget.routerStreams.dispose();
    super.dispose();
  }
}
