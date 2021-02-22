import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/data/hive_actions.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
import 'package:flutter_eg990_mobile/core/internal/language_code.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_eg990_mobile/injection_container.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';

class ScreenMenuLangWidget extends StatefulWidget {
  @override
  _ScreenMenuLangWidgetState createState() => _ScreenMenuLangWidgetState();
}

class _ScreenMenuLangWidgetState extends State<ScreenMenuLangWidget> {
  List<LanguageCode> _langs;
  String _currentLang;

  @override
  void initState() {
    _langs = LanguageCode.listAll;
    _currentLang = Global.lang.code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isDense: true,
      iconSize: 0,
      underline: SizedBox.shrink(),
      items: List<DropdownMenuItem>.generate(_langs.length, (index) {
        return DropdownMenuItem(
          value: _langs[index].value.code,
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(36.0),
                  child: networkImageBuilder(
                    _langs[index].value.imageUrl,
                    imgScale: (index == 3) ? 10.0 : 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    _langs[index].value.optionString,
                    style: TextStyle(
                      fontSize: FontSize.SUBTITLE.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      selectedItemBuilder: (context) =>
          List<Widget>.generate(_langs.length, (index) {
        return Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Transform.scale(
            scale: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36.0),
              child: networkImageBuilder(
                _langs[index].value.imageUrl,
                imgScale: (index == 3) ? 10.0 : 1,
              ),
            ),
          ),
        );
      }),
      value: _currentLang,
      onChanged: (value) {
        debugPrint('selected lang: $value');
        if (Global.lang.code != value) {
          String newLang = value;
          try {
            sl.get<LocalStrings>()?.setLanguage(newLang);
            Future.microtask(() async {
              Box box = await Future.value(getHiveBox(Global.CACHE_APP_DATA));
              if (box != null) {
                await box.put(Global.CACHE_APP_DATA_KEY_LANG, newLang);
                debugPrint(
                    'box lang: ${box.get(Global.CACHE_APP_DATA_KEY_LANG)}');
              }
            });
          } catch (e) {
            MyLogger.error(
                msg: 'Localize File not initialized', tag: 'LocalStrings');
          } finally {
            Global.lang.setLocale = newLang;
            if (mounted) {
              _currentLang = newLang;
            }
            Future.delayed(Duration(milliseconds: 100), () {
              getAppGlobalStreams.setLanguage(newLang);
            });
          }
        }
      },
    );
  }
}
