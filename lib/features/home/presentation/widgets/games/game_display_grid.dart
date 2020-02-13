import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/core/internal/hex_color.dart';
import 'package:flutter_ty_mobile/features/general/widgets/loading_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/message_display.dart';
import 'package:flutter_ty_mobile/features/home/data/form/platform_game_form.dart';
import 'package:flutter_ty_mobile/features/home/domain/entity/game_platform_entity.dart';
import 'package:flutter_ty_mobile/features/home/presentation/bloc/bloc_game.dart';
import 'package:flutter_ty_mobile/injection_container.dart';

import 'game_control_grid.dart';
import 'game_display_grid_view.dart';

///
/// @author H.C.CHIANG
/// @version 2020/01/15
class GameDisplayGrid extends StatefulWidget {
  final GamePlatformEntity platform;

  GameDisplayGrid({
    Key key,
    @required this.platform,
  }) : super(key: key);

  @override
  _GameDisplayGridState createState() => _GameDisplayGridState();
}

class _GameDisplayGridState extends State<GameDisplayGrid> {
  HomeGameBloc _bloc;

  PlatformGameForm createForm() {
    return PlatformGameForm(
      category: widget.platform.category,
      platform: widget.platform.site,
    );
  }

  @override
  void didUpdateWidget(GameDisplayGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget game-grid');
    _bloc.add(GetGamesEvent(form: createForm()));
  }

  @override
  Widget build(BuildContext context) {
    if (_bloc == null) _bloc = sl<HomeGameBloc>();
    return BlocProvider(
      create: (_) => _bloc,
      child: Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                color: HexColor.fromHex('#e8e8e8'),
                child: BlocBuilder<HomeGameBloc, HomeGameState>(
                  builder: (context, state) {
                    return state.when(
                      gInitial: (_) => GameControlGrid(form: createForm()),
                      gLoading: (_) => LoadingWidget(),
                      gLoaded: (_) =>
                          GameDisplayGridView(games: state.props.first),
                      gError: (_) => MessageDisplay(
                        message: state.props.first,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
