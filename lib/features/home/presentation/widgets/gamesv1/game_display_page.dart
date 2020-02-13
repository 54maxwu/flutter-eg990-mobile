import 'dart:io' show File;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/core/data/cached_image_file.dart';
import 'package:flutter_ty_mobile/features/home/data/form/platform_game_form.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_entity.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_platform_entity.dart';
import 'package:flutter_ty_mobile/features/home/presentation/bloc/bloc_game.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/widgets.dart';
import 'package:flutter_ty_mobile/mylogger.dart';

import '../../../../widget_res_export.dart' show FontSize, Global, sl;
import 'game_control_grid.dart';

///
///@author H.C.CHIANG
///@version 2020/1/15
class GameDisplayPage extends StatefulWidget {
  final List<GamePlatformEntity> platforms;

  GameDisplayPage({
    Key key,
    @required this.platforms,
  }) : super(key: key);

  @override
  _GameDisplayPageState createState() => _GameDisplayPageState();
}

class _GameDisplayPageState extends State<GameDisplayPage>
    with AutomaticKeepAliveClientMixin {
  final String tag = 'GameDisplayPage';
  Widget _content;
  Widget _gamesWidget;
  bool _isGameGrid = false;

  GamePlatformEntity _currentPlatform;
  List<GameEntity> games;

  void _setContent(Widget widget) {
    setState(() {
      _content = widget;
    });
  }

  void _onItemTap(dynamic itemData) {
    if (itemData is GamePlatformEntity) {
      if (_isGameGrid) {
        print('clicked back');
        _setContent(_createPlatformGrid());
      } else if (itemData.hasGames) {
        print('clicked platform: ${itemData.className}, data: $itemData');
        _setContent(_createGamesView(itemData));
      } else
        print('clicked game: ${itemData.gameUrl}');
    } else if (itemData is GameEntity) {
      print('clicked game: ${itemData.gameUrl}');
    } else {
      MyLogger.warn(msg: 'tapped item unknown, data: $itemData', tag: tag);
    }
  }

  PlatformGameForm _createForm(GamePlatformEntity platform) {
    _currentPlatform = platform;
    return PlatformGameForm(
      category: platform.category,
      platform: platform.site,
    );
  }

  @override
  void didUpdateWidget(GameDisplayPage oldWidget) {
    print("update game-page=${widget.platforms.first.category}");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_content == null) _content = _createPlatformGrid();
    return _content;
  }

  @override
  bool get wantKeepAlive => true;

  Widget _createPlatformGrid() {
    _isGameGrid = false;
    return GridView.count(
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 4.0,
      childAspectRatio: 0.85,
      shrinkWrap: true,
      children:
          widget.platforms.map((entity) => _createGridItem(entity)).toList(),
    );
  }

  Widget _createGamesView(GamePlatformEntity platform) {
    _isGameGrid = true;
    if (platform != _currentPlatform)
      _gamesWidget = _createGamesGridBloc(platform);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => _onItemTap(platform),
              ),
              FutureBuilder(
                  future: _imageWidget(platform.iconUrl, isIconSize: true),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        !snapshot.hasError) {
                      return snapshot.data;
                    } else {
                      if (snapshot.hasError)
                        MyLogger.warn(
                            msg: 'snapshot error: ${snapshot.error}', tag: tag);
                      return Icon(Icons.broken_image);
                    }
                  }),
              SizedBox(width: 12.0),
              Text(
                platform.getLabel(),
                style: TextStyle(fontSize: FontSize.TITLE.value),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          _gamesWidget,
        ],
      ),
    );
  }

  Widget _createGamesGridBloc(GamePlatformEntity platform) {
    return BlocProvider(
      create: (_) => sl<HomeGameBloc>(),
      child: BlocBuilder<HomeGameBloc, HomeGameState>(
        builder: (context, state) {
          return state.when(
            gInitial: (_) => GameControlGrid(form: _createForm(platform)),
            gLoading: (_) => LoadingWidget(heightFactor: 3),
            gLoaded: (_) => _createGamesGrid(state.props.first),
            gError: (_) => MessageDisplay(
              message: state.props.first,
            ),
          );
        },
      ),
    );
  }

  Widget _createGamesGrid(List<GameEntity> list) {
    games = List.from(list);
    return new GridView.count(
      physics: ClampingScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 0.63,
      shrinkWrap: true,
      children: games.map((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    var label = (entity is GameEntity) ? entity.cname : entity.getLabel();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: GestureDetector(
        onTap: () => _onItemTap(entity),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            FutureBuilder(
                future: _imageWidget(entity.imageUrl,
                    isGame: (entity is GameEntity)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      !snapshot.hasError) {
                    return snapshot.data;
                  } else if (snapshot.hasError) {
                    MyLogger.warn(
                        msg: 'snapshot error: ${snapshot.error}', tag: tag);
                    return Icon(Icons.broken_image);
                  } else {
                    return Container();
                  }
                }),
            Positioned(
              // stack align at bottom
              bottom: (label.length > 4 || !_isGameGrid) ? 0 : 8,
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 80,
                  height:
                      FontSize.NORMAL.value * 3, // preserved height for text
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Provide image's [url] to create network image
  /// set [isIconSize] to true to return preferred size image
  /// set [isGame] to true to scale down the image to 0.9
  Future<Widget> _imageWidget(String url,
      {bool isIconSize = false, bool isGame = false}) async {
    String imageUrl = '${Global.TEST_BASE_URL}$url';
    final image = await Future.value(checkCachedImage(imageUrl)).then((item) {
      if (item is File) {
        return Image.file(
          item,
          fit: isIconSize ? BoxFit.contain : BoxFit.fill,
        );
      } else {
        return ExtendedImage.network(
          imageUrl,
          fit: isIconSize ? BoxFit.contain : BoxFit.fill,
          loadStateChanged: (ExtendedImageState state) {
            switch (state.extendedImageLoadState) {
              case LoadState.completed:
                return state.completedWidget;
              case LoadState.failed:
                return Icon(Icons.broken_image, color: Colors.grey[400]);
              default:
                return null;
            }
          },
        );
      }
    });

    if (!isIconSize) {
      if (!isGame) {
        // platform image
        return AspectRatio(
          aspectRatio: 16 / 15,
          child: image,
        );
      } else {
        // game image (scale value needs to consider grid's childAspectRatio)
        return Transform.scale(scale: 0.9, child: image);
      }
    } else {
      // game platform icon
      return ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: 32),
        child: image,
      );
    }
  }
}
