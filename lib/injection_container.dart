import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_eg990_mobile/mylogger.dart';
import 'package:get_it/get_it.dart';

import 'application/themes/theme_settings.dart';
import 'domain/auth/jwt_interface.dart';
import 'domain/user/user_info_repository.dart';
import 'infrastructure/core/dio_api_service.dart';
import 'infrastructure/core/network_info.dart';
import 'presentation/features/event/event_inject.dart';
import 'presentation/features/home/home_inject.dart';
import 'presentation/features/login/login_inject.dart';
import 'presentation/features/service/service_inject.dart';
import 'presentation/features/update/update_inject.dart';
import 'presentation/screens/main_screen_store.dart';
import 'presentation/screens/user/user_info_store.dart';
import 'presentation/streams/app_preference_streams.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///
  /// App
  ///
  sl.registerSingleton(() => MyLogger());
  sl.registerLazySingleton<AppPreferenceStreams>(() => AppPreferenceStreams());
  sl.registerLazySingleton<ThemeSettings>(() => ThemeSettings());

  ///
  /// Core
  ///
  sl.registerLazySingleton(() => DioApiService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());

  ///
  /// Lazy Singletons
  ///
  sl.registerLazySingleton(() => MainScreenStore());

  sl.registerLazySingleton<UpdateRepository>(() => UpdateRepositoryImpl(sl()));
  sl.registerLazySingleton(() => UpdateStore(sl<UpdateRepository>()));

  sl.registerLazySingleton<JwtInterface>(
      () => JwtInterfaceImpl(dioApiService: sl()));
  sl.registerLazySingleton<UserInfoRepository>(
      () => UserInfoRepositoryImpl(dioApiService: sl(), jwtInterface: sl()));
  sl.registerLazySingleton(() => UserInfoStore(sl<UserInfoRepository>()));

  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton(() => EventStore(sl<EventRepository>()));

  sl.registerLazySingleton<HomeLocalStorage>(() => HomeLocalStorageImpl());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
      dioApiService: sl(),
      jwtInterface: sl(),
      networkInfo: sl(),
      localStorage: sl()));
  sl.registerLazySingleton(() => HomeStore(sl<HomeRepository>()));

  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerLazySingleton(() => ServiceStore(sl<ServiceRepository>()));

  /// Factory
  sl.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(dioApiService: sl(), jwtInterface: sl()),
  );
  sl.registerFactory<LoginStore>(() => LoginStore(sl(), sl()));
}
