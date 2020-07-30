import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/home_display_size_calc.dart';

import '../state/movie_store.dart';
import '../widgets/movie_store_inherit_widget.dart';
import 'movie_tab_page_eg.dart';

class MovieTabEgRoute extends StatefulWidget {
  final HomeDisplaySizeCalc displaySize;

  MovieTabEgRoute({this.displaySize});

  @override
  _MovieTabEgRouteState createState() => _MovieTabEgRouteState();
}

class _MovieTabEgRouteState extends State<MovieTabEgRoute> {
  MovieStore _store;
  List<ReactionDisposer> _disposers;
  Size size;

  @override
  void initState() {
    _store ??= sl.get<MovieStore>();
    size = Size(
      widget.displaySize?.pageMaxWidth ?? Global.device.width - 16.0,
      widget.displaySize?.pageMaxHeight ?? Global.device.featureContentHeight,
    );
    super.initState();
    // execute action on init
    _store.getTabInitializeData();
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
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    _store.resetVariable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      constraints: BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.tabState) {
            case MovieStoreState.loading:
              return LoadingWidget();
            case MovieStoreState.loaded:
              return MovieStoreInheritedWidget(
                store: _store,
                size: size,
                child: MovieTabPageEg(),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
