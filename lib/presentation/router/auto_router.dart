import 'package:auto_route/auto_route_annotations.dart';

import '../core/main_startup.dart';
import '../features/about_us/about_route.dart';
import '../features/home/home_route.dart';
import '../features/home/widgets/pageview/games_page.dart';
import '../features/login/login_route.dart';
import '../features/member/member_route.dart';
import '../features/member_features/bet_record/bet_record_route.dart';
import '../features/member_features/deposit/deposit_route.dart';
import '../features/promo/promo_route.dart';
import '../features/promo/widgets/promo_detail_page.dart';
import '../features/service/service_route.dart';
import '../features/sponsor/sponsor_route.dart';
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
              MaterialRoute(page: PromoDetailPage),
              MaterialRoute(page: ServiceRoute),
              MaterialRoute(page: SponsorRoute),
              MaterialRoute(page: AboutRoute),
              MaterialRoute(page: MemberRoute),
              MaterialRoute(page: DepositRoute),
              MaterialRoute(page: BetRecordRoute),
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
