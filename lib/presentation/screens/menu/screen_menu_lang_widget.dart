import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/data/app_cache.dart';
import 'package:flutter_eg990_mobile/application/internal/language_code.dart';
import 'package:flutter_eg990_mobile/application/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/network_image.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/presentation/screens/streams/app_preference_streams.dart';

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
    _currentLang = Global.localeCode;
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
                Transform.scale(
                  scale: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36.0),
                    child: NetworkImageBuilder(
                      _langs[index].value.imageUrl,
                      scale: (index == 3) ? 10.0 : 1,
                    ),
                  ),
                ),
                Text(_langs[index].value.optionString),
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
              child: NetworkImageBuilder(
                _langs[index].value.imageUrl,
                scale: (index == 3) ? 10.0 : 1,
              ),
            ),
          ),
        );
      }),
      value: _currentLang,
      onChanged: (value) {
        debugPrint('selected lang: $value');
        if (Global.localeCode != value) {
          String newLang = value;
          try {
            sl.get<LocalStrings>()?.setLanguage(newLang);
            AppCache.saveAppLocale(LanguageCode.getByCode(newLang));
          } catch (e) {
            MyLogger.error(
                msg: 'Localize File not initialized', tag: 'LocalStrings');
          } finally {
            Global.setLocaleByCode = newLang;
            if (mounted) {
              _currentLang = newLang;
            }
            Future.delayed(Duration(milliseconds: 100), () {
              appPreference.setLanguage(newLang);
            });
          }
        }
      },
    );
  }
}
