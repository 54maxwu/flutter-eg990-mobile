import 'package:after_layout/after_layout.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_platform_entity.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/games/game_display_grid.dart';

import '../../../../widget_res_export.dart' show FontSize, Global, HexColor;

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
    with AutomaticKeepAliveClientMixin, AfterLayoutMixin {
  final double screenWidth = Global.device.width;
  final String tag = 'GameDisplayPage';
  GamePlatformEntity _curPlatform;
  Widget _platformWidget;
  Widget _gameGrid;

  int _selectedIndex = -1;

  @override
  void initState() {
    print(
        "initState game-page=${widget.platforms.first.category} hash=$hashCode");
    _gameGrid = Expanded(
      child: Container(
        color: HexColor.fromHex('#e8e8e8'),
      ),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(GameDisplayPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget game-page = ${_curPlatform.className}');
  }

  _onPlatformTap(int index) {
    print('onItemTap $index');
    if (_selectedIndex == index) return;
    final newGrid = new GameDisplayGrid(platform: widget.platforms[index]);
    setState(() {
      _selectedIndex = index;
      _curPlatform = widget.platforms[index];
      _gameGrid = newGrid;
    });
    print('current platform: ${_curPlatform.className}');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          color: HexColor.fromHex('#e8e8e8'),
        ),
        child: Column(
          children: <Widget>[
            _buildPlatformList(),
            _gameGrid,
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformList() {
    _platformWidget = Container(
      padding: EdgeInsets.only(right: 4.0, bottom: 1.0),
      height: 48,
      color: HexColor.fromHex('#585858'),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.platforms.length,
          itemBuilder: (context, index) {
            /* Platform Button */
            return Container(
              width: screenWidth / 3 - 8,
              child: GestureDetector(
                onTap: () => _onPlatformTap(index),
                child: Card(
                  color: _selectedIndex != null && _selectedIndex == index
                      ? Colors.cyan
                      : Colors.grey[800],
                  child: _createItem(widget.platforms[index]),
                ),
              ),
            );
          }),
    );
    return _platformWidget;
  }

  Widget _createItem(GamePlatformEntity platform) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 4.0, top: 3.0, bottom: 3.0),
          child: _networkImage(platform.iconUrl),
        ),
        Text(
          platform.site.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: FontSize.TITLE.value),
        ),
      ],
    );
  }

  Widget _networkImage(String url) {
    return ExtendedImage.network(
      '${Global.TEST_BASE_URL}$url',
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return null;
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

  @override
  void afterFirstLayout(BuildContext context) {
    print('game-page after first layout');
    if (_curPlatform == null) _curPlatform = widget.platforms[0];
    _onPlatformTap(0);
  }

  @override
  bool get wantKeepAlive => true;
}
