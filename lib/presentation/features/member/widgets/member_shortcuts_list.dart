import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/common/settings/settings_ui.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_info_widget.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';

import '../data/member_shortcut_item.dart';

class MemberShortcutsList extends StatelessWidget {
  final bool hasUser;
  final Function logout;

  const MemberShortcutsList({@required this.hasUser, @required this.logout});

  Function onClickShortcut(MemberShortcutItem shortcut) => () {
        if (shortcut.value.route != null) {
          if (shortcut.value.isUserOnly && !hasUser) {
            callToastInfo(localeStr.hintActionLogin);
          } else {
            AppNavigator.navigateTo(shortcut.value.route);
          }
        } else if (shortcut.value.id == RouteEnum.LOGOUT) {
          logout();
        } else {
          callToastInfo(localeStr.msgWorkInProgress);
        }
      };

  @override
  Widget build(BuildContext context) {
    final shortcuts = MemberShortcutItem.mapByTypeIndex(2)
      ..sort((a, b) => a.value.section.compareTo(b.value.section));
    final int totalSection = shortcuts.last.value.section + 1;
    return SettingsList(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      sectionPadding: EdgeInsets.symmetric(vertical: 4.0),
      addBottomDivider: false,
      sections: List<SettingsSection>.generate(totalSection, (index) {
        final List<MemberShortcutItem> sectionItems = (hasUser)
            ? shortcuts.where((item) => item.value.section == index).toList()
            : shortcuts
                .where((item) =>
                    item.value.section == index &&
                    item.value.isUserOnly == false)
                .toList();
        return SettingsSection(
          addTileDivider: false,
          tiles: List<SettingsTile>.generate(
            sectionItems.length,
            (index) => _createTile(sectionItems[index]),
          ),
        );
      }),
    );
  }

  SettingsTile _createTile(MemberShortcutItem shortcut) {
    return SettingsTile(
      backgroundColor: Colors.white,
      title: '',
      leading: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(children: [
          WidgetSpan(
            child: Container(
                height: FontSize.MESSAGE.value * 1.5,
                width: FontSize.MESSAGE.value * 1.5,
                alignment: Alignment.center,
                child: Image.asset(shortcut.value.assetPath)),
          ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(shortcut.value.label,
                  style: TextStyle(
                    fontSize: FontSize.MESSAGE.value,
                    color: themeColor.defaultTextColor,
                  )),
            ),
          ),
        ]),
      ),
      trailing: RichText(
        text: TextSpan(children: [
          if (shortcut.value.hint.isNotEmpty)
            TextSpan(
              text: shortcut.value.hint,
              style: TextStyle(
                  fontSize: FontSize.NORMAL.value,
                  color: themeColor.defaultHintSubColor),
            ),
          WidgetSpan(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  size: FontSize.MESSAGE.value,
                  color: themeColor.defaultHintSubColor),
            ),
          )
        ]),
      ),
      onTap: onClickShortcut(shortcut),
    );
  }
}
