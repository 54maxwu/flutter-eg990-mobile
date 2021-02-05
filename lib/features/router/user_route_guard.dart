import 'package:auto_route/auto_route.dart';

import 'app_global_streams.dart' show getAppGlobalStreams;
import 'auto_router.gr.dart' show FeatureScreenRoutes;

class UserRouteGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    if (getAppGlobalStreams.hasUser) {
      return navigator.push(routeName, arguments: arguments);
    } else {
      return navigator.push(FeatureScreenRoutes.loginRoute);
    }
  }
}
