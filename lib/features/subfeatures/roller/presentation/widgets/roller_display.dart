import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/hex_color.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/subfeatures/roller/data/models/roller_requirement_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/roller/presentation/widgets/roller_display_record.dart';
import 'package:flutter_ty_mobile/res.dart';

import '../state/roller_store.dart';
import 'roller_display_count.dart';
import 'roller_display_requirement.dart';
import 'roller_display_rules.dart';
import 'roller_display_wheel.dart';
import 'roller_display_order.dart';

class RollerDisplay extends StatefulWidget {
  final RollerStore store;

  RollerDisplay(this.store);

  @override
  _RollerDisplayState createState() => _RollerDisplayState();
}

class _RollerDisplayState extends State<RollerDisplay> {
  final Color firstBlockColor = HexColor.fromHex('#d2080e');
  final Color secondBlockColor = HexColor.fromHex('#e7c080');
  final double maxViewWidth = Global.device.width;
  final double titleBgHeight = 735 * (Global.device.width / 1920);
  final double titleHeight = 126 * 735 / 1920 * 1.5;
  final double totalMinHeight = 746.0;
  final double firstBlockHeight = 386.0;
  final double secondBlockMinHeight = 360.0;
  final double buttonWidgetHeight = Global.device.comfortButtonHeight * 1.35;
  final double buttonWidgetWidth = Global.device.width - 16;

  bool hasUser;
  double wheelPadBottom;
  double countWidgetPosition;

  void toastLogin() {
    FLToast.showInfo(
      text: localeStr.messageErrorNotLogin,
      showDuration: ToastDuration.DEFAULT.value,
    );
  }

  @override
  void initState() {
    wheelPadBottom = buttonWidgetHeight / 2 + 16;
    countWidgetPosition =
        titleBgHeight + firstBlockHeight - buttonWidgetHeight / 2;
    super.initState();
    hasUser = getRouteUserStreams.hasUser;
    if (hasUser) widget.store.getCount();
  }

  @override
  Widget build(BuildContext context) {
//    print('width scale: $widthScale');
//    print('title bg height: $titleBgHeight, title height: $titleHeight');
    return Container(
      width: maxViewWidth,
      height: Global.device.featureContentHeight,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            /// Background
            ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                Container(
                  color: firstBlockColor,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(Res.roller_top, fit: BoxFit.fitWidth),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        height: titleHeight,
                        child: Image.asset(Res.roller_title),
                      ),
                    ],
                  ),
                ),
                Container(
                  constraints:
                      BoxConstraints.tightFor(height: firstBlockHeight),
                  color: firstBlockColor,
                ),
                Container(
                  constraints: BoxConstraints(minHeight: secondBlockMinHeight),
                  color: secondBlockColor,
                ),
              ],
            ),
            Positioned(
              top: titleBgHeight,
              child: Container(
                width: maxViewWidth,
                height: firstBlockHeight,
                margin: const EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: wheelPadBottom),
                  child: RollerDisplayWheel(
                    store: widget.store,
                    containerWidth: maxViewWidth - 24,
                  ),
                ),
              ),
            ),
            Positioned(
              top: countWidgetPosition,
              child: Container(
                width: Global.device.width,
                child: ListView(
                  primary: false,
                  shrinkWrap: true,
                  children: [
                    /// Available Count
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: buttonWidgetHeight,
                      width: buttonWidgetWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Themes.hintHighlightDarkRed,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(30.0),
                        ),
                      ),
                      child: RollerDisplayCount(widget.store),
                    ),

                    /// Buttons Row
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ButtonTheme(
                        minWidth: buttonWidgetWidth / 2.25,
                        height: buttonWidgetHeight * 0.85,
                        buttonColor: secondBlockColor,
                        disabledColor: Themes.buttonDisabledColorDark,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.only(top: 6.0, bottom: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                          side: BorderSide(
                            color: Themes.hintHighlightDarkRed,
                            width: 3.0,
                          ),
                        ),
                        child: Container(
                          width: buttonWidgetWidth,
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  elevation: 2.0,
                                  child: Text(
                                    localeStr.wheelTextTitlePrize,
                                    style: TextStyle(
                                      color: Themes.hintHighlightDarkRed,
                                      fontSize: FontSize.TITLE.value,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (!hasUser)
                                      toastLogin();
                                    else {
                                      widget.store.getOrder();
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) => new RollerDisplayOrder(
                                          orderStream: widget.store.orderStream,
                                          initOrders: widget.store.orders ?? [],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: RaisedButton(
                                  elevation: 2.0,
                                  child: Text(
                                    localeStr.wheelTextTitleRecord,
                                    style: TextStyle(
                                      color: Themes.hintHighlightDarkRed,
                                      fontSize: FontSize.TITLE.value,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (!hasUser)
                                      toastLogin();
                                    else {
                                      widget.store.getRecord();
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (_) => new RollerDisplayRecord(
                                          recordStream:
                                              widget.store.recordStream,
                                          initRecord:
                                              widget.store.records ?? [],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// Rule Content
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: Themes.dialogBgTransparent,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(12.0),
                        ),
                      ),
                      child: RollerDisplayRules(
                        widget.store.rollerData?.rule ?? '',
                        onButtonTap: () {
                          if (!hasUser)
                            toastLogin();
                          else {
                            widget.store.getRequirement();
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => new RollerDisplayRequirement(
                                requirementStream:
                                    widget.store.requirementStream,
                                initRequirement: widget.store.requirement ??
                                    RollerRequirementModel(hasData: null),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
