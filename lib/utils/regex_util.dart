import 'package:flutter_ty_mobile/core/internal/global.dart';

final _service = Global.TEST_BASE_URL;
final _loginAPI = 'api/login';
final _gameAPI = 'api/openUrl';

final _routeRegex = RegExp("^(?:$_service/?)");
final _loginRegex = RegExp("^(?:$_service/$_loginAPI)");
final _gameRegex = RegExp("^(?:$_service/$_gameAPI/.*\$)");
final _imageRegex = RegExp("^(?:$_service/images/.*\$)");

final _ptLoginRegex = RegExp("^(?:https://login.greenjade88.com/.*\$)");
final _webResRegex = RegExp("^(?=.*(js|lib|gif|png|html)).*\$");

extension RegexExtension on String {
  bool get isRouteUrl => _routeRegex.hasMatch(this);
  bool get isLoginUrl => _loginRegex.hasMatch(this);
  bool get isGameUrl => _gameRegex.hasMatch(this);
  bool get isImageUrl => _imageRegex.hasMatch(this);
  bool get isPtLoginUrl => _ptLoginRegex.hasMatch(this);
  bool get isWebResource => _webResRegex.hasMatch(this);
}
