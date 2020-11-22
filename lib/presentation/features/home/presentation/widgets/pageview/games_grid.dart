import 'package:flutter/widgets.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/data/entity/game_entity.dart';
import 'package:flutter_eg990_mobile/res.dart';

import 'game_grid_item.dart';

typedef OnGameGridTap = void Function(String);

class GamesGrid extends StatefulWidget {
  final List<GameEntity> games;
  final OnGameGridTap onTap;

  GamesGrid({
    Key key,
    @required this.games,
    @required this.onTap,
  }) : super(key: key);

  @override
  _GamesGridState createState() => _GamesGridState();
}

class _GamesGridState extends State<GamesGrid> {
  Widget _sliver;

  @override
  void didUpdateWidget(covariant GamesGrid oldWidget) {
    if (oldWidget.games != widget.games) _sliver = null;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.games.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Image.asset(Res.img_no_data),
      );
    }
    _sliver ??= SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 265.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 1.25,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, index) => GestureDetector(
            onTap: () => widget.onTap(widget.games[index].gameUrl),
            child: GameGridItem(game: widget.games[index])),
        childCount: widget.games.length,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: CustomScrollView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        slivers: [_sliver],
      ),
    );
  }
}
