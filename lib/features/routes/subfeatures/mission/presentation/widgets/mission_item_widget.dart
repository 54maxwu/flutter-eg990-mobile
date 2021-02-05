import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/export_internal_file.dart';
import 'package:flutter_eg990_mobile/features/router/app_global_streams.dart';
import 'package:flutter_eg990_mobile/features/router/app_navigator_export.dart';
import 'package:flutter_eg990_mobile/res.dart';
import 'package:flutter_eg990_mobile/utils/value_util.dart';

import '../../data/models/mission_model.dart';
import 'mission_detail_dialog.dart';

typedef OnMissionPrizeTap = void Function(MissionModel);

class MissionItemWidget extends StatefulWidget {
  final MissionModel mission;
  final OnMissionPrizeTap onPrizeTap;

  MissionItemWidget({Key key, @required this.mission, this.onPrizeTap})
      : super(key: key);

  @override
  MissionItemWidgetState createState() => MissionItemWidgetState();
}

class MissionItemWidgetState extends State<MissionItemWidget> {
  MissionStatus _status;
  Widget _trailing;

  set updateStatus(MissionStatus status) => setState(() {
        if (mounted) {
          _status = status;
          _createTrailingWidget();
        }
      });

  @override
  void initState() {
    _status = widget.mission.getStatus;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('mission tile: $mission');
    if (_trailing == null) {
      _createTrailingWidget();
    }
    return Container(
      width: Global.device.width - 32,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListTile(
        onTap: () {
          debugPrint('mission:${widget.mission} status: $_status');
        },
        tileColor: Colors.black26,
        title: Text(
          widget.mission.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: FontSize.SMALLER.value,
            fontWeight: FontWeight.bold,
            color: themeColor.missionItemTitleTextColor,
          ),
        ),
        subtitle: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: themeColor.missionItemSubtitleTextColor,
                    fontSize: FontSize.SMALL.value,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.only(right: 4),
                        child: Icon(
                          Icons.info,
                          size: FontSize.SUBTITLE.value,
                          color: themeColor.missionItemSubtitleTextColor,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: localeStr.missionTextDetail,
                      style: TextStyle(color: themeColor.missionTextColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) => new MissionDetailDialog(
                                detail: widget.mission.info,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: themeColor.missionItemSubtitleTextColor,
                  fontSize: FontSize.SMALL.value,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Container(
                      height: FontSize.TITLE.value,
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 2),
                      child: Image.asset(Res.mission_awards_gift_bonus),
                    ),
                  ),
                  TextSpan(
                    text: ' x ${widget.mission.prizeAmount} ',
                    style: TextStyle(
                      color: themeColor.missionItemSubtitleTextColor,
                      fontSize: FontSize.NORMAL.value,
                    ),
                  ),
                  TextSpan(text: localeStr.missionPrizeMoney),
                ],
              ),
            ),
          ],
        ),
        leading: Container(
          child: Image.asset(Res.mission_awards_money),
        ),
        trailing: (_status == MissionStatus.LOADING)
            ? Container(
                width: 72,
                alignment: Alignment.center,
                child: SizedBox.fromSize(
                  size: const Size(16, 16),
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72,
                    height: Global.device.comfortButtonHeight,
                    alignment: Alignment.center,
                    child: _trailing,
                  ),
                  if (widget.mission.required != 0 && _status.index < 1)
                    Text(
                        '${widget.mission.member} / ${widget.mission.required}'),
                ],
              ),
      ),
    );
  }

  void _createTrailingWidget() {
    switch (_status) {
      case MissionStatus.LOADING:
        break;
      case MissionStatus.INCOMPLETE:
        _trailing = Stack(
          children: [
            Center(child: Image.asset(Res.mission_button_hover)),
            Center(
                child: Text(
              localeStr.btnGo,
              style: TextStyle(color: themeColor.missionTextColor),
            )),
          ],
        );
        break;
      case MissionStatus.PENDING:
        _trailing = GestureDetector(
          onTap: () => _missionUrlCheck(widget.mission.url),
          child: Stack(
            children: [
              Center(child: Image.asset(Res.mission_button_hover)),
              Center(
                  child: Text(
                localeStr.missionTextPending,
                style: TextStyle(color: themeColor.missionTextColor),
              )),
            ],
          ),
        );
        break;

      /// Mission Complete & can claim prize
      case MissionStatus.COMPLETE:
        if (!widget.mission.isAuto) {
          _trailing = GestureDetector(
            onTap: () {
              if (widget.onPrizeTap != null) {
                widget.onPrizeTap(widget.mission);
              }
            },
            child: Stack(
              children: [
                Center(child: Image.asset(Res.mission_button)),
                Center(
                    child: Text(
                  localeStr.missionBtnClaim,
                  style: TextStyle(color: themeColor.missionTextColor),
                )),
              ],
            ),
          );
        } else {
          /// auto claim prize
          _trailing = Stack(
            children: [
              Center(child: Image.asset(Res.mission_button_hover)),
              Center(
                  child: Text(
                localeStr.missionTextAutoClaim,
                style: TextStyle(color: themeColor.missionTextColor),
              )),
            ],
          );
        }
        break;

      /// Mission Complete & prize claimed
      case MissionStatus.RECEIVED:
        _trailing = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.check_circle,
                color: themeColor.missionTextHighlightColor,
                size: FontSize.NORMAL.value,
              ),
            ),
            Text(
              localeStr.missionTextClaimed,
              style: TextStyle(color: themeColor.missionTextHighlightColor),
            ),
          ],
        );
        break;
    }
  }

  void _missionUrlCheck(String url) {
    debugPrint('mission widget url check: $url');
    String fixUrl;
    if (url.contains(Global.DOMAIN_NAME)) {
      fixUrl = url.substring(
          url.indexOf(Global.DOMAIN_NAME) + Global.DOMAIN_NAME.length);
    } else if (!url.startsWith('/')) {
      fixUrl = '/$url';
    } else {
      fixUrl = url;
    }
    _missionNavigate(
      url.contains('/api/open/'),
      fixUrl.replaceAll('/api/open/', ''),
    );
  }

  void _missionNavigate(bool openGame, String url) {
    debugPrint('home widget url: $url, isGame: $openGame');
    if (openGame || url.startsWith('/gamelist/')) {
      callToast(localeStr.urlActionNotSupported);
      MyLogger.debug(msg: 'Found unsupported Game URL: $url');

      /// Jump to promo page with promo id if provided
    } else if (url.startsWith('/promo/')) {
      int itemId = url.substring(url.lastIndexOf('/') + 1, url.length).strToInt;
      debugPrint('url promo id: $itemId');
      AppNavigator.navigateTo(
        RoutePage.promo,
        arg: (itemId > 0) ? PromoRouteArguments(openPromoId: itemId) : null,
      );

      /// Jump to store page with product id if provided
    } else if (url.startsWith('/mall/')) {
      int itemId = url.substring(url.lastIndexOf('/') + 1, url.length).strToInt;

      if (!getAppGlobalStreams.hasUser) {
        callToastInfo(localeStr.messageErrorNotLogin);
        return;
      }
      debugPrint('url mall id: $itemId');
      AppNavigator.navigateTo(
        RoutePage.sideStore,
        arg: (itemId > 0) ? StoreRouteArguments(showProductId: itemId) : null,
      );

      /// Jump to route page if path name exist
    } else {
      RoutePage newRoute = url.urlToRoutePage;
      debugPrint('checking url to app route: $newRoute');
      if (newRoute != null) {
        AppNavigator.navigateTo(newRoute);
      } else {
        callToast(localeStr.urlActionNotSupported);
        MyLogger.debug(msg: 'Found unsupported Route URL: $url');
      }
    }
  }
}
