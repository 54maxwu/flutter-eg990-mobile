import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_ty_mobile/features/home/presentation/home_route.dart';
import 'package:flutter_ty_mobile/features/users/presentation/login_route.dart';

@autoRouter
class $Router {
  @initial
  HomeRoute homeRoute;
  @MaterialRoute(fullscreenDialog: true)
  LoginRoute loginRoute;
//  @CustomRoute(
//    transitionsBuilder: TransitionsBuilders.zoomIn,
//    durationInMilliseconds: 200,
//  )
}
