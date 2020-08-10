import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';

///
/// Separate checkbox widget to prevent screen flash
///

typedef CheckBoxCallBack = void Function(bool);

class CheckboxWidget extends StatefulWidget {
  final String label;
  final Color labelColor;
  final bool initValue;
  final EdgeInsets widgetPadding;
  final CheckBoxCallBack onChecked;

  CheckboxWidget(
      {Key key,
      @required this.label,
      this.labelColor,
      this.initValue = false,
      this.widgetPadding = const EdgeInsets.only(top: 2.0),
      this.onChecked})
      : super(key: key);

  @override
  CheckboxWidgetState createState() => CheckboxWidgetState();
}

class CheckboxWidgetState extends State<CheckboxWidget> {
  bool boxChecked;

  set setChecked(bool checked) {
    boxChecked = checked;
    setState(() {});
  }

  @override
  void initState() {
    boxChecked = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.widgetPadding,
      child: (widget.labelColor != null)
          ? Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(
                    unselectedWidgetColor: widget.labelColor,
                  ),
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    value: boxChecked,
                    onChanged: (value) {
                      setChecked = value;
                      if (widget.onChecked != null) widget.onChecked(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, left: 2.0),
                  child: Text(widget.label,
                      style: TextStyle(color: widget.labelColor)),
                ),
              ],
            )
          : Row(
              children: <Widget>[
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  value: boxChecked,
                  onChanged: (value) {
                    setChecked = value;
                    if (widget.onChecked != null) widget.onChecked(value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, left: 2.0),
                  child: Text(
                    widget.label,
                    style: TextStyle(color: Themes.defaultTextColor),
                  ),
                ),
              ],
            ),
    );
  }
}
