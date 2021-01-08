import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

enum ChipsBorder {
  NONE,
  BEVELED,
  ROUNDED_RECTANGLE,
  CONTINUOUS_RECTANGLE,
  STADIUM,
  ROUND,
}

typedef OnChipTap = void Function(dynamic);

class FieldChipsWrapperWidget extends StatelessWidget {
  /// [Chip]s text list
  final List<String> labels;

  /// [Chip]s value list, should be String or num
  final List<dynamic> values;

  /// Passes the chip's value on tap
  final OnChipTap onChipTap;

  /// Space between each chip
  final double spaceBetween;

  /// Chip's border style
  final ChipsBorder borderType;

  final Radius borderRadius;

  /// Chip's background style
  final Color chipColor;

  /// Chip's text style
  final TextStyle chipTextStyle;

  const FieldChipsWrapperWidget({
    Key key,
    @required this.values,
    this.labels,
    this.chipTextStyle,
    this.spaceBetween = 6,
    this.borderType = ChipsBorder.ROUNDED_RECTANGLE,
    this.borderRadius,
    @required this.onChipTap,
    this.chipColor,
  })  : assert(values != null && values.length > 0, 'Chip has no value'),
        assert(
            labels == null ||
                (labels != null && labels.length == values.length),
            'labels length does not match values length'),
        super(key: key);

  ShapeBorder get chipBorder {
    switch (borderType) {
      case ChipsBorder.BEVELED:
        return BeveledRectangleBorder(
            side: BorderSide(color: themeColor.defaultDividerColor),
            borderRadius: borderRadius ?? BorderRadius.circular(6));
      case ChipsBorder.ROUNDED_RECTANGLE:
        return RoundedRectangleBorder(
            side: BorderSide(color: themeColor.defaultDividerColor),
            borderRadius: borderRadius ?? BorderRadius.circular(6));
      case ChipsBorder.CONTINUOUS_RECTANGLE:
        return ContinuousRectangleBorder(
            side: BorderSide(color: themeColor.defaultDividerColor),
            borderRadius: borderRadius ?? BorderRadius.circular(20));
      case ChipsBorder.STADIUM:
        return StadiumBorder(
            side: BorderSide(color: themeColor.defaultDividerColor));
      case ChipsBorder.ROUND:
        return CircleBorder(
            side: BorderSide(color: themeColor.defaultDividerColor));
      case ChipsBorder.NONE:
        return RoundedRectangleBorder();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> chipLabels =
        (labels != null && labels.length == values.length)
            ? labels
            : values.map((e) => '$e').toList(growable: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Wrap(
              spacing: spaceBetween,
              children: List.generate(
                values.length,
                (index) {
                  return InputChip(
                    visualDensity: VisualDensity.compact,
                    label: Text(
                      chipLabels[index],
                      style: chipTextStyle ??
                          TextStyle(
                            fontSize: FontSize.MESSAGE.value,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    shape: chipBorder,
                    backgroundColor: (borderType == ChipsBorder.NONE)
                        ? Colors.transparent
                        : themeColor.fieldFillColor,
                    onPressed: () => onChipTap(values[index]),
                  );
                },
              ));
        },
      ),
    );
  }
}
