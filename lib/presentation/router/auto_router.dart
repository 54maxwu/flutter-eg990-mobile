import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_eg990_mobile/presentation/core/main_startup.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/home_route.dart';
import 'package:flutter_eg990_mobile/presentation/features/home/presentation/widgets/pageview/games_page.dart';
import 'package:flutter_eg990_mobile/presentation/features/member/member_route.dart';
import 'package:flutter_eg990_mobile/presentation/screens/main_screen.dart';

@AdaptiveAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    AdaptiveRoute(
        page: MainStartup,
        initial: true,
        maintainState: true,
        children: <AutoRoute>[
          MaterialRoute(
            page: MainScreen,
            initial: true,
            maintainState: true,
            children: <AutoRoute>[
              MaterialRoute(
                  page: HomeRoute, initial: true, maintainState: true),
              MaterialRoute(page: GamesPage),
              MaterialRoute(page: MemberRoute),
            ],
          ),
          // AdaptiveRoute(page: WebGameScreen, path: '/game-web'),
          // AdaptiveRoute(page: TestScreen, path: '/test'),
          // AdaptiveRoute(page: TestNestedNavScreen, path: '/test-nested'),
        ]),
  ],
)
class $AutoRouter2 {}

enum Screens { Main }

// Widget slideRightTransition(BuildContext context, Animation<double> animation,
//     Animation<double> secondaryAnimation, Widget child) {
//   var curvedAnim = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
//   return new SlideTransition(
//     position: new Tween<Offset>(
//       begin: const Offset(1.0, 0.0),
//       end: Offset.zero,
//     ).animate(curvedAnim),
//     child: child,
//   );
// }
