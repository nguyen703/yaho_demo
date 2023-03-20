import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:yaho_demo/common/styles/base_color.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';
import 'package:yaho_demo/gen/assets.gen.dart';
import 'package:yaho_demo/presentation/blocs/user/user_cubit.dart';
import 'package:yaho_demo/presentation/blocs/user/user_state.dart';
import 'package:yaho_demo/presentation/views/widgets/common_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaho_demo/presentation/views/widgets/user/user_list_tile_reached_max_widget.dart';

import '../widgets/user/user_content_placeholder_widget.dart';
import '../widgets/user/user_grid_tile_reached_max_widget.dart';
import '../widgets/user/user_grid_tile_widget.dart';
import '../widgets/user/user_list_tile_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final UserCubit _userCubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _userCubit = GetIt.instance.get<UserCubit>();
    _scrollController = ScrollController();
    _userCubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWidget(
        title: "Users",
        trailing: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state.whenOrNull(
                    loaded: (pageInfo, users, isListView) {
                      // Only show Switch button when data is loaded
                      return TrailingViewSwitchButtonWidget(
                        onTap: () {
                          _userCubit.changeViewType(_scrollController);
                        },
                        isListView: isListView,
                      );
                    },
                  ) ??
                  const SizedBox.shrink();
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          color: BaseColor.grey50,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state.when(
                          loaded: (pageInfo, users, isListView) {
                            if (isListView) {
                              return buildListView(users, pageInfo);
                            }
                            return buildGridView(users, pageInfo);
                          },
                          loading: () => const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 32.0),
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                          empty: () => const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 32),
                                  child: UserContentPlaceholderWidget(
                                    type: UserContentType.empty,
                                  ),
                                ),
                              ),
                          error: () => const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 32),
                                  child: UserContentPlaceholderWidget(
                                      type: UserContentType.error),
                                ),
                              ));
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildListView(List<User> users, PageInfo pageInfo) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == users.length) {
            _userCubit.loadMore(users);
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

  Widget buildGridView(List<User> users, PageInfo pageInfo) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == users.length) {
            _userCubit.loadMore(users);
            if (pageInfo.page == pageInfo.totalPages) {
              return const UserGridTileReachedMaxWidget();
            }
            return const CupertinoActivityIndicator();
          }
          return UserGridTileWidget(user: users[index]);
        },
        childCount: users.length + 1,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
    );
  }
}

class TrailingViewSwitchButtonWidget extends StatelessWidget {
  const TrailingViewSwitchButtonWidget({
    super.key,
    required this.isListView,
    required this.onTap,
  });

  final bool isListView;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: SvgPicture.asset(
            isListView ? Assets.icons.gridViewIcon : Assets.icons.listViewIcon,
            width: 24,
            height: 24,
            alignment: Alignment.centerRight,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ));
  }
}
