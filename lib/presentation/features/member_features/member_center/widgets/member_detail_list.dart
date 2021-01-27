import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/domain/core/failure_type.dart';
import 'package:flutter_eg990_mobile/domain/core/failures.dart';
import 'package:flutter_eg990_mobile/presentation/app_theme_export.dart';
import 'package:flutter_eg990_mobile/presentation/common/other/warning_display.dart';
import 'package:flutter_eg990_mobile/presentation/common/toast/toast_text.dart';
import 'package:flutter_eg990_mobile/presentation/router/navigate.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../state/member_center_store.dart';
import 'member_center_inherited_widget.dart';

class MemberDetailList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MemberCenterStore store =
        MemberCenterInheritedWidget.of(context)?.store;
    if (store == null) {
      return WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.INHERIT)).message,
          widthFactor: 1,
          highlight: false);
    }
    final Widget trailWidget = Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Icon(
        Icons.chevron_right,
        color: themeColor.defaultHintColor,
      ),
    );

    final List<Widget> tiles = [
      // Text(store.memberDetail.toString()),
      ListTile(
        tileColor: themeColor.defaultBackgroundColor,
        title: Text(
          localeStr.centerTextHeadPhoto,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          alignment: Alignment.centerLeft,
          child: SizedBox.fromSize(
            size: const Size(64.0, 64.0),
            child: CircleAvatar(
              child: Image.asset(Res.avatar_nologin),
            ),
          ),
        ),
      ),
      ListTile(
        tileColor: themeColor.defaultBackgroundColor,
        visualDensity: VisualDensity.comfortable,
        title: Text(
          localeStr.fieldTitleMemberAccount,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            store.memberDetail.accountCode,
            style: TextStyle(
              fontSize: FontSize.SUBTITLE.value,
              color: themeColor.defaultTextColor,
              height: 2.0,
            ),
          ),
        ),
      ),
      ListTile(
        onTap: () => callToast(localeStr.msgWorkInProgress),
        tileColor: themeColor.defaultBackgroundColor,
        title: Text(
          localeStr.fieldTitleMemberName,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: (store.memberDetail.firstName?.isNotEmpty == true)
              ? Text(
                  store.memberDetail.firstName,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultTextColor,
                    height: 2.0,
                  ),
                )
              : Text(
                  localeStr.centerHintMemberName,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultHintColor,
                    height: 2.0,
                  ),
                ),
        ),
        trailing: trailWidget,
      ),
      ListTile(
        onTap: () => callToast(localeStr.msgWorkInProgress),
        tileColor: themeColor.defaultBackgroundColor,
        title: Text(
          localeStr.fieldTitleBirthday,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: (store.memberDetail.birthDate?.isNotEmpty == true)
              ? Text(
                  store.memberDetail.birthDate,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultTextColor,
                    height: 2.0,
                  ),
                )
              : Text(
                  localeStr.fieldHintBirthday,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultHintColor,
                    height: 2.0,
                  ),
                ),
        ),
        trailing: trailWidget,
      ),
      ListTile(
        onTap: () => callToast(localeStr.msgWorkInProgress),
        tileColor: themeColor.defaultBackgroundColor,
        title: Text(
          localeStr.fieldTitlePhone,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: (store.memberDetail.phone?.isNotEmpty == true)
              ? Text(
                  store.memberDetail.phone,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultTextColor,
                    height: 2.0,
                  ),
                )
              : Text(
                  localeStr.fieldHintPhone,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultHintColor,
                    height: 2.0,
                  ),
                ),
        ),
        trailing: trailWidget,
      ),
      ListTile(
        onTap: () => callToast(localeStr.msgWorkInProgress),
        tileColor: themeColor.defaultBackgroundColor,
        title: Text(
          localeStr.fieldTitleEmail,
          style: TextStyle(
            fontSize: FontSize.SUBTITLE.value,
            color: themeColor.defaultTextColor,
            height: 2.0,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: (store.memberDetail.email?.isNotEmpty == true)
              ? Text(
                  store.memberDetail.email,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultTextColor,
                    height: 2.0,
                  ),
                )
              : Text(
                  localeStr.centerHintEMail,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    color: themeColor.defaultHintColor,
                    height: 2.0,
                  ),
                ),
        ),
        trailing: trailWidget,
      ),
      Container(
        padding: const EdgeInsets.only(top: 24, bottom: 30),
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text:
                  '${localeStr.centerHintPrivacyEdit}${localeStr.pageBtnContactCsPrefix}',
              style: TextStyle(
                fontSize: FontSize.MESSAGE.value,
                color: themeColor.defaultHintColor,
              ),
            ),
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: FlatButton(
                visualDensity: VisualDensity.compact,
                child: Text(
                  localeStr.pageBtnContactCs,
                  style: TextStyle(
                    fontSize: FontSize.MESSAGE.value,
                    color: themeColor.hintHyperLink,
                  ),
                ),
                onPressed: () => AppNavigator.navigateTo(RoutePage.service),
              ),
            ),
          ]),
        ),
      ),
    ];
    return Container(
      // color: themeColor.defaultBackgroundColor,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        itemCount: tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              tiles[index],
              if (index < tiles.length - 1)
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: themeColor.defaultHintSubColor.withOpacity(0.5),
                ),
            ],
          );
        },
      ),
    );
  }
}
