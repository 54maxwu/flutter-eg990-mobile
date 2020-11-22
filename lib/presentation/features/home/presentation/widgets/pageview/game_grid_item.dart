import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_eg990_mobile/presentation/export_internal_file.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_entity.dart';
import 'package:flutter_eg990_mobile/presentation/common/images/cached_network_image.dart';

class GameGridItem extends StatelessWidget {
  final GameEntity game;

  const GameGridItem({Key key, @required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      child: ColoredBox(
        color: themeColor.defaultBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: networkImageBuilder(
                game.imageUrl,
                addPendingIconOnError: true,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: FontSize.SUBTITLE.value * 2.75,
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
              alignment: Alignment.centerLeft,
              child: AutoSizeText.rich(
                TextSpan(text: game.cname.trim()),
                maxLines: 2,
                textAlign: TextAlign.start,
                minFontSize: FontSize.SMALL.value,
                maxFontSize: FontSize.NORMAL.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
