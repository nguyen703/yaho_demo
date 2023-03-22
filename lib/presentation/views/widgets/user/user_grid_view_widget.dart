import 'package:flutter/cupertino.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';

import 'user_grid_tile_reached_max_widget.dart';
import 'user_grid_tile_widget.dart';

class UserGridViewWidget extends StatelessWidget {
  const UserGridViewWidget(
      {Key? key,
      required this.users,
      required this.pageInfo,
      required this.onReachMaxExtent,
      this.crossAxisCount = 2})
      : super(key: key);

  final List<User> users;
  final PageInfo pageInfo;
  final VoidCallback onReachMaxExtent;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == users.length) {
            onReachMaxExtent();
            if (pageInfo.page == pageInfo.totalPages) {
              return const UserGridTileReachedMaxWidget();
            }
            return const CupertinoActivityIndicator();
          }
          return UserGridTileWidget(user: users[index]);
        },
        childCount: users.length + 1,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16),
    );
  }
}
