import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show IconData, Color;
import 'package:flutter_eg990_mobile/presentation/router/data/route_enum.dart';
import 'package:flutter_eg990_mobile/presentation/router/route_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shortcut_data.freezed.dart';

@freezed
abstract class ShortcutData with _$ShortcutData {
  const factory ShortcutData({
    @required RouteEnum id,
    IconData iconData,
    String assetPath,
    String imageUrl,
    RoutePage route,
    @Default(true) bool isUserOnly,
  }) = _ShortcutData;
}

extension ShortcutDataExtension on ShortcutData {
  String get label => id.gridTitle ?? id.title;
}
