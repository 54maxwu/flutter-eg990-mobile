import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/application/global.dart';
import 'package:flutter_eg990_mobile/application/themes/theme_interface.dart';
import 'package:flutter_eg990_mobile/domain/sector/deposit/types/deposit_method.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'deposit_method_control.dart';

class DepositMethodItem extends StatefulWidget {
  final DepositMethod method;

  const DepositMethodItem({@required this.method});

  @override
  _DepositMethodItemState createState() => _DepositMethodItemState();
}

class _DepositMethodItemState extends State<DepositMethodItem> {
  final Size _imageSize = const Size(24.0, 24.0) * Global.device.widthScale;

  bool _selected;
  Widget _image;

  Widget _createImage() {
    if (widget.method is DepositMethodLocal) {
      return Image.asset(Res.deposit_method_bank_card);
    } else if (widget.method is DepositMethodOnline) {
      return Image.asset(Res.deposit_method_online_transfer);
    } else {
      return Image.asset(Res.deposit_method_btcpay);
    }
  }

  @override
  Widget build(BuildContext context) {
    _image ??= _createImage();
    return Selector<DepositMethodControl, DepositMethod>(
      selector: (_, provider) => provider.getSelected,
      builder: (_, currType, __) {
        // debugPrint('tab ${widget.index} receives index change: $index');
        bool isSameType = currType == widget.method;
        if (_selected != isSameType) {
          _selected = isSameType;
        }
        return Container(
          height: 36.0 * Global.device.heightScale,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: (_selected)
                ? Border.all(color: themeColor.defaultAccentColor)
                : Border.all(color: themeColor.defaultBorderColor),
            borderRadius: BorderRadius.circular(8.0),
            image: (widget.method is DepositMethodLocal)
                ? DecorationImage(
                    image: ExactAssetImage(
                      Res.deposit_badge_recommend,
                      scale: 2.0 / Global.device.heightScale,
                    ),
                    alignment: Alignment.topRight,
                  )
                : null,
          ),
          foregroundDecoration: (_selected)
              ? BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                      Res.deposit_icon_selected,
                      scale: 1.75 / Global.device.heightScale,
                    ),
                    alignment: Alignment.bottomRight,
                  ),
                )
              : null,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints.tight(_imageSize),
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: _image,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: AutoSizeText(
                  widget.method.label,
                  style: TextStyle(
                    color: (_selected)
                        ? themeColor.defaultAccentColor
                        : themeColor.defaultTextColor,
                    fontSize: FontSize.MESSAGE.value,
                  ),
                  maxLines: 1,
                  minFontSize: FontSize.SMALLER.value,
                  maxFontSize: FontSize.MESSAGE.value,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
