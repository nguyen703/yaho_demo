import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/styles.dart';

class UserListTileReachedMaxWidget extends StatelessWidget {
  const UserListTileReachedMaxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32,
      child: Text(
        "You got all the users ;)",
        style: BaseTextStyle.body2(color: BaseColor.grey300),
      ),
    );
  }
}
