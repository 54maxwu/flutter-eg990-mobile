part of 'router_navigate.dart';

RouteUserStreams get getRouteUserStreams => sl.get<RouteUserStreams>();

class RouteUserStreams {
  final StreamController<UserData> _userControl =
      StreamController<UserData>.broadcast();

  final StreamController<bool> _recheckControl =
      StreamController<bool>.broadcast();

  Stream<UserData> get userStream => _userControl.stream;

  Stream<bool> get recheckUserStream => _recheckControl.stream;

  UserData _user = UserData(isLoggedIn: false);

  UserData get currentUser => _user;

  RouteUserStreams() {
    _userControl.stream.listen((event) {
      print('update stream user: $event');
      _user = event;
    });
  }

  updateUser(UserEntity user) {
    _userControl.sink.add(UserData(
      isLoggedIn: user != null,
      user: user,
    ));
  }

  setCheck(bool recheck) {
    _recheckControl.sink.add(recheck);
  }

  dispose() {
    MyLogger.warn(msg: 'disposing route streams!!', tag: 'RouteUserStreams');
    _userControl.close();
    _recheckControl.close();
  }
}
