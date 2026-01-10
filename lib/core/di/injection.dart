import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gau_app/core/service/datasource/local/local_service.dart';
import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/network_checker.dart';
import 'package:gau_app/features/common/controller/main_nav_controller.dart';



final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());
  sl.registerLazySingleton<LocalService>(() => LocalService());
  sl.registerLazySingleton<NavController>(() => NavController());
 // sl.registerLazySingleton<HomeController>(() => HomeController());

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      dio: sl<Dio>(),
      networkChecker: sl<NetworkChecker>(),
      localService: sl<LocalService>(),
    ),
  );
}
