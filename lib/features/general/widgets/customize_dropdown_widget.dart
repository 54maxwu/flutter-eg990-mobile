import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

import '../../../mylogger.dart';

class CustomizeDropdownWidget extends StatefulWidget {
  /// [DropdownMenuItem]s text list
  final List<String> optionStrings;

  /// [DropdownMenuItem]s value list
  final List optionValues;

  /// Pass the option value back on item selected
  final ValueChanged changeNotify;

  /// Dropdown widget's selected index, default is 0.
  final int defaultValueIndex;

  /// Expand the dropdown button.
  /// notice: if set to true, do not wrap with [Expanded] widget.
  final bool fixedWidget;

  /// Parent widget width, default is Device.width
  final double parentWidth;

  /// Widget's padding, default is vertical 2.0
  final EdgeInsetsGeometry padding;

  /// Total margin between this widget and device screen, default is 32.
  final double horizontalInset;

  /// Text space between letters and words
  final double titleLetterSpacing;

  final String prefixText;
  final IconData prefixIconData;
  final double titleWidthFactor;
  final double iconWidthFactor;
  final String suffixInitText;
  final Stream suffixTextStream;
  final double suffixWidthFactor;
  final double minusHeight;
  final double minusPrefixWidth;
  final bool clearValueOnMenuChanged;
  final bool whiteBox;
  final bool scaleText;
  final bool debug;

  CustomizeDropdownWidget({
    key,
    @required this.optionValues,
    this.optionStrings,
    this.changeNotify,
    this.defaultValueIndex = 0,
    this.fixedWidget = false,
    this.parentWidth,
    this.padding,
    this.horizontalInset = Themes.horizontalInset,
    this.prefixText,
    this.titleWidthFactor = Themes.prefixTextWidthFactor,
    this.titleLetterSpacing = Themes.prefixTextSpacing,
    this.prefixIconData,
    this.iconWidthFactor = Themes.prefixIconWidthFactor,
    this.suffixInitText,
    this.suffixTextStream,
    this.suffixWidthFactor = Themes.suffixWidthFactor,
    this.minusHeight = Themes.minusSize,
    this.minusPrefixWidth = Themes.minusSize,
    this.clearValueOnMenuChanged = false,
    this.whiteBox = false,
    this.scaleText = false,
    this.debug = false,
  }) : super(key: key);

  @override
  CustomizeDropdownWidgetState createState() => CustomizeDropdownWidgetState();
}

class CustomizeDropdownWidgetState extends State<CustomizeDropdownWidget> {
  double _viewWidth;
  double _smallWidgetHeight;
  BoxDecoration dropdownDecor;
  double _prefixWidth;
  Widget _prefixWidget;
  BoxConstraints _prefixConstraints;
  double _postfixWidth;
  Widget _postfixWidget;
  BoxConstraints _postfixConstraints;

  dynamic _dropdownValue;

  dynamic get selected => _dropdownValue;

  set setSelected(value) {
    _dropdownValue = value;
    setState(() {});
  }

  set setSelectedIndex(index) {
    _dropdownValue = widget.optionValues[0];
    setState(() {});
  }

