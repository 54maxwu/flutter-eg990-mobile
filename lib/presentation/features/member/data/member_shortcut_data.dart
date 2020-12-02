import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/presentation/router/route_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_shortcut_data.freezed.dart';

enum MemberShortcutType { NORMAL, COMPLEX, LIST }

@freezed
abstract class MemberShortcutData with _$MemberShortcutData {
  const factory MemberShortcutData({
    @required RouteEnum id,
    RoutePage route,
    @required String assetPath,
    @required MemberShortcutType sType,
    String hintText,
    int section,
  }) = _MemberShortcutData;
}

extension MemberShortcutDataExtension on MemberShortcutData {
  String get label => id.title;

  bool get isUserOnly => id.isUserOnly;

  String get hint {
    switch (sType) {
      case MemberShortcutType.COMPLEX:
        return hintText;
      case MemberShortcutType.LIST:
        return hintText ?? id.pageHint;
      default:
        return '';
    }
  }
}
