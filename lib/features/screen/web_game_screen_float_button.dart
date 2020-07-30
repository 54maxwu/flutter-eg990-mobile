import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/float_expand_widget.dart';

import 'web_game_screen_store.dart';

class WebGameScreenFloatButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WebGameScreenStore store;
  final Function onReturnHome;

  WebGameScreenFloatButton({
    @required this.scaffoldKey,
    @required this.store,
    this.onReturnHome,
  });

  @override
  _WebGameScreenFloatButtonState createState() =>
      _WebGameScreenFloatButtonState();
}

class _WebGameScreenFloatButtonState extends State<WebGameScreenFloatButton> {
  final double expandIconScale = 1.15;
  final double expandArrowIconScale = 1.5;
  final double arrowIconScale = 1.25;

  FloatExpandController controller;
  double expandHeight;
  bool fabExpand = false;

  void _initController() {
    controller = new FloatExpandController();
    controller.setExpandedWidgetConfiguration(
      expendedBackgroundColor: Colors.white,
      withChild: ButtonTheme(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        buttonColor: Themes.buttonSubColorGrey,
        disabledColor: Themes.buttonDisabledColorDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FittedBox(
                fit: BoxFit.contain,
                child: Transform.scale(
                  scale: expandIconScale,
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

            /// TODO error after unlock and rotate, need to fix this
            if (Global.device.isIos == false)
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
                  scale: expandArrowIconScale,
                  child: Icon(
                    Icons.chevron_right,
                    color: Themes.iconColorDarkGrey,
                  ),
                ),
              ),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                controller.collapseFAB();
                setState(() {
                  fabExpand = false;
                });
              },
            ),
          ],
        ),
      ),
      forceCustomHeight: true,
      heightToExpandTo: expandHeight,
    );
  }

  void _lockRotate() {
    bool isLock = widget.store.isLockRotate;
    String value = (isLock) ? localeStr.btnOff : localeStr.btnOn;
    widget.store.lockRotate = !isLock;
    FLToast.showText(
      text: '${localeStr.sideBtnLockRotate}($value)',
      position: FLToastPosition.top,
      showDuration: ToastDuration.DEFAULT.value,
    );
  }

  @override
  void initState() {
    expandHeight = (Global.device.comfortButtonHeight + 12.0) /
        Global.device.featureContentHeight *
        100;
    print('expand height: $expandHeight');
    super.initState();
    _initController();
  }

  @override
  Widget build(BuildContext context) {
    return FloatExpandWidget(
      controller: controller,
      collapsedColor: Colors.white12,
      useAsFloatingSpaceBar: fabExpand,
      useAsFloatingActionButton: !fabExpand,
      floatingActionButtonIcon: Icons.chevron_left,
      floatingActionButtonIconSizeFactor: 9.0,
      floatingActionButtonIconScale: arrowIconScale,
      floatingActionButtonContainerWidth: expandHeight * 1.55,
      floatingActionButtonContainerHeight: expandHeight * 0.85,
      onFloatingActionButtonTapped: () {
        setState(() {
          fabExpand = true;
        });
        controller.expandFAB();
      },
      // take 90% of the screen horizontally
      floatingSpaceBarContainerWidth:
          Global.device.orientation == Orientation.portrait ? 60 : 40,
    );
  }
}
