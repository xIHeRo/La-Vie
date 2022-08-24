import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:la_vie/app/app_prefrences.dart';
import 'package:la_vie/data/network/network_info.dart';
import 'package:la_vie/data/repository/repository_impl.dart';
import 'package:la_vie/domain/usecase.dart/login_usecase.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../domain/repository/repository.dart';
import '../presentation/login/view_model.dart/login_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module , it is a module where we put all generic dependecies
  //---------------------Shared Pref-----------------------------------
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));
//---------------------Network Info-----------------------------------
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));
  //---------------------Dio------------------------------------------
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
//---------------------App Service client ----------------------------
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
//---------------------Remote Data Source-----------------------------
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));
  //---------------------Repositiory-----------------------------
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  // to Check if not registered -->generate new instance
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
