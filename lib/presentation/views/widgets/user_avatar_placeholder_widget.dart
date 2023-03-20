import 'package:flutter/material.dart';
import 'package:yaho_demo/gen/assets.gen.dart';

import '../../../common/styles/styles.dart';

class UserAvatarPlaceholderWidget extends StatelessWidget {
  const UserAvatarPlaceholderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BaseColor.grey200,
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Image(image: Assets.images.avatarPlaceholder.provider()),
      ),
    );
  }
}
