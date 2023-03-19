import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/styles.dart';

class UserGridTileReachedMaxWidget extends StatelessWidget {
  const UserGridTileReachedMaxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: BaseColor.green100),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Center(
            child: Text(
              "You got all the users ;)",
              style: BaseTextStyle.body2(color: BaseColor.grey300),
            ),
          )),
    );
  }
}
