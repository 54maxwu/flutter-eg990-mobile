import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/screen/screen_drawer_item.dart';
import 'package:flutter_ty_mobile/features/subfeatures/more/more_dialog.dart';
import 'package:flutter_ty_mobile/res.dart';

import '../general_route_widget_export.dart';
import '../router/router.gr.dart';
import 'feature_screen_inherited_widget.dart';
import 'screen_navigation_bar_item.dart';

part 'screen_drawer.dart';
part 'screen_menu_bar.dart';
part 'screen_navigation_bar.dart';

///
/// Main Screen View
///
/// Creates the app scaffold with:
/// top navigation bar [ScreenMenuBar]
/// top navigation bar drawer [ScreenDrawer]
/// bottom navigation bar [ScreenNavigationBar]
/// body [Navigator] to show [Router] page
///
///@author H.C.CHIANG
///@version 2020/2/26
///
class FeatureScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    return SafeArea(
      child: Scaffold(
        key: viewState.scaffoldKey,
        appBar: ScreenMenuBar(),
        drawer: new ScreenDrawer(),
        bottomNavigationBar: ScreenNavigationBar(),
        /* Main Content (switch placeholder with Router) */
        body: ExtendedNavigator<Router>(
          initialRoute: Routes.homeRoute,
          router: Router(),
        ),
//      body: Navigator(
//        key: Router.navigator.key,
//        onGenerateRoute: Router.onGenerateRoute,
//        initialRoute: Router.homeRoute,
//      ),
// /* Route Test */
//      body: Center(
//        child: Observer(builder: (_) {
//          final route = viewState.store.pageInfo.toString() ?? '?';
//          return Text(route);
//        }),
//      ),
      ),
    );
  }
}
