import 'package:auto_route/auto_route_annotations.dart';

import '../features/home/presentation/home_route.dart';
import '../features/home/presentation/widgets/pageview/games_page.dart';
import '../features/login/presentation/login_route.dart';
import '../features/member/member_route.dart';
import '../features/promo/presentation/promo_route.dart';
import '../features/service/presentation/service_route.dart';
import '../features/sponsor/presentation/sponsor_route.dart';
import '../core/main_startup.dart';
import '../screens/main_screen.dart';

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
              MaterialRoute(page: LoginRoute),
              MaterialRoute(page: PromoRoute),
              MaterialRoute(page: ServiceRoute),
              MaterialRoute(page: SponsorRoute),
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
