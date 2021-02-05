import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/core/internal/local_strings.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_eg990_mobile/features/themes/theme_interface.dart';

class MissionDetailDialog extends StatelessWidget {
  final String detail;

  MissionDetailDialog({@required this.detail});

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      heightFactor: 0.35,
      minHeight: 180,
      maxHeight: 240,
      customBg: themeColor.missionDialogBackgroundColor,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.double_arrow_sharp,
                    color: themeColor.missionDialogDecorColor,
                    size: FontSize.TITLE.value,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
                    child: Text(
                      localeStr.missionTextDetail,
                      style: TextStyle(
                        fontSize: FontSize.MESSAGE.value,
                        fontWeight: FontWeight.w500,
                        color: themeColor.missionDialogTitleColor,
                      ),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.double_arrow_sharp,
                      color: themeColor.missionDialogDecorColor,
                      size: FontSize.TITLE.value,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.white, thickness: 1, height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        detail,
                        style:
                            TextStyle(color: themeColor.missionDialogTextColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
