import 'package:auto_route/auto_route_annotations.dart';

import 'test_home_size_calc.dart';
import 'test_input_route.dart';
import 'test_nested_nav_screen_view.dart';
import 'test_permission_screen.dart';

@AdaptiveAutoRouter(
  routesClassName: 'TestRouterRoutes',
  routes: <AutoRoute>[
    AdaptiveRoute(page: TestNestedNavScreenView, initial: true),
    AdaptiveRoute(page: TestPermissionScreen),
    AdaptiveRoute(page: TestInputRoute),
    AdaptiveRoute(page: TestHomeSizeCalc),
  ],
)
class $TestRouter {}
