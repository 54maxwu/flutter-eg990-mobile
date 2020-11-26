import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';

import '../data/member_shortcut_item.dart';

class MemberShortcuts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shortcutsTop = MemberShortcutItem.mapByTypeIndex(1);
    final shortcuts = MemberShortcutItem.mapByTypeIndex(0);
    return Container(
      padding: const EdgeInsets.fromLTRB(6.0, 24.0, 6.0, 12.0),
      decoration: BoxDecoration(
        color: themeColor.defaultBackgroundColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.0)),
      ),
      child: Column(
        children: [
          Material(
            elevation: 6.0,
            color: themeColor.defaultBackgroundColor,
            shadowColor: Colors.black38,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: Global.APP_NAV_HEIGHT,
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: List.generate(
                  shortcutsTop.length * 2 - 1,
                  (index) {
                    if (index % 2 == 1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: VerticalDivider(thickness: 0.2),
                      );
                    } else {
                      return _createComplexShortcut((index > 0)
                          ? shortcutsTop[index ~/ 2]
                          : shortcutsTop[0]);
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: List.generate(
                shortcuts.length,
                (index) => _createShortcut(shortcuts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createComplexShortcut(MemberShortcutItem shortcut) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(shortcut.value.assetPath),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: AutoSizeText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: shortcut.value.label,
                    style: TextStyle(
                      color: themeColor.defaultTextColor,
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: '\n${shortcut.value.hint}',
                    style: TextStyle(
                      color: themeColor.defaultHintColor,
                      fontSize: FontSize.SMALLER.value,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              maxFontSize: FontSize.TITLE.value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createShortcut(MemberShortcutItem shortcut) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Image.asset(shortcut.value.assetPath, scale: 1.75),
            Container(
              height: FontSize.MESSAGE.value * 1.5,
              padding: const EdgeInsets.only(top: 6.0),
              child: AutoSizeText(
                shortcut.value.label,
                style: TextStyle(
                  color: themeColor.defaultTextColor,
                  fontSize: FontSize.MESSAGE.value,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                maxFontSize: FontSize.SUBTITLE.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
