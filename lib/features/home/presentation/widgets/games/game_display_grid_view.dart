import 'dart:io' show File;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/data/cached_image_file.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_entity.dart';
import 'package:flutter_ty_mobile/mylogger.dart';

import '../../../../widget_res_export.dart' show FontSize, Global, HexColor;

///@author H.C.CHIANG
///@version 2020/1/15
class GameDisplayGridView extends StatelessWidget {
  final List<GameEntity> games;
  final Color frameColor = Colors.white;
  final Color textColor = HexColor.fromHex('#888888');
  final Color bgColor = HexColor.fromHex('#e8e8e8');

  GameDisplayGridView({Key key, @required this.games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgColor,
        child: GridView.count(
          crossAxisCount: 3,
          children: _buildGameWidgetList(),
        ),
      ),
    );
  }

  List<Widget> _buildGameWidgetList() {
    return games.map((game) => _createGameWidget(game)).toList();
  }

  Widget _createGameWidget(GameEntity game) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 4.0, color: frameColor),
        borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          /* Game Image */
          FutureBuilder(
              future: _gameImageWidget(game.imageUrl),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return snapshot.data;
                } else {
                  if (snapshot.hasError)
                    MyLogger.warn(
                        msg: 'snapshot error: ${snapshot.error}',
                        tag: 'GameDisplayGridView');
                  return Icon(Icons.broken_image);
                }
              }),
          /* Game Text*/
          Expanded(
            child: Container(
              color: frameColor,
              child: Center(
                child: Text(game.cname,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        color: textColor, fontSize: FontSize.NORMAL.value)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget> _gameImageWidget(String url) async {
    String imageUrl = '${Global.TEST_BASE_URL}$url';
    final image = await Future.value(checkCachedImage(imageUrl)).then((item) {
      if (item is File)
        return Image.file(item, fit: BoxFit.fill);
      else
        return ExtendedImage.network(imageUrl, fit: BoxFit.fill);
    });
    return Container(
      color: frameColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: AspectRatio(aspectRatio: 4 / 3, child: image),
//        child: Align(child: widget, heightFactor: 0.75),
      ),
    );
  }
}
