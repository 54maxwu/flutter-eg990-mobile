import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'abstract_section.dart';
import 'cupertino_settings_section.dart';
import 'settings_tile.dart';

// ignore: must_be_immutable
class SettingsSection extends AbstractSection {
  final List<SettingsTile> tiles;
  final TextStyle titleTextStyle;
  final bool addTileDivider;

  SettingsSection({
    Key key,
    String title,
    this.addTileDivider = false,
    this.tiles,
    this.titleTextStyle,
  }) : super(key: key, title: title);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || Platform.isIOS)
      return iosSection();
    else if (Platform.isAndroid)
      return androidSection(context);
    else
      return androidSection(context);
  }

  Widget iosSection() {
    return CupertinoSettingsSection(
      tiles,
      header: title == null ? null : Text(title, style: titleTextStyle),
    );
  }

  Widget androidSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: titleTextStyle ??
                    TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
      (addTileDivider)
          ? ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tiles.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                return tiles[index];
              },
            )
          : ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: tiles.length,
              itemBuilder: (BuildContext context, int index) {
                return tiles[index];
              },
            ),
      if (addTileDivider || showBottomDivider) Divider(height: 1)
    ]);
  }
}
