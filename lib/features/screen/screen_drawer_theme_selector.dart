import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/horizontal_radio_group_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_color_enum.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

class ScreenDrawerThemeSelector extends StatefulWidget {
  @override
  ScreenDrawerThemeSelectorState createState() =>
      ScreenDrawerThemeSelectorState();
}

class ScreenDrawerThemeSelectorState extends State<ScreenDrawerThemeSelector> {
  final List<ThemeColorEnum> _themes = [
    ThemeColorEnum.DEFAULT,
  ];

  final GlobalKey<HorizontalRadioGroupWidgetState> _radiosKey =
      new GlobalKey(debugLabel: 'themes');

  ThemeColorEnum _selected;

  @override
  void initState() {
    _selected = _themes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: RichText(
            maxLines: 2,
            textAlign: TextAlign.start,
            text: TextSpan(
              text: localeStr.themeColorHintSelect,
              style: TextStyle(
                color: themeColor.defaultHintSubColor,
                fontSize: FontSize.SMALLER.value,
              ),
            ),
          ),
        ),
        HorizontalRadioGroupWidget(
          _radiosKey,
          radioLabels: _themes.map((e) => e.label).toList(),
          radioValues: _themes,
          initIndex: _themes.indexOf(_selected),
          callback: (selected) {
            if (selected is ThemeColorEnum) {
              debugPrint('selected theme: ${selected.value}');
              _selected = selected;
            } else {
              debugPrint('error theme color enum data type!!');
            }
          },
        ),
      ],
    );
  }
}
