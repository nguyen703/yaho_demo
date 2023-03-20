import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaho_demo/core/error/failures.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';
import 'package:yaho_demo/domain/repositories/user/user_repository.dart';
import 'package:yaho_demo/init_dependencies.dart';
import 'package:yaho_demo/presentation/blocs/user/user_state.dart';
import 'package:yaho_demo/presentation/views/widgets/common_snack_bar_widget.dart';

const int _firstUserPage = 1;

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.userRepository}) : super(const UserState.loading());

  final UserRepository userRepository;

  void init() async {
    final usersOrFailure = await userRepository.getUsers(page: _firstUserPage);
    usersOrFailure.fold(
      (failure) {
        _handleFailure(failure);
      },
      (users) {
        if (users == null) {
          emit(const UserState.error());
          return;
        }
        if (users.isEmpty) {
          emit(const UserState.empty());
          return;
        }
        final paginationData = userRepository.getPaginationData();
        paginationData.fold(
          (failure) => emit(const UserState.error()),
          (paginationData) =>
              emit(UserState.loaded(paginationData, users, true)),
        );
      },
    );
  }

  /// Triggers when reached the last index of the list.
  Future<void> loadMore(List<User> currentUsers) async {
    final pageDataOrFailure = userRepository.getPaginationData();

    if (pageDataOrFailure.isRight) {
      final paginationData = pageDataOrFailure.right;

      // Do not fetch data if the current page reached max
      if (paginationData.page! >= paginationData.totalPages!) {
        if (state is UserStateLoaded) {
          emit((state as UserStateLoaded).copyWith(pageInfo: paginationData));
        }
        return;
      }

      // Fetch more data as current page < max pages
      _fetchMoreUsers(currentUsers, paginationData);
    }
  }

  /// Change to another view type (ListView - GridView).
  void changeViewType(ScrollController controller) {
    if (state is UserStateLoaded) {
      final loadedState = state;
      emit((loadedState as UserStateLoaded)
          .copyWith(isListview: !loadedState.isListview));

      // Jump to head of the list
      controller.jumpTo(controller.initialScrollOffset);
    }
  }

  /// Fetches more from remote repo based on the current page info and emit
  /// new Loaded state.
  Future<void> _fetchMoreUsers(
      List<User> currentUsers, PageInfo paginationData) async {
    final newUsersOrFailure =
        await userRepository.getUsers(page: paginationData.page! + 1);
    newUsersOrFailure.fold(
      (failure) {
        _handleFailure(failure);
      },
      (newUsers) {
        final newList = List<User>.from(currentUsers);
        newList.addAll(newUsers!);
        if (state is UserStateLoaded) {
          emit((state as UserStateLoaded)
              .copyWith(pageInfo: paginationData, users: newList));
        }
      },
    );
  }

  /// Handles Failures to notify users for a better UX.
  /// Should have custom snack bars adapt to the corresponding failure
  void _handleFailure(Failure failure) {
    scaffoldKey.currentState?.showSnackBar(
        SnackBar(content: CommonSnackBarWidget(content: failure.message!)));
    switch (failure.runtimeType) {
      case ServerFailure:
        debugPrint(failure.message);
        break;
      case ClientNetworkFailure:
        debugPrint(failure.message);
        break;
      case GeneralFailure:
        debugPrint(failure.message);
        break;
      default:
        debugPrint(failure.message);
    }
    emit(const UserState.error());
  }
}
