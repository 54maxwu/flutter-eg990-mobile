import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_eg990_mobile/features/main_startup.dart';

import '../routes/home/presentation/home_route.dart';
import '../routes/member/presentation/member_route.dart';
import '../routes/subfeatures/accountcenter/presentation/center_route.dart';
import '../routes/subfeatures/accountcenter/presentation/widgets/center_display_account_pwd.dart';
import '../routes/subfeatures/balance/presentation/balance_route.dart';
import '../routes/subfeatures/bankcard/presentation/bankcard_route.dart';
import '../routes/subfeatures/betrecord/presentation/bet_record_route.dart';
import '../routes/subfeatures/deals/presentation/deals_route.dart';
import '../routes/subfeatures/deposit/presentation/deposit_route.dart';
import '../routes/subfeatures/downloadarea/download_area_route.dart';
import '../routes/subfeatures/message/presentation/message_route.dart';
import '../routes/subfeatures/notice/presentation/notice_route.dart';
import '../routes/subfeatures/promo/presentation/promo_route.dart';
import '../routes/subfeatures/rollback/presentation/rollback_route.dart';
import '../routes/subfeatures/service/presentation/service_route.dart';
import '../routes/subfeatures/store/presentation/store_route.dart';
import '../routes/subfeatures/transactions/presentation/transaction_route.dart';
import '../routes/subfeatures/transfer/presentation/transfer_route.dart';
import '../routes/subfeatures/viplevel/presentation/vip_level_route.dart';
import '../routes/subfeatures/wallet/presentation/wallet_route.dart';
import '../routes/web/web_route.dart';
import '../screen/feature_screen.dart';
import '../screen/web_game_screen.dart';
import '../user/login/presentation/login_route.dart';
import '../user/register/presentation/register_route.dart';

@AdaptiveAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    AdaptiveRoute(
        page: MainStartup,
        initial: true,
        maintainState: true,
        children: <AutoRoute>[
          MaterialRoute(
            page: FeatureScreen,
            initial: true,
            maintainState: true,
            children: <AutoRoute>[
              MaterialRoute(
                  page: HomeRoute, initial: true, maintainState: true),
              MaterialRoute(page: LoginRoute, path: '/login'),
              MaterialRoute(page: RegisterRoute, path: '/register'),
              MaterialRoute(page: ServiceRoute, path: '/service'),
              MaterialRoute(page: WebRoute, path: '/web'),
              MaterialRoute(
                  page: WebRoute,
                  name: 'serviceWebRoute',
                  path: '/service-web'),
              MaterialRoute(
                  page: MemberRoute, path: '/member', maintainState: true),
              MaterialRoute(page: DepositRoute, path: '/deposit'),
              MaterialRoute(
                  page: DepositRoute,
                  name: 'depositFeatureRoute',
                  path: '/deposit-nav'),
              MaterialRoute(
                  page: WebRoute,
                  name: 'depositWebRoute',
                  path: '/deposit-web'),
              MaterialRoute(page: TransferRoute, path: '/transfer'),
              MaterialRoute(page: BankcardRoute, path: '/bankcard'),
              MaterialRoute(
                  page: BankcardRoute,
                  name: 'withdrawRoute',
                  path: '/withdraw'),
              MaterialRoute(page: BalanceRoute, path: '/balance'),
              MaterialRoute(page: WalletRoute, path: '/wallet'),
              MaterialRoute(page: MessageRoute, path: '/message'),
              MaterialRoute(page: CenterRoute, path: '/center'),
              MaterialRoute(
                  page: CenterDisplayAccountPassword,
                  name: 'centerPasswordRoute',
                  path: '/center-pwd'),
              MaterialRoute(
                  page: WebRoute, name: 'centerWebRoute', path: '/center-web'),
              MaterialRoute(page: TransactionRoute, path: '/transaction'),
              MaterialRoute(page: BetRecordRoute, path: '/bets'),
              MaterialRoute(page: DealsRoute, path: '/deals'),
              MaterialRoute(page: RollbackRoute, path: '/rollback'),
              MaterialRoute(page: PromoRoute, path: '/promo'),
              // CustomRoute(
              //     page: AgentRoute, name: 'agentNewRoute', path: '/agent'),
              // CustomRoute(page: AgentLoginRoute),
              // CustomRoute(page: AgentRegisterRoute),
              MaterialRoute(page: DownloadAreaRoute, path: '/download'),
              MaterialRoute(
                  page: WebRoute,
                  name: 'tutorialWebRoute',
                  path: '/tutorial-web'),
              MaterialRoute(page: NoticeRoute, path: '/notice'),
              MaterialRoute(page: StoreRoute, path: '/store'),
              MaterialRoute(page: VipLevelRoute, path: '/level'),
            ],
          ),
          AdaptiveRoute(page: WebGameScreen, path: '/game-web'),
        ]),
  ],
)
class $AutoRouter {}

enum Screens { Feature, Game, Test, TestNav }

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
