import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaho_demo/data/datasources/user/user_local_datasource.dart';
import 'package:yaho_demo/data/datasources/user/user_remote_datasource.dart';
import 'package:yaho_demo/data/repositories/user/user_repository_impl.dart';

import 'domain/repositories/user/user_repository.dart';
import 'presentation/blocs/user/user_cubit.dart';

final di = GetIt.instance;
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

Future<void> init() async {
  // Blocs
  di.registerLazySingleton<UserCubit>(() => UserCubit(userRepository: di()));

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
  di.registerLazySingleton<http.Client>(() => http.Client());
}
