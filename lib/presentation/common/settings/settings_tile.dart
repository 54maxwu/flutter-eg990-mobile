import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'cupertino_settings_item.dart';

enum _SettingsTileType { simple, switchTile }

class SettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final VoidCallback onTap;
  final Function(bool value) onToggle;
  final bool switchValue;
  final bool enabled;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final Color switchActiveColor;
  final Color backgroundColor;
  final EdgeInsets contentPadding;
  final _SettingsTileType _tileType;

  const SettingsTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.enabled = true,
    this.switchActiveColor,
    this.backgroundColor,
    this.contentPadding,
  })  : _tileType = _SettingsTileType.simple,
        onToggle = null,
        switchValue = null,
        super(key: key);

  const SettingsTile.switchTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    this.enabled = true,
    this.trailing,
    @required this.onToggle,
    @required this.switchValue,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.switchActiveColor,
    this.backgroundColor,
    this.contentPadding,
  })  : _tileType = _SettingsTileType.switchTile,
        onTap = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.transparent,
      margin: contentPadding ?? EdgeInsets.zero,
      child: (kIsWeb || Platform.isIOS) ? iosTile() : androidTile(),
    );
  }

  Widget iosTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.toggle,
        label: title,
        leading: leading,
        switchValue: switchValue,
        onToggle: onToggle,
        labelTextStyle: titleTextStyle,
        switchActiveColor: switchActiveColor,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    } else {
      return CupertinoSettingsItem(
        enabled: enabled,
        type: SettingsItemType.modal,
        label: title,
        value: subtitle,
        trailing: trailing,
        hasDetails: false,
        leading: leading,
        onPress: onTap,
        labelTextStyle: titleTextStyle,
        subtitleTextStyle: subtitleTextStyle,
        valueTextStyle: subtitleTextStyle,
      );
    }
  }

  Widget androidTile() {
    if (_tileType == _SettingsTileType.switchTile) {
      return SwitchListTile(
        secondary: leading,
        value: switchValue,
        activeColor: switchActiveColor,
        onChanged: enabled ? onToggle : null,
        title: Text(title, style: titleTextStyle),
        subtitle:
            subtitle != null ? Text(subtitle, style: subtitleTextStyle) : null,
        dense: true,
      );
    } else {
      return ListTile(
        title: Text(title, style: titleTextStyle),
        subtitle:
            subtitle != null ? Text(subtitle, style: subtitleTextStyle) : null,
        leading: leading,
        dense: true,
        enabled: enabled,
        trailing: trailing,
        onTap: onTap,
      );
    }
  }
}
