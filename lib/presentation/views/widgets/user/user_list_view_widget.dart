import 'package:flutter/cupertino.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';

import 'user_list_tile_reached_max_widget.dart';
import 'user_list_tile_widget.dart';

class UserListViewWidget extends StatelessWidget {
  const UserListViewWidget(
      {Key? key,
      required this.users,
      required this.pageInfo,
      required this.onReachMaxExtent})
      : super(key: key);

  final List<User> users;
  final PageInfo pageInfo;
  final VoidCallback onReachMaxExtent;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == users.length) {
            onReachMaxExtent();
            if (pageInfo.page == pageInfo.totalPages) {
              return const UserListTileReachedMaxWidget();
            }
            return const CupertinoActivityIndicator();
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: UserListTileWidget(
              key: ValueKey(users[index]),
              user: users[index],
            ),
          );
        },
        childCount: users.length + 1,
      ),
    );
  }
}
