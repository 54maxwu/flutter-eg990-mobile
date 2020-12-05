import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/network_image.dart';
import 'package:flutter_eg990_mobile/presentation/exports_for_route_widget.dart';
import 'package:flutter_eg990_mobile/domain/sector/home/platform/game_platform_entity.dart';
import 'package:flutter_eg990_mobile/res.dart';

import '../../state/home_store.dart';
import '../home_display_provider.dart';
import '../home_display_size_calc.dart';

class PlatformsPage extends StatefulWidget {
  final String category;

  PlatformsPage({Key key, @required this.category}) : super(key: key);

  @override
  PlatformsPageState createState() => PlatformsPageState();
}

class PlatformsPageState extends State<PlatformsPage> with AfterLayoutMixin {
  HomeStore _store;
  HomeDisplaySizeCalc _display;
  List<GamePlatformEntity> _platforms;

  Widget _sliver;

  // final ScrollController _scrollController = new ScrollController();
  // double _bottomEdgePosition;
  // bool _atBottomEdge = false;

  @override
  void didUpdateWidget(covariant PlatformsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    _sliver = null;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= Provider.of<HomeDisplayProvider>(context).homeStore;
    _display ??= Provider.of<HomeDisplayProvider>(context).calc;
    if (_platforms == null) return LoadingWidget();
    if (mounted && _platforms.isNotEmpty) {
      // return NotificationListener<ScrollNotification>(
      //   onNotification: (event) {
      //     _bottomEdgePosition ??= _scrollController.position.maxScrollExtent;
      //     if (_atBottomEdge && event is ScrollUpdateNotification) {
      //       debugPrint('drag update: ${event.metrics.pixels}');
      //       if (event.metrics.pixels > _bottomEdgePosition + 60.0) {
      //         debugPrint('triggered next category');
      //       } else if (event.metrics.pixels < _bottomEdgePosition) {
      //         debugPrint('cancel scroll at bottom');
      //         _atBottomEdge = false;
      //       }
      //     }
      //     if (event is ScrollEndNotification &&
      //         _scrollController.position.atEdge) {
      //       if (event.metrics.pixels == _bottomEdgePosition) {
      //         debugPrint('detect stop at scroll bottom');
      //         _atBottomEdge = true;
      //       }
      //     }
      //     return false;
      //   },
      _sliver ??= SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) => ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: () => _onItemTap(_platforms[index]),
            title: Container(
              constraints: BoxConstraints(
                minWidth: _display.pageMinWidth,
                maxWidth: _display.pageMaxWidth,
              ),
              alignment: Alignment.center,
              child: Image.asset(
                _platforms[index].assetUrl,
                errorBuilder: (ctx, exc, _) {
                  // debugPrint(
                  //     'platform image not found: ${_platforms[index].assetUrl}');
                  return NetworkImageBuilder(
                      'images/nav/mob/mob_undefined.png');
                },
              ),
            ),
          ),
          childCount: _platforms.length,
        ),
      );
      return CustomScrollView(
        // controller: _scrollController,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [_sliver],
      );
    }
    return Container(
      alignment: Alignment.center,
      child: Image.asset(Res.img_no_data),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      _platforms ??= _store.homePlatformMap[widget.category] ?? [];
      // debugPrint('${widget.category} page platforms: $_platforms');
    });
  }

  /// Pass in a [itemData] on grid item tap or back button pressed.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else throw [UnknownConditionException].
  void _onItemTap(GamePlatformEntity platform) {
    String openUrl = '';
    if (context.read<MainScreenProvider>().userInfoStore.hasUser) {
      if (platform.isGameHall) {
        debugPrint('clicked game platform: ${platform.gameUrl}');
        if (platform.gameUrl == 'funky/lottery/0') {
          AppNavigator.navigateTo(
            _createRoute(platform.label),
            arg: GamesPageArguments(platform: platform, store: _store),
          );
        } else {
          openUrl = platform.gameUrl;
        }
      } else {
        AppNavigator.navigateTo(
          _createRoute(platform.label),
          arg: GamesPageArguments(platform: platform, store: _store),
        );
      }
    } else {
      callToastInfo(localeStr.messageErrorNotLogin);
    }
    if (openUrl.isNotEmpty) {
      debugPrint('requesting game hall url: $openUrl');
      // final toast = callToastLoading(
      //   message: localeStr.messageWait,
      //   clickClose: false,
      // );
      // Future.microtask(() => _store.getGameUrl(openUrl))
      //     .whenComplete(() => toast());
    }
  }

  RoutePage _createRoute(String title) => RoutePage.define(RouteInfo(
        id: RouteEnum.GAMES,
        route: MainScreenRoutes.gamesPage,
        appBarType: MainScreenAppBarTypes.BACK_AND_TITLE,
        navBarType: MainScreenNavBarTypes.HIDE,
        title: title,
      ));
}
