import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaho_demo/core/error/failures.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';
import 'package:yaho_demo/domain/repositories/user/user_repository.dart';
import 'package:yaho_demo/presentation/blocs/user/user_state.dart';

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
          // TODO: add correspond state
          emit(const UserState.error());
          return;
        }
        final paginationData = userRepository.getPaginationData();
        paginationData.fold(
          (failure) => emit(const UserState.error()),
          (paginationData) =>
              emit(UserState.loaded(paginationData, users, false)),
        );
      },
    );
  }

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
  }

  void _handleFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        print(failure.message);
        break;
      case ClientNetworkFailure:
        print(failure.message);
        break;
      case GeneralFailure:
        print(failure.message);
        break;
      default:
        print(failure.message);
    }
    emit(const UserState.error());
  }
}
