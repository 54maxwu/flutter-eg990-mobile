import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:get_it/get_it.dart';

import 'application/themes/theme_settings.dart';
import 'domain/auth/jwt_interface.dart';
import 'domain/sector/ads/ads_repository.dart';
import 'domain/sector/balance/balance_repository.dart';
import 'domain/sector/bet_record/bet_record_repository.dart';
import 'domain/sector/deposit/deposit_repository.dart';
import 'domain/sector/home/home_local_storage.dart';
import 'domain/sector/home/home_repository.dart';
import 'domain/sector/promo/promo_local_storage.dart';
import 'domain/sector/promo/promo_repository.dart';
import 'domain/sector/service/service_repository.dart';
import 'domain/sector/transfer/transfer_repository.dart';
import 'domain/sector/update_repository.dart';
import 'domain/sector/withdraw/withdraw_repository.dart';
import 'domain/user/login/login_repository.dart';
import 'domain/user/user_info_repository.dart';
import 'infrastructure/core/dio_api_service.dart';
import 'infrastructure/core/network_info.dart';
import 'presentation/features/home/state/home_store.dart';
import 'presentation/features/login/state/login_store.dart';
import 'presentation/features/member_features/balance/state/balance_store.dart';
import 'presentation/features/member_features/bet_record/state/bet_record_store.dart';
import 'presentation/features/member_features/deposit/state/deposit_store.dart';
import 'presentation/features/member_features/transfer/state/transfer_store.dart';
import 'presentation/features/member_features/withdraw/state/withdraw_store.dart';
import 'presentation/features/promo/state/promo_store.dart';
import 'presentation/features/service/state/service_store.dart';
import 'presentation/screens/event/ads/state/ads_store.dart';
import 'presentation/screens/event/update/state/update_store.dart';
import 'presentation/screens/main_screen_store.dart';
import 'presentation/screens/streams/app_preference_streams.dart';
import 'presentation/screens/user/user_info_store.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///
  /// App
  ///
  sl.registerSingleton(() => MyLogger());
  sl.registerLazySingleton<AppPreferenceStreams>(() => AppPreferenceStreams());
  sl.registerLazySingleton<ThemeSettings>(() => ThemeSettings());
  sl.registerLazySingleton(() => MainScreenStore());

  ///
  /// Core
  ///
  sl.registerLazySingleton(() => DioApiService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());

  ///
  /// AUTH
  ///
  sl.registerLazySingleton<JwtInterface>(
      () => JwtInterfaceImpl(dioApiService: sl()));
  sl.registerLazySingleton<UserInfoRepository>(
      () => UserInfoRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerLazySingleton(() => UserInfoStore(sl<UserInfoRepository>()));

  ///
  /// EVENT
  ///
  sl.registerLazySingleton<UpdateRepository>(() => UpdateRepositoryImpl(sl()));
  sl.registerLazySingleton(() => UpdateStore(sl<UpdateRepository>()));

  sl.registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImpl(dioApiService: sl()));
  sl.registerLazySingleton(() => AdStore(sl<AdsRepository>()));

  ///
  /// HOME
  ///
  sl.registerLazySingleton<HomeLocalStorage>(() => HomeLocalStorageImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      dioApiService: sl(),
      jwtInterface: sl(),
      networkInfo: sl(),
      localStorage: sl()));
  sl.registerLazySingleton(() => HomeStore(sl<HomeRepository>()));

  ///
  /// LOGIN
  ///
  sl.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerFactory<LoginStore>(() => LoginStore(sl(), sl()));

  ///
  /// PROMO
  ///
  sl.registerFactory<PromoLocalStorage>(() => PromoLocalStorageImpl());
  sl.registerFactory<PromoRepository>(() => PromoRepositoryImpl(
      dioApiService: sl(), networkInfo: sl(), localStorage: sl()));
  sl.registerFactory(() => PromoStore(sl<PromoRepository>()));

  ///
  /// SERVICE
  ///
  sl.registerLazySingleton<ServiceRepository>(
      () => ServiceRepositoryImpl(dioApiService: sl()));
  sl.registerLazySingleton(() => ServiceStore(sl<ServiceRepository>()));

  ///
  /// DEPOSIT
  ///
  sl.registerFactory<DepositRepository>(
      () => DepositRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerFactory(() => DepositStore(sl<DepositRepository>()));

  ///
  /// TRANSFER
  ///
  sl.registerFactory<TransferRepository>(
      () => TransferRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerFactory(() => TransferStore(sl<TransferRepository>()));

  ///
  /// WITHDRAW
  ///
  sl.registerFactory<WithdrawRepository>(
      () => WithdrawRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerFactory(() => WithdrawStore(sl<WithdrawRepository>()));

  ///
  /// BALANCE
  ///
  sl.registerFactory<BalanceRepository>(
      () => BalanceRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerFactory(() => BalanceStore(sl<BalanceRepository>()));

  ///
  /// BET RECORD
  ///
  sl.registerFactory<BetRecordRepository>(
      () => BetRecordRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerFactory(() => BetRecordStore(sl<BetRecordRepository>()));
}
