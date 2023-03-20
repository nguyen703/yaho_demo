import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yaho_demo/common/styles/styles.dart';
import 'package:yaho_demo/common/utils/user_helper.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';

import '../user_avatar_placeholder_widget.dart';

class UserListTileWidget extends StatelessWidget {
  const UserListTileWidget({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: BaseColor.green100),
      height: 88,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,

                  // if the image url is invalid, automatically returns errorWidget
                  imageUrl: user.avatar ?? "",

                  errorWidget: (_, __, ___) =>
                      const UserAvatarPlaceholderWidget(),
                  placeholder: (_, __) => const UserAvatarPlaceholderWidget(),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              UserHelper.getUserName(user),
                              style: BaseTextStyle.subtitle2(),
                              overflow: TextOverflow.ellipsis,
                            ))),
                    Expanded(
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              UserHelper.getUserEmail(user),
                              style: BaseTextStyle.body2(),
                              overflow: TextOverflow.ellipsis,
                            )))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
