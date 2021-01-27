import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/general/widgets/cached_network_image.dart';

import 'corner_clipper.dart';

const _gameBgColor1 = Color(0xfffeeedf);
const _gameBgColor2 = Color(0xfffffdfa);
const _gameTextColor = Color(0xff202020);

class GridItemGame extends StatelessWidget {
  final String imgUrl;
  final String label;
  final double itemSize;
  final double fontSize;
  final int maxLines;
  final bool isIos;

  GridItemGame({
    @required this.imgUrl,
    @required this.label,
    @required this.itemSize,
    @required this.fontSize,
    @required this.maxLines,
    @required this.isIos,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_gameBgColor1, _gameBgColor2],
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: itemSize),
                child: (imgUrl != null)
                    ? networkImageBuilder(imgUrl, addPendingIconOnError: true)
                    : Center(child: Icon(Icons.broken_image)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: RichText(
                  maxLines: maxLines,
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: label,
                    style: TextStyle(color: _gameTextColor),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: ClipPath(
              clipper: new CornerClipper(),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: itemSize / 4,
                height: 16.0,
                color: cornerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
