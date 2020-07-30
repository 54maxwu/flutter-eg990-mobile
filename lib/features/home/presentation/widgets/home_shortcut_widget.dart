import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/home/presentation/state/home_store.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/login/presentation/login_route.dart';
import 'package:flutter_ty_mobile/res.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart';

import 'home_display_size_calc.dart';
import 'home_store_inherit_widget.dart';

///
/// Creates a widget to show member info under Marquee
/// @author H.C.CHIANG
/// @version 2020/6/19
///
class HomeShortcutWidget extends StatefulWidget {
  final HomeDisplaySizeCalc sizeCalc;
  HomeShortcutWidget({
    Key key,
    @required this.sizeCalc,
  }) : super(key: key);

  @override
  HomeShortcutWidgetState createState() => HomeShortcutWidgetState();
}

class HomeShortcutWidgetState extends State<HomeShortcutWidget> {
  double _areaHeight;
  double _leftAreaMaxWidth;
  double _leftAreaMinWidth;
  double _leftAreaTextSize;

  HomeStore _store;
  LoginStatus _userData;
  bool isUserContent = false;
  Widget _contentWidget;
  BorderSide _widgetBorder;

  Widget _infoWidget;
  String _currentCredit;

  void _updateTextSize(bool updateView) {
    double textSize = (_userData.currentUser.account.length > 10 ||
            _userData.currentUser.credit.strToDouble > 10000)
        ? FontSize.SMALLER.value
        : FontSize.NORMAL.value;

    if (_leftAreaTextSize != textSize) {
      _leftAreaTextSize = textSize;
      if (updateView)
        Future.delayed(Duration(milliseconds: 200), () {
          setState(() {});
        });
    }
  }

  void updateUser() {
    print('updating member area data...');
    setState(() {
      _userData = getRouteUserStreams.lastStatus;
      print('member area user: $_userData');
      if (_userData.loggedIn) _store?.getCredit();
    });
  }

  void toastLogin() {
    FLToast.showInfo(
      text: localeStr.messageErrorNotLogin,
      showDuration: ToastDuration.DEFAULT.value,
    );
  }