  @override
  void initState() {
    _viewWidth = Global.device.width.roundToDouble() - widget.horizontalInset;

    _prefixWidth = ((widget.prefixText != null)
            ? _viewWidth * widget.titleWidthFactor
            : _viewWidth * widget.iconWidthFactor) -
        widget.minusPrefixWidth;
    if (_prefixWidth < 56.0) _prefixWidth = 56.0;

    _postfixWidth = _viewWidth * widget.suffixWidthFactor;

    _smallWidgetHeight =
        ((Global.device.isIos) ? Themes.fieldHeight + 8 : Themes.fieldHeight) -
            widget.minusHeight;
    if (widget.prefixIconData != null) _smallWidgetHeight += 8.0;

    if (widget.debug) {
      print(
          'screen width: ${Global.device.width}, view width: ${widget.parentWidth}');
      print('field prefix width: $_prefixWidth');
      print('option values: ${widget.optionValues}');
      print('option strings: ${widget.optionStrings}');
    }

    if (widget.optionStrings != null &&
        widget.optionStrings.length != widget.optionValues.length) {
      MyLogger.warn(
          msg: 'option string list length not match.'
              ' values: ${widget.optionValues.length},'
              ' strings: ${widget.optionStrings.length}',
          tag: 'TestDropdown');
    }
    if (widget.optionValues != null && widget.optionValues.isNotEmpty) {
      if (widget.clearValueOnMenuChanged)
        _dropdownValue = null;
      else if (widget.optionValues.length > widget.defaultValueIndex)
        _dropdownValue = widget.optionValues[widget.defaultValueIndex];
      else
        _dropdownValue = widget.optionValues[0];
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

    if (_postfixWidget == null &&
        widget.suffixInitText != null &&
        widget.suffixTextStream != null) {
      _postfixConstraints ??= BoxConstraints(
        minWidth: _postfixWidth,
        maxWidth: _postfixWidth,
        minHeight: _smallWidgetHeight,
      );
      _buildPostfix();
    }

    if (_postfixWidget == null && _prefixWidget != null) {
      dropdownDecor = BoxDecoration(
        color: (widget.whiteBox) ? Colors.white : Themes.fieldInputBgColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.0),
          bottomRight: Radius.circular(4.0),
        ),
      );
    } else {
      dropdownDecor = BoxDecoration(
        color: (widget.whiteBox) ? Colors.white : Themes.fieldInputBgColor,
        borderRadius: BorderRadius.circular(2.0),
      );
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
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: dropdownDecor,
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: FittedBox(
                    fit: (widget.scaleText) ? BoxFit.fitHeight : BoxFit.none,
                    child: Text(
                      localeStr.hintActionSelect,
                      style: TextStyle(
                        color: (widget.whiteBox)
                            ? Themes.defaultTextColorGrey
                            : Themes.defaultHintColorDark,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 0,
                  isExpanded: widget.fixedWidget == false,
                  isDense: true,
                  style: TextStyle(
                    color: (widget.whiteBox)
                        ? Themes.defaultTextColorGrey
                        : Themes.defaultTextColor,
                    fontSize: FontSize.SUBTITLE.value,
                  ),
                  dropdownColor: (widget.whiteBox)
                      ? Colors.white
                      : Themes.fieldInputBgColor,
                  iconEnabledColor: (widget.whiteBox)
                      ? Themes.defaultWidgetBgColor
                      : Themes.defaultWidgetColor,
                  value: _dropdownValue,
                  onChanged: (data) {
                    if (widget.changeNotify != null) widget.changeNotify(data);
                    if (widget.debug) print('selected: $data');
                    _dropdownValue = data;
                    setState(() {});
                  },
                  selectedItemBuilder: (context) {
                    if (widget.optionStrings != null &&
                        widget.optionStrings.isNotEmpty) {
                      return widget.optionStrings.map<Widget>((item) {
                        return FittedBox(
                          fit: (widget.scaleText)
                              ? BoxFit.fitHeight
                              : BoxFit.none,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: (widget.whiteBox)
                                  ? Themes.defaultTextColorGrey
                                  : Themes.defaultTextColorWhite,
                            ),
                          ),
                        );
                      }).toList();
                    } else {
                      return widget.optionValues.map<Widget>((item) {
                        return FittedBox(
                          fit: (widget.scaleText)
                              ? BoxFit.fitHeight
                              : BoxFit.none,
                          child: Text(
                            item,
                            style: TextStyle(
                              color: (widget.whiteBox)
                                  ? Themes.defaultTextColorGrey
                                  : Themes.defaultTextColorWhite,
                            ),
                          ),
                        );
                      }).toList();
                    }
                  },
                  items: widget.optionValues.map((item) {
                    int index = widget.optionValues.indexOf(item);
                    String itemText = (widget.optionStrings != null &&
                            widget.optionStrings.length > index &&
                            widget.optionStrings.elementAt(index) != null)
                        ? widget.optionStrings[index]
                        : item.toString();
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        itemText,
                        style: TextStyle(
                          color: (_dropdownValue == item)
                              ? Themes.defaultAccentColor
                              : (widget.whiteBox)
                                  ? Themes.defaultTextColorGrey
                                  : Themes.defaultTextColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          if (_postfixWidget != null) _postfixWidget,
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

  void _buildPostfix() {
    _postfixWidget ??= Container(
      constraints: _postfixConstraints,
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      decoration: BoxDecoration(
        color: Themes.fieldInputBgColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.0),
          bottomRight: Radius.circular(4.0),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: StreamBuilder<String>(
          stream: widget.suffixTextStream,
          builder: (context, snapshot) {
            bool reset = snapshot.data == null || snapshot.data.isEmpty;
            String text = (reset) ? widget.suffixInitText : snapshot.data;
            if (widget.debug) print('${widget.prefixText} postText: $text');
            return Text(
              text,
              style: TextStyle(
                color: (reset)
                    ? Themes.defaultHintColorDark
                    : Themes.hintHighlightYellow,
              ),
            );
          }),
    );
  }
}
