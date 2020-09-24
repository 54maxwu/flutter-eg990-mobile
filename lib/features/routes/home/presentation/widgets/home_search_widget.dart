import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/mobx_store_export.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/gradient_button.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

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
      margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: themeColor.defaultTabUnselectedColor,
      ),
      alignment: Alignment.center,
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
                prefixBgColor: themeColor.fieldPrefixBgColor,
                useSameBgColor: true,
                padding: EdgeInsets.zero,
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
    );
  }
}
