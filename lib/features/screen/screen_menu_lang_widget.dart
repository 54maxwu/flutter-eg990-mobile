import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/data/hive_actions.dart';
import 'package:flutter_eg990_mobile/core/internal/global.dart';
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
  final List<String> langValues = ['zh', 'en', 'vi', 'th'];
  final List<String> langOptions = ['CH', 'EN', 'VN', 'TH'];
  final List<String> langImg = [
    '/images/lang_chn.jpg',
    '/images/lang_eng.jpg',
    '/images/lang_vnm.jpg',
    '/images/lang_thai.jpg'
  ];

//  final List<String> langValues = ['zh'];
//  final List<String> langOptions = ['CH'];
//  final List<String> langImg = ['/images/lang_chn.jpg'];

  String _currentLang;

  @override
  void initState() {
    _currentLang = Global.lang;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isDense: true,
      iconSize: 0,
      underline: SizedBox.shrink(),
      items: List<DropdownMenuItem>.generate(langValues.length, (index) {
        return DropdownMenuItem(
          value: langValues[index],
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(36.0),
                    child: networkImageBuilder(
                      langImg[index],
                      imgScale: (index == 3) ? 10.0 : 1,
                    ),
                  ),
                ),
                Text(langOptions[index]),
              ],
            ),
          ),
        );
      }),
      selectedItemBuilder: (context) =>
          List<Widget>.generate(langValues.length, (index) {
        return Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Transform.scale(
            scale: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36.0),
              child: networkImageBuilder(
                langImg[index],
                imgScale: (index == 3) ? 10.0 : 1,
              ),
            ),
          ),
        );
      }),
      value: _currentLang,
      onChanged: (value) {
        debugPrint('selected lang: $value');
        if (Global.lang != value) {
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
            Global.setLanguage = newLang;
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
