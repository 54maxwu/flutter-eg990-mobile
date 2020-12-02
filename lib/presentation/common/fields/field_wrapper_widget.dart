import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

import 'field_prefix_widget.dart';
import 'field_input_widget.dart';
import 'field_dropdown_widget.dart';

class FieldWrapperWidget extends StatelessWidget {
  final FieldPrefixWidget prefixWidget;
  final FieldDropdownWidget optionWidget;
  final BoxConstraints prefixConstraint;
  final FieldInputWidget inputWidget;
  final BoxDecoration decoration;
  final EdgeInsets padding;
  final EdgeInsets prefixPadding;
  final EdgeInsets fieldPadding;

  const FieldWrapperWidget({
    this.prefixWidget,
    this.prefixConstraint,
    @required this.inputWidget,
    this.decoration,
    this.padding = EdgeInsets.zero,
    this.prefixPadding,
    this.fieldPadding,
  }) : this.optionWidget = null;

  const FieldWrapperWidget.option({
    this.prefixWidget,
    this.prefixConstraint,
    @required this.optionWidget,
    this.decoration,
    this.padding = EdgeInsets.zero,
    this.prefixPadding,
    this.fieldPadding,
  }) : this.inputWidget = null;

  EdgeInsets get getPrefixPadding {
    if (prefixPadding != null) return prefixPadding;
    if (inputWidget != null && prefixWidget.prefixIcon == null) {
      return const EdgeInsets.only(top: 6.0);
    }
    return EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: padding,
      decoration:
          decoration ?? BoxDecoration(color: themeColor.fieldPrefixFillColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: (inputWidget != null)
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          if (prefixWidget != null)
            Padding(
              padding: getPrefixPadding,
              child: Container(
                constraints: prefixConstraint ??
                    BoxConstraints.loose(
                      Size(Global.device.width / 4, double.infinity),
                    ),
                child: prefixWidget,
              ),
            ),
          Expanded(
            child: Container(
              padding: fieldPadding ?? EdgeInsets.zero,
              child: inputWidget ??
                  Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: optionWidget),
            ),
          ),
        ],
      ),
    );
  }
}
