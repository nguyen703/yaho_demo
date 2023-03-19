import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaho_demo/data/datasources/user/user_local_datasource.dart';
import 'package:yaho_demo/data/datasources/user/user_remote_datasource.dart';
import 'package:yaho_demo/data/repositories/user/user_repository_impl.dart';
import 'package:yaho_demo/presentation/blocs/user/user_bloc.dart';

import 'domain/repositories/user/user_repository.dart';

final di = GetIt.instance;

Future<void> init() async {
  // Blocs
  di.registerLazySingleton<UserBloc>(() => UserBloc(userRepository: di()));

  // Repositories
  di.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDatasource: di(), userLocalDatasource: di()));

  // Datasources
  di.registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(client: di()));
  di.registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImpl(sharedPreferences: di()));

  // External packages
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  di.registerFactory<http.Client>(() => http.Client());
}
