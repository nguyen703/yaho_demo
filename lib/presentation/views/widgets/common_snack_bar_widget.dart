import 'package:flutter/material.dart';

class CommonSnackBarWidget extends StatelessWidget {
  const CommonSnackBarWidget({Key? key, required this.content})
      : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(content);
  }
}
