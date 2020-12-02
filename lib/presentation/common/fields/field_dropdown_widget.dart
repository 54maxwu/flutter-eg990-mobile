import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

enum DropdownCornerType { NONE, ROUND_RIGHT, ROUND }

class FieldDropdownWidget extends StatefulWidget {
  /// [DropdownMenuItem]s text list
  final List<String> optionStrings;

  /// [DropdownMenuItem]s value list
  final List optionValues;

  /// Pass the option value back on item selected
  final ValueChanged changeNotify;

  /// Dropdown widget's selected index, default is 0.
  final int defaultValueIndex;

  final bool clearValueOnOptionChanged;

  final DropdownCornerType cornerType;

  const FieldDropdownWidget({
    Key key,
    @required this.optionValues,
    this.optionStrings,
    this.changeNotify,
    this.defaultValueIndex = 1,
    this.clearValueOnOptionChanged = false,
    this.cornerType = DropdownCornerType.NONE,
  }) : super(key: key);

  @override
  FieldDropdownWidgetState createState() => FieldDropdownWidgetState();
}

class FieldDropdownWidgetState extends State<FieldDropdownWidget> {
  BoxDecoration boxDecor;

  dynamic _dropdownValue;

  dynamic get selected => _dropdownValue;

  set setSelectedIndex(index) {
    _dropdownValue = widget.optionValues[0];
    setState(() {});
  }

  BoxDecoration get dropdownDecor {
    BorderRadius radius;
    switch (widget.cornerType) {
      case DropdownCornerType.NONE:
        radius = BorderRadius.zero;
        break;
      case DropdownCornerType.ROUND_RIGHT:
        radius = BorderRadius.horizontal(right: Radius.circular(8.0));
        break;
      case DropdownCornerType.ROUND:
        radius = BorderRadius.circular(8.0);
        break;
    }
    return BoxDecoration(
      color: themeColor.fieldFillColor,
      borderRadius: radius,
    );
  }

  @override
  void initState() {
    if (widget.optionStrings != null &&
        widget.optionStrings.length != widget.optionValues.length) {
      MyLogger.warn(
          msg: 'option string list length not match.'
              ' values: ${widget.optionValues.length},'
              ' strings: ${widget.optionStrings.length}',
          tag: 'FieldDropdownWidget');
    }
    if (widget.optionValues != null && widget.optionValues.isNotEmpty) {
      if (widget.clearValueOnOptionChanged) {
        _dropdownValue = null;
      } else if (widget.optionValues.length > widget.defaultValueIndex) {
        _dropdownValue = widget.optionValues[widget.defaultValueIndex];
      } else {
        _dropdownValue = widget.optionValues[0];
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    boxDecor ??= dropdownDecor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: boxDecor,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: AutoSizeText(
            localeStr.hintActionSelect,
            style: TextStyle(color: themeColor.fieldHintColor),
            minFontSize: FontSize.SMALL.value,
            maxFontSize: FontSize.NORMAL.value,
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: themeColor.fieldInputTextColor,
            size: 24.0,
          ),
          elevation: 4,
          isExpanded: false,
          isDense: true,
          style: TextStyle(
            color: themeColor.defaultTextColor,
            fontSize: FontSize.MESSAGE.value,
          ),
          dropdownColor: themeColor.defaultLayeredBackgroundColor,
          iconEnabledColor: themeColor.buttonPrimaryColor,
          value: _dropdownValue,
          onChanged: (data) {
            if (widget.changeNotify != null) {
              widget.changeNotify(data);
            }
            setState(() {
              _dropdownValue = data;
            });
          },
          selectedItemBuilder: (context) {
            if (widget.optionStrings != null &&
                widget.optionStrings.isNotEmpty) {
              return widget.optionStrings.map<Widget>((item) {
                return AutoSizeText(
                  '$item',
                  style: TextStyle(color: themeColor.secondaryTextColor2),
                  maxFontSize: FontSize.MESSAGE.value,
                );
              }).toList();
            } else {
              return widget.optionValues.map<Widget>((item) {
                return AutoSizeText(
                  '$item',
                  style: TextStyle(color: themeColor.secondaryTextColor2),
                  maxFontSize: FontSize.MESSAGE.value,
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
              child: AutoSizeText(
                '$itemText',
                style: TextStyle(
                  color: (_dropdownValue == item)
                      ? themeColor.defaultAccentColor
                      : themeColor.defaultTextColor,
                ),
                maxFontSize: FontSize.MESSAGE.value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