  @override
  void initState() {
    _areaHeight = Global.device.height / 10.5;
    if (_areaHeight < widget.sizeCalc.shortcutMinHeight)
      _areaHeight = widget.sizeCalc.shortcutMinHeight;
    if (_areaHeight > widget.sizeCalc.shortcutMaxHeight)
      _areaHeight = widget.sizeCalc.shortcutMaxHeight;

    double availableWidth =
        (Global.device.width >= 600) ? 200 : Global.device.width / 3;
    _leftAreaMinWidth = FontSize.NORMAL.value * 6;
    _leftAreaMaxWidth = FontSize.NORMAL.value * 9.5 + 10.0;

    if (Global.device.isIos) _leftAreaMinWidth += 8;
    if (Global.device.width > 600) {
      _leftAreaMinWidth = _leftAreaMinWidth * 1.5;
      _leftAreaMaxWidth = _leftAreaMaxWidth * 2;
    } else if (Global.device.isIos) _leftAreaMaxWidth += 8;

    if (_leftAreaMinWidth < availableWidth) _leftAreaMinWidth = availableWidth;
    if (_leftAreaMaxWidth < _leftAreaMinWidth)
      _leftAreaMaxWidth = _leftAreaMinWidth;

    _userData = getRouteUserStreams.lastStatus;
    print('updating member area height: $_areaHeight');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (isUserContent != _userData.loggedIn) {
      isUserContent = _userData.loggedIn;
      _contentWidget = _buildContent(context);
    }
    _contentWidget ??= _buildContent(context);
    _widgetBorder ??= BorderSide(
      color: Themes.defaultAccentColor,
      width: 2.0,
      style: BorderStyle.solid,
    );
    return Container(
      constraints: BoxConstraints(
        maxWidth: Global.device.width - 16.0,
        maxHeight: (isUserContent)
            ? _areaHeight - widget.sizeCalc.shortcutTitleHeight
            : _areaHeight,
      ),
      child: Stack(
        // use stack to hide frame line between widgets
        children: [
          Container(
            decoration: BoxDecoration(
              color: Themes.defaultAppbarColor,
              border: Border.fromBorderSide(_widgetBorder),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: (isUserContent)
                ? EdgeInsets.zero
                : EdgeInsets.only(
                    top: widget.sizeCalc.shortcutTitleHeight - 2.0,
                  ),
            child: _contentWidget,
          ),
          if (!isUserContent)
            Container(
              height: widget.sizeCalc.shortcutTitleHeight,
              decoration: BoxDecoration(
                color: Themes.defaultAccentColor,
                border: Border.fromBorderSide(_widgetBorder),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      localeStr.homeHintWelcomeLogin,
                      style: TextStyle(
                        color: Themes.defaultTextColorBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          constraints: (isUserContent)
              ? BoxConstraints(
                  maxWidth: _leftAreaMaxWidth,
                  minWidth: _leftAreaMinWidth,
                )
              : BoxConstraints.tightFor(
                  width: (Global.device.width > 400)
                      ? _areaHeight * Global.device.widthScale
                      : _areaHeight,
                ),
          alignment: Alignment.center,
          child: _buildLeftContent(context),
        ),
        VerticalDivider(
          thickness: 2.0,
          color: Themes.defaultAccentColor,
        ),
        _buildRightContent(),
      ],
    );
  }

  Widget _buildLeftContent(BuildContext context) {
    if (!isUserContent) {
      /// if not logged in, show a login button
      return Container(
        margin: const EdgeInsets.fromLTRB(12.0, 8.0, 4.0, 8.0),
        child: RaisedButton(
          visualDensity: VisualDensity(horizontal: 3.0),
          color: Themes.defaultAppbarColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Themes.defaultAccentColor),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            localeStr.pageTitleLogin2,
            style: TextStyle(
              color: Themes.defaultAccentColor,
            ),
          ),
          onPressed: () => showDialog(
            context: context,
            barrierDismissible: true,
            builder: (_) => new LoginRoute(
              returnHomeAfterLogin: true,
              isDialog: true,
            ),
          ),
        ),
      );
    } else {
      /// if logged in, show member info
      if (_leftAreaTextSize == null) _updateTextSize(false);
      return Container(
        margin: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: RichText(
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '${_userData.currentUser.account}\r',
                          style: TextStyle(
                            color: Themes.defaultAccentColor,
                            fontSize: _leftAreaTextSize,
                          ),
                        ),
                        TextSpan(
                          text: localeStr.homeHintWelcome,
                          style: TextStyle(fontSize: _leftAreaTextSize),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<String>(
                  stream: _store.creditStream,
                  initialData: _store.userCredit,
                  builder: (_, snapshot) {
                    if (_currentCredit != snapshot.data) {
                      _currentCredit = snapshot.data;
                      print('home page user credit updated: $_currentCredit');
                      _infoWidget = _buildUserInfo();
                      _updateTextSize(true);
                    }
                    _infoWidget ??= _buildUserInfo();
                    return _infoWidget;
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildUserInfo() {
    return RichText(
      overflow: TextOverflow.visible,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: '${localeStr.homeHintMemberCreditLeft} ',
            style: TextStyle(fontSize: _leftAreaTextSize),
          ),
          TextSpan(
            text: formatValue(
              _currentCredit,
              floorIfInt: true,
              creditSign: true,
            ),
            style: TextStyle(
              color: Themes.defaultAccentColor,
              fontSize: _leftAreaTextSize,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightContent() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _createIconButton(
              Res.homeMemberAreaIconDeposit,
              localeStr.pageTitleDeposit,
              () {
                (isUserContent)
                    ? RouterNavigate.navigateToPage(RoutePage.deposit)
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconWithdraw,
              localeStr.pageTitleMemberWithdraw,
              () {
                (isUserContent)
                    ? RouterNavigate.navigateToPage(
                        RoutePage.withdraw,
                        arg: BankcardRouteArguments(withdraw: true),
                      )
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconTransfer,
              localeStr.pageTitleMemberTransfer,
              () {
                (isUserContent)
                    ? RouterNavigate.navigateToPage(RoutePage.transfer)
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconVip,
              'VIP',
              () => RouterNavigate.navigateToPage(RoutePage.vipLevel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createIconButton(String urlIconName, String label, Function func) {
    return GestureDetector(
      onTap: func,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height:
                  (_areaHeight >= widget.sizeCalc.shortcutMaxHeight) ? 28 : 24,
            ),
            child: networkImageBuilder(urlIconName),
          ),
          Padding(
            padding: EdgeInsets.only(top: (label.hasChinese) ? 4.0 : 6.0),
            child: Text(
              label,
              style: TextStyle(
                color: Themes.defaultTextColor,
                fontSize: (_areaHeight >= widget.sizeCalc.shortcutMaxHeight)
                    ? FontSize.SUBTITLE.value
                    : FontSize.NORMAL.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
