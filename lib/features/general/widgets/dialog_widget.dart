import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

class DialogWidget extends StatefulWidget {
  final Key key;

  final BoxConstraints constraints;

  /// List of widgets that's inside a dialog.
  ///
  /// {@macro flutter.widgets.children}
  final List<Widget> children;

  final bool canClose;

  final Function onClose;

  final double heightFactor;

  final double minHeight;

  final double maxHeight;

  final double widthShrink;

  final double roundParam;

  final bool noBackground;

  final bool transparentBg;

  final bool lightBg;

  final bool darkBg;

  final Color customBg;

  final bool debug;

  DialogWidget({
    this.key,
    @required this.children,
    this.constraints,
    this.canClose = true,
    this.onClose,
    this.heightFactor = 0.85,
    this.minHeight,
    this.maxHeight,
    this.widthShrink = 32.0,
    this.roundParam = 16.0,
    this.noBackground = false,
    this.transparentBg = false,
    this.lightBg = false,
    this.darkBg = false,
    this.customBg,
    this.debug = false,
  }) : super(key: key);

  @override
  DialogWidgetState createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget> {
  final Duration insetAnimationDuration = const Duration(milliseconds: 100);
  final Curve insetAnimationCurve = Curves.decelerate;

  Color bgColor;
  double dialogHeight;
  double dialogWidth;
  double contentWidth;

  void updateHeightFactor(double heightFactor) {
    dialogHeight = Global.device.height * heightFactor;
    if (widget.maxHeight != null && dialogHeight > widget.maxHeight)
      dialogHeight = widget.maxHeight;
    if (widget.minHeight != null && dialogHeight < widget.minHeight)
      dialogHeight = widget.minHeight;
    setState(() {});
  }

  @override
  void initState() {
    dialogHeight = Global.device.height * widget.heightFactor;
    // screen width - dialog padding
    dialogWidth = Global.device.width - widget.widthShrink;
    // screen width - dialog padding - stack padding - text padding
    contentWidth = Global.device.width - widget.widthShrink - 20 - 8;
    if (widget.debug) {
      print('dialog is h$dialogHeight * w$dialogWidth');
      print('dialog max height: ${widget.maxHeight}');
      print('dialog content width: $contentWidth');
    }
    if (widget.maxHeight != null && dialogHeight > widget.maxHeight)
      dialogHeight = widget.maxHeight;
    if (widget.minHeight != null && dialogHeight < widget.minHeight)
      dialogHeight = widget.minHeight;

    if (widget.customBg != null)
      bgColor = widget.customBg;
    else if (widget.noBackground)
      bgColor = Colors.transparent;
    else if (widget.transparentBg)
      bgColor = Themes.dialogBgTransparent;
    else if (widget.darkBg)
      bgColor = Themes.dialogBgColorDark;
    else if (widget.lightBg)
      bgColor = Themes.dialogBgColorLight;
    else
      bgColor = Themes.dialogBgColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(
            horizontal: widget.widthShrink / 2,
            vertical: 16.0,
          ),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            // round corner view
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.roundParam)),
            ),
            color: bgColor,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                constraints: widget.constraints ??
                    BoxConstraints(
                      minWidth: dialogWidth,
                      maxWidth: dialogWidth,
                      minHeight: dialogHeight / 4,
                      maxHeight: dialogHeight,
                    ),
                child: Stack(
                  children: (widget.canClose)
                      ? widget.children +
                          [
                            Positioned(
                              right: 2.0,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  if (widget.onClose != null) widget.onClose();
                                  // clear text field focus
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ]
                      : widget.children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
