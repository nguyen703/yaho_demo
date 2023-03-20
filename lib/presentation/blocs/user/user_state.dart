import 'package:yaho_demo/domain/entities/user/page_info.dart';
import 'package:yaho_demo/domain/entities/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loading() = UserStateLoading;
  const factory UserState.loaded(
      PageInfo pageInfo, List<User> users, bool isListview) = UserStateLoaded;
  const factory UserState.empty() = UserStateEmpty;
  const factory UserState.error() = UserStateError;
}
