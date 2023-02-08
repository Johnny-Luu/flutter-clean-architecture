import 'package:flutter_clean_architecture/application/repositories/account_repository.dart';
import 'package:flutter_clean_architecture/application/usecases/account/login_account.dart';
import 'package:flutter_clean_architecture/data/datasources/account/account_remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/core/network_info.dart';
import 'package:flutter_clean_architecture/presentation/features/login/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/datasources/account/account_local_data_source.dart';
import '../infrastructure/repositories/account_repository_impl.dart';

// import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Application - Use cases
  sl.registerLazySingleton(() => LoginAccountUseCase(sl()));

  // Infrastructures - Repositories
  sl.registerLazySingleton<AccountRepository>(() => AccountRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data - Data sources
  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl());

  sl.registerLazySingleton<AccountLocalDataSource>(
      () => AccountLocalDataSourceImpl(sharedPreferences: sl()));

  // Domain - Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // sl.registerLazySingleton(() => http.Client());

  // Presentation
  sl.registerFactory(() => LoginBloc(sl()));
}
