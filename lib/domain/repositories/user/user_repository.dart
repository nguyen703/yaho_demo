import 'package:either_dart/either.dart';
import 'package:yaho_demo/core/error/failures.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';

import '../../entities/user/user.dart';

/// The repository layer of User.
///
/// This provides all the usecases from User features.
abstract class UserRepository {
  Future<Either<Failure, List<User>?>> getUsers({required int page});

  Either<Failure, PageInfo> getPaginationData();

  Future<void> savePaginationData(PageInfo pageInfo);
}
