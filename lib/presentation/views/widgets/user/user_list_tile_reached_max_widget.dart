import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/styles.dart';

class UserListTileReachedMaxWidget extends StatelessWidget {
  const UserListTileReachedMaxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 16),
      height: 40,
      child: Text(
        "Hi, there are no users left 😊",
        style: BaseTextStyle.body2(color: BaseColor.grey300),
      ),
    );
  }
}
