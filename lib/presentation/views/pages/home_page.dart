import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yaho_demo/common/styles/base_text_style.dart';
import 'package:yaho_demo/gen/assets.gen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: const Center(child: Text("Users")),
        actions: [
          GestureDetector(
              onTap: () {
                print("Action item pressed");
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  Assets.icons.threeDotsVertical,
                  width: 32,
                  height: 32,
                  alignment: Alignment.centerRight,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: BaseTextStyle.body1(),
            ),
          ],
        ),
      ),
    );
  }
}
