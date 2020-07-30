import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

///
///
/// TODO separate prefix widget (and add suffix widget?)
///
class CustomizeTitledContainer extends StatefulWidget {
  /// Parent widget width, default is Device.width
  final double parentWidth;

  /// Widget's padding, default is vertical 2.0
  final EdgeInsetsGeometry padding;

  /// Total margin between this widget and device screen, default is 32.
  final double horizontalInset;

  final double heightFactor;

  final AlignmentGeometry childAlignment;

  /// Text space between letters and words
  final double titleLetterSpacing;

  final String prefixText;
  final IconData prefixIconData;
  final double titleWidthFactor;
  final double iconWidthFactor;
  final double minusHeight;
  final double minusPrefixWidth;
  final bool debug;

  final Widget child;

  CustomizeTitledContainer({
    Key key,
    this.child,
    this.childAlignment = Alignment.centerLeft,
    this.parentWidth,
    this.padding,
    this.horizontalInset = Themes.horizontalInset,
    this.heightFactor = 1,
    this.prefixText,
    this.prefixIconData,
    this.titleWidthFactor = Themes.prefixTextWidthFactor,
    this.titleLetterSpacing = Themes.prefixTextSpacing,
    this.iconWidthFactor = Themes.prefixIconWidthFactor,
    this.minusHeight = Themes.minusSize,
    this.minusPrefixWidth = Themes.minusSize,
    this.debug = false,
  }) : super(key: key);

  @override
  _CustomizeTitledContainerState createState() =>
      _CustomizeTitledContainerState();
}

class _CustomizeTitledContainerState extends State<CustomizeTitledContainer> {
  double _viewWidth;
  double _smallWidgetHeight;
  double _prefixWidth;
  Widget _prefixWidget;
  BoxConstraints _prefixConstraints;

  @override
  void initState() {
    _viewWidth = (widget.parentWidth ?? Global.device.width).roundToDouble() -
        widget.horizontalInset;

    _prefixWidth = ((widget.prefixText != null)
            ? _viewWidth * widget.titleWidthFactor
            : _viewWidth * widget.iconWidthFactor) -
        widget.minusPrefixWidth;
    if (_prefixWidth < 56.0) _prefixWidth = 56.0;

    _smallWidgetHeight =
        ((Global.device.isIos) ? Themes.fieldHeight + 8 : Themes.fieldHeight) *
                widget.heightFactor -
            widget.minusHeight;
    if (widget.prefixIconData != null) _smallWidgetHeight += 8.0;

    if (widget.debug) {
      print('screen width: ${Global.device.width}');
      print('field prefix width: $_prefixWidth');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_prefixWidget == null &&
        (widget.prefixText != null || widget.prefixIconData != null)) {
      _prefixConstraints ??= BoxConstraints(
        minWidth: _prefixWidth,
        maxWidth: _prefixWidth,
        minHeight: _smallWidgetHeight,
      );
      _buildPrefix();
    }

    return Container(
      padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 2.0),
      constraints: BoxConstraints.tightFor(
        width: _viewWidth,
        height: _smallWidgetHeight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_prefixWidget != null) _prefixWidget,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              alignment: widget.childAlignment,
              decoration: BoxDecoration(
                color: Themes.fieldInputBgColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                ),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  void _buildPrefix() {
    if (widget.prefixText != null && widget.prefixIconData != null) {
      _prefixWidget = Container(
        constraints: _prefixConstraints,
        decoration: BoxDecoration(
          color: Themes.defaultWidgetBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(
                widget.prefixIconData,
                size: Themes.fieldIconSize,
                color: Themes.iconColorLightGrey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Text(
                widget.prefixText,
                style: TextStyle(
//              fontSize: FontSize.SUBTITLE.value,
                  wordSpacing: widget.titleLetterSpacing / 2,
                  letterSpacing: widget.titleLetterSpacing / 4,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    } else if (widget.prefixText != null) {
      _prefixWidget = Container(
        constraints: _prefixConstraints,
        decoration: BoxDecoration(
          color: Themes.defaultWidgetBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
          ),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 4.0),
        child: Text(
          widget.prefixText,
          style: TextStyle(
//              fontSize: FontSize.SUBTITLE.value,
            wordSpacing: widget.titleLetterSpacing,
            letterSpacing: widget.titleLetterSpacing,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else if (widget.prefixIconData != null) {
      _prefixWidget = Container(
        constraints: _prefixConstraints,
        decoration: BoxDecoration(
          color: Themes.defaultWidgetBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0),
            bottomLeft: Radius.circular(4.0),
          ),
        ),
        child: Center(
          child: Icon(
            widget.prefixIconData,
            size: Themes.fieldIconSize,
            color: Themes.iconColorLightGrey,
          ),
        ),
      );
    }
  }
}
