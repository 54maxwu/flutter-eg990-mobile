part of 'router_navigate.dart';

RouterWidgetStreams get getRouterStreams => sl.get<RouterWidgetStreams>();

class RouterWidgetStreams {
  final StreamController<String> _title = StreamController<String>.broadcast();

  final StreamController<bool> _showBackArrow =
      StreamController<bool>.broadcast();

  final StreamController<bool> _hideActions =
      StreamController<bool>.broadcast();

  final StreamController<bool> _recheckUser = StreamController<bool>.broadcast();

  Stream<String> get titleStream {
    if (_title.hasListener == false)
      _title.stream.listen((event) {
        print('changing app title to: $event');
      });
    return _title.stream;
  }

  Stream<bool> get backStream => _showBackArrow.stream;

  Stream<bool> get actionStream => _hideActions.stream;

  Stream<bool> get userStream => _recheckUser.stream;

  updateTitle(String newTitle, {bool hideActions = false}) {
    _title.sink.add(newTitle);
    _hideActions.sink.add(hideActions);
  }

  updateLeading(bool showBack) {
    _showBackArrow.sink.add(showBack);
  }

  updateUser(bool recheck) {
    _recheckUser.sink.add(recheck);
  }

  dispose() {
    _title.close();
    _showBackArrow.close();
    _hideActions.close();
    _recheckUser.close();
  }
}
