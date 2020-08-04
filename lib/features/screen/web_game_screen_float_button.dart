import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/float_expand_widget.dart';

import 'web_game_screen_store.dart';

class WebGameScreenFloatButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WebGameScreenStore store;
  final Function onReturnHome;

  WebGameScreenFloatButton({
    Key key,
    @required this.scaffoldKey,
    @required this.store,
    this.onReturnHome,
  }) : super(key: key);

  @override
  WebGameScreenFloatButtonState createState() =>
      WebGameScreenFloatButtonState();
}

class WebGameScreenFloatButtonState extends State<WebGameScreenFloatButton> {
  final double _expandIconScale = 1.15;
  final double _expandArrowIconScale = 1.5;
  final double _arrowIconScale = 1.25;
  final bool isIos = Global.device.isIos;

  FloatExpandController _controller;
  double _expandHeight;
  bool _fabExpand = false;
  bool _visible = true;

  void hideTool() {
    if (mounted && _visible) setState(() => _visible = false);
  }

  void showTool() {
    if (mounted && !_visible) setState(() => _visible = true);
  }

  void _initController() {
    _controller = new FloatExpandController();
    _controller.setExpandedWidgetConfiguration(
      expendedBackgroundColor: Colors.white,
      withChild: ButtonTheme(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        buttonColor: Themes.buttonSubColorGrey,
        disabledColor: Themes.buttonDisabledColorDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FittedBox(
                fit: BoxFit.contain,
                child: Transform.scale(
                  scale: _expandIconScale,
                  child: Icon(
                    Icons.home,
                    color: Themes.iconColorDarkGrey,
                  ),
                ),
              ),
              visualDensity: VisualDensity.compact,
              onPressed: (widget.onReturnHome != null)
                  ? () => widget.onReturnHome()
                  : () => {},
            ),
            IconButton(
              icon: FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.screen_rotation,
                  color: Themes.iconColorDarkGrey,
                ),
              ),
              visualDensity: VisualDensity.compact,
              onPressed: (widget.store != null)
                  ? () => widget.store.rotateScreenLeft()
                  : () => {},
            ),

            /// TODO error after unlock and rotate in ios
            if (!isIos)
              IconButton(
                icon: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    Icons.screen_lock_rotation,
                    color: Themes.iconColorDarkGrey,
                  ),
                ),
                visualDensity: VisualDensity.compact,
                onPressed:
                    (widget.store != null) ? () => _lockRotate() : () => {},
              ),
            IconButton(
              icon: FittedBox(
                fit: BoxFit.contain,
                child: Transform.scale(
                  scale: _expandArrowIconScale,
                  child: Icon(
                    Icons.chevron_right,
                    color: Themes.iconColorDarkGrey,
                  ),
                ),
              ),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                _controller.collapseFAB();
                setState(() {
                  _fabExpand = false;
                });
              },
            ),
          ],
        ),
      ),
      forceCustomHeight: true,
      heightToExpandTo: _expandHeight,
    );
  }

  void _lockRotate() {
    bool isLock = widget.store.isLockRotate;
    String value = (isLock) ? localeStr.btnOff : localeStr.btnOn;
    widget.store.lockRotate = !isLock;
    callToast('${localeStr.sideBtnLockRotate}($value)');
  }

  @override
  void initState() {
    _expandHeight = (Global.device.comfortButtonHeight + 12.0) /
        Global.device.featureContentHeight *
        100;
    if (_expandHeight > 10) _expandHeight = 10.0;
    if (_expandHeight < 9.375) _expandHeight = 9.375;
    print('float expand height: $_expandHeight');
    super.initState();
    _initController();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      maintainState: true,
      maintainAnimation: true,
      child: FloatExpandWidget(
        controller: _controller,
        collapsedColor: Colors.white30,
        useAsFloatingSpaceBar: _fabExpand,
        useAsFloatingActionButton: !_fabExpand,
        floatingActionButtonIcon: Icons.chevron_left,
        floatingActionButtonIconSizeFactor: 9.0,
        floatingActionButtonIconScale: _arrowIconScale,
        floatingActionButtonContainerWidth: _expandHeight * 1.55,
        floatingActionButtonContainerHeight: _expandHeight * 0.85,
        onFloatingActionButtonTapped: () {
          setState(() {
            _fabExpand = true;
          });
          _controller.expandFAB();
        },
        // take 60% of the screen horizontally
        floatingSpaceBarContainerWidth:
            Global.device.orientation == Orientation.portrait ? 60 : 35,
      ),
    );
  }
}
