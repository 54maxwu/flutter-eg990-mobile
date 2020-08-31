import 'package:flutter/material.dart';
import 'package:flutter_eg990_mobile/features/exports_for_route_widget.dart';

import 'data/movie_route_form.dart';
import 'state/movie_store.dart';
import 'widgets/movie_display.dart';
import 'widgets/movie_store_inherit_widget.dart';

class MovieRoute extends StatefulWidget {
  final MovieRouteForm form;

  MovieRoute(this.form);

  @override
  _MovieRouteState createState() => _MovieRouteState();
}

class _MovieRouteState extends State<MovieRoute> {
  MovieStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<MovieStore>();
    super.initState();
    _store.getRouteInitializeData(widget.form);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            callToastError(message, delayedMilli: 200);
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Observer(
          // Observe using specific widget
          builder: (_) {
            switch (_store.egRouteState) {
              case MovieStoreState.loading:
                return LoadingWidget();
              case MovieStoreState.loaded:
                return MovieStoreInheritedWidget(
                  store: _store,
                  size: null,
                  child: MovieDisplay(),
                );
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
