import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_eg990_mobile/temp/test_input_route.dart';
import 'package:flutter_eg990_mobile/temp/test_nested_nav_screen_view.dart';
import 'package:flutter_eg990_mobile/temp/test_permission_screen.dart';

@CupertinoAutoRouter(routesClassName: 'TestRoutes')
class $TestRouter {
  TestNestedNavScreenView testScreenInnerView;
  TestPermissionScreen testPermissionScreen;
  TestInputRoute testInputRoute;
}
