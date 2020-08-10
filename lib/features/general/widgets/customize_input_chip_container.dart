import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/themes.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_titled_container.dart';

typedef ChipTapCall = void Function(dynamic);

class CustomizeInputChipContainer extends StatefulWidget {
  final double parentWidth;
  final EdgeInsetsGeometry padding;
  final double horizontalInset;
  final double heightFactor;
  final double titleLetterSpacing;
  final String prefixTitle;
  final IconData prefixIconData;
  final double titleWidthFactor;
  final double iconWidthFactor;

  final List<String> labels;
  final List values;
  final ChipTapCall chipTapCall;
  final double chipSpacing;

  CustomizeInputChipContainer({
    Key key,
    @required this.labels,
    @required this.values,
    this.chipTapCall,
    this.chipSpacing = 6.0,
    this.parentWidth,
    this.padding,
    this.horizontalInset = 32.0,
    this.heightFactor = 1,
    this.prefixTitle,
    this.titleWidthFactor = Themes.prefixTextWidthFactor,
    this.titleLetterSpacing = Themes.prefixTextSpacing,
    this.prefixIconData,
    this.iconWidthFactor = Themes.prefixIconWidthFactor,
  }) : super(key: key);

  @override
  _CustomizeInputChipContainerState createState() =>
      _CustomizeInputChipContainerState();
}

class _CustomizeInputChipContainerState
    extends State<CustomizeInputChipContainer> {
  List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    if (chips == null) {
      chips = new List();
      int index = 0;
      for (String label in widget.labels) {
        chips.add(_createChip(label, widget.values[index]));
        index++;
      }
    }

    return CustomizeTitledContainer(
      parentWidth: widget.parentWidth,
      padding: widget.padding,
      horizontalInset: widget.horizontalInset,
      heightFactor: widget.heightFactor,
      prefixText: widget.prefixTitle,
      titleWidthFactor: widget.titleWidthFactor,
      titleLetterSpacing: widget.titleLetterSpacing,
      prefixIconData: widget.prefixIconData,
      iconWidthFactor: widget.iconWidthFactor,
      child: Wrap(
        spacing: widget.chipSpacing,
        children: chips,
      ),
    );
  }

  Widget _createChip(String labelText, dynamic returnOnPress) {
    return InputChip(
      visualDensity: VisualDensity.compact,
      label: Text(
        labelText,
        style: TextStyle(color: Themes.defaultAccentColor),
      ),
      onPressed: () =>
          (widget.chipTapCall != null) ? widget.chipTapCall(returnOnPress) : {},
    );
  }
}
