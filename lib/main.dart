import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:yaho_demo/presentation/blocs/theme/theme_cubit.dart';
import 'package:yaho_demo/presentation/blocs/user/user_cubit.dart';

import 'init_dependencies.dart' as di;
import 'init_dependencies.dart';
import 'presentation/views/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.instance.get<UserCubit>()),
        BlocProvider.value(value: GetIt.instance.get<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, themeData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldKey,
            title: 'Yaho! Demo',
            theme: themeData,
            home: BlocProvider.value(
                value: GetIt.instance.get<UserCubit>(),
                child: const MyHomePage()),
          );
        },
      ),
    );
  }
}
