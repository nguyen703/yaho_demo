import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:yaho_demo/common/styles/styles.dart';
import 'package:yaho_demo/presentation/blocs/theme/theme_cubit.dart';
import 'package:yaho_demo/presentation/blocs/user/user_cubit.dart';
import 'package:yaho_demo/presentation/blocs/user/user_state.dart';
import 'package:yaho_demo/presentation/views/widgets/common_app_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/user/user_content_placeholder_widget.dart';
import '../widgets/user/user_grid_view_widget.dart';
import '../widgets/user/user_list_view_widget.dart';
import '../widgets/user/user_trailing_view_switch_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final UserCubit _userCubit;
  late final ThemeCubit _themeCubit;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _userCubit = GetIt.instance.get<UserCubit>();
    _userCubit.init();
    _themeCubit = GetIt.instance.get<ThemeCubit>();
    _scrollController = ScrollController();
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
        leading: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return IconButton(
                onPressed: () => _themeCubit.toggleTheme(),
                icon: Icon(
                  theme == BaseTheme.lightTheme
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  color: Theme.of(context).primaryColor,
                ));
          },
        ),
        trailing: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return state.whenOrNull(
                    loaded: (pageInfo, users, isListView) {
                      // Only show Switch button when data is loaded
                      return UserTrailingViewSwitchButton(
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
                            return UserListViewWidget(
                                users: users,
                                pageInfo: pageInfo,
                                onReachMaxExtent: () =>
                                    _userCubit.loadMore(users));
                          }
                          return UserGridViewWidget(
                              users: users,
                              pageInfo: pageInfo,
                              onReachMaxExtent: () =>
                                  _userCubit.loadMore(users));
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
    );
  }
}
