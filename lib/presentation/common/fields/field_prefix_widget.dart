import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';

enum FieldPrefixCornerType { NONE, ROUND_LEFT }

class FieldPrefixWidget extends StatelessWidget {
  final String prefixText;
  final IconData prefixIcon;
  final TextStyle textStyle;
  final FieldPrefixCornerType cornerType;
  final double cornerRadius;

  const FieldPrefixWidget.complex({
    @required this.prefixText,
    @required this.prefixIcon,
    this.textStyle,
    this.cornerType = FieldPrefixCornerType.NONE,
    this.cornerRadius = 0,
  });

  const FieldPrefixWidget.text({
    @required this.prefixText,
    this.textStyle,
    this.cornerType = FieldPrefixCornerType.NONE,
    this.cornerRadius = 0,
  }) : this.prefixIcon = null;

  const FieldPrefixWidget.icon({
    @required this.prefixIcon,
    this.textStyle,
    this.cornerType = FieldPrefixCornerType.NONE,
    this.cornerRadius = 0,
  }) : this.prefixText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: (cornerType.index == 0)
            ? BorderRadius.zero
            : BorderRadius.horizontal(left: Radius.circular(cornerRadius)),
      ),
      alignment: Alignment.centerLeft,
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          children: <InlineSpan>[
            if (prefixIcon != null)
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        prefixIcon,
                        size: 1.5 *
                            (textStyle?.fontSize ?? FontSize.NORMAL.value),
                        color: themeColor.fieldPrefixTextColor,
                      )
                    ],
                  ),
                ),
              ),
            TextSpan(
              text: prefixText,
              style:
                  textStyle?.copyWith(color: themeColor.fieldPrefixTextColor) ??
                      TextStyle(
                        fontSize: FontSize.NORMAL.value,
                        color: themeColor.fieldPrefixTextColor,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
