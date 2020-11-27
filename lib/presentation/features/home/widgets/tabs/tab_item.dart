import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/icon_code.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/category/game_category_info.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/network_image.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:provider/provider.dart';

import 'tab_control.dart';

class TabItem extends StatefulWidget {
  final int index;
  final GameCategoryInfo info;
  final IconData iconData;

  TabItem({
    @required this.index,
    @required this.info,
    this.iconData = IconCode.tabUnknown,
  });

  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  final Size _selectedImageSize =
      const Size(36.0, 36.0) * Global.device.widthScale;
  final Size _imageSize = const Size(30.0, 30.0) * Global.device.widthScale;

  bool _selected;
  IconData _iconData;
  String _networkImage = '';
  String _assetPath = '';
  String _selectedAssetPath = '';

  Widget _image;

  @override
  void initState() {
    switch (widget.info.iconType) {
      case GameCategoryIconType.NETWORK:
        _networkImage = widget.info.imageUrl;
        break;
      case GameCategoryIconType.ASSET:
        _assetPath = widget.info.assetPath;
        _selectedAssetPath = widget.info.selectedAssetPath;
        break;
      case GameCategoryIconType.ICON:
        _iconData = widget.iconData;
        break;
    }
    super.initState();
  }

  Widget updateImage(bool selected) {
    if (selected && _selectedAssetPath.isNotEmpty)
      return Image.asset(_selectedAssetPath);
    else if ((!selected && _assetPath.isNotEmpty) ||
        (selected && _selectedAssetPath.isEmpty && _assetPath.isNotEmpty))
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(_assetPath),
      );
    else if (_assetPath.isEmpty && _networkImage.isNotEmpty)
      return NetworkImageBuilder(_networkImage);
    else
      return Icon(
        _iconData,
        color: themeColor.homeTabIconColor,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<TabControl, int>(
      selector: (_, provider) => provider.getTabIndex,
      builder: (_, index, __) {
        // debugPrint('tab ${widget.index} receives index change: $index');
        if (_selected != (index == widget.index)) {
          _image = updateImage(index == widget.index);
          _selected = index == widget.index;
        }
        return Container(
          height: 48.0 * Global.device.heightScale,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: (_selected)
                  ? ExactAssetImage(Res.tab_bg_selected)
                  : ExactAssetImage(Res.tab_bg_normal),
              fit: BoxFit.fill,
            ),
          ),
          child: RichText(
            textAlign: TextAlign.center,
            maxLines: 1,
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        constraints: (_selected)
                            ? BoxConstraints.tight(_selectedImageSize)
                            : BoxConstraints.tight(_imageSize),
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: _image,
                      ),
                      (_selected)
                          ? Padding(
                              padding: const EdgeInsets.only(right: 2.0),
                              child: AutoSizeText(
                                widget.info.label,
                                style: TextStyle(
                                  color: themeColor.homeTabSelectedTextColor,
                                ),
                                maxLines: 1,
                                minFontSize: FontSize.MESSAGE.value,
                                maxFontSize: FontSize.LARGE.value,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: AutoSizeText(
                                widget.info.label,
                                style: TextStyle(
                                  color: themeColor.homeTabTextColor,
                                ),
                                maxLines: 1,
                                minFontSize: FontSize.NORMAL.value,
                                maxFontSize: FontSize.HEADER.value,
                              ),
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
