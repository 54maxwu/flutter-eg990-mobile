import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/features/router/route_enum.dart';
import 'package:flutter_eg990_mobile/features/router/route_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_grid_item_data.freezed.dart';

typedef CreateLinearGradient = Gradient Function();

enum MemberGridItemImage { ICON, IMAGE, ASSET }

@freezed
abstract class MemberGridItemData with _$MemberGridItemData {
  const factory MemberGridItemData({
    @required RouteEnum id,
    @required IconData iconData,
    String imageUrl,
    String assetPath,
    CreateLinearGradient createLinearGradient,
    RoutePage route,
  }) = _MemberGridItemData;
}

extension MemberGridItemDataExtension on MemberGridItemData {
  String get title => id.title;

  MemberGridItemImage get imageType {
    if (imageUrl != null) return MemberGridItemImage.IMAGE;
    if (assetPath != null) return MemberGridItemImage.ASSET;
    return MemberGridItemImage.ICON;
  }
}

Gradient getLinearGradient(List<Color> colors, List<double> stops) =>
    LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
      stops: stops,
      tileMode: TileMode.clamp,
    );
