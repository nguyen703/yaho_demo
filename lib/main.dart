import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/styles.dart';

import 'init_dependencies.dart' as di;
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yaho! Demo',
      theme: BaseTheme.theme,
      home: const MyHomePage(),
    );
  }
}
