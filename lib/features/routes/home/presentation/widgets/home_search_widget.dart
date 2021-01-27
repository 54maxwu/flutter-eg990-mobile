import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';

import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/gradient_button.dart';

typedef OnSearch = void Function(String);

class HomeSearchWidget extends StatefulWidget {
  final OnSearch onSearch;

  HomeSearchWidget({@required this.onSearch});

  @override
  _HomeSearchWidgetState createState() => _HomeSearchWidgetState();
}

class _HomeSearchWidgetState extends State<HomeSearchWidget> {
  final GlobalKey<CustomizeFieldWidgetState> _searchFieldKey =
      new GlobalKey(debugLabel: 'search');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 4.0),
      alignment: Alignment.center,
      child: Material(
        elevation: 6.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new CustomizeFieldWidget(
                  key: _searchFieldKey,
                  persistHint: false,
                  prefixBgColor: Themes.fieldInputSubBgColor,
                  useSameBgColor: true,
                  padding: EdgeInsets.zero,
                  fieldTextSize: FontSize.SUBTITLE.value,
                  hint: '',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GradientButton(
                  child: Text(localeStr.btnSearch),
                  onPressed: () => widget
                      .onSearch(_searchFieldKey.currentState?.getInput ?? ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
