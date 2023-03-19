import 'package:either_dart/either.dart';
import 'package:yaho_demo/core/error/exceptions.dart';
import 'package:yaho_demo/data/datasources/user/user_local_datasource.dart';
import 'package:yaho_demo/data/datasources/user/user_remote_datasource.dart';
import 'package:yaho_demo/domain/entities/user/page_info.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';
import '../../../domain/repositories/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
      {required this.userRemoteDatasource, required this.userLocalDatasource});
  final UserRemoteDatasource userRemoteDatasource;
  final UserLocalDatasource userLocalDatasource;

  @override
  Future<Either<Failure, List<User>?>> getUsers({required int page}) async {
    try {
      final users = await userRemoteDatasource.getUsers(page: page);
      return Right(users);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure());
      }
      if (e is ClientNetworkException) {
        return Left(ClientNetworkFailure());
      }
      return Left(GeneralFailure());
    }
  }

  @override
  Either<Failure, PageInfo> getPaginationData() {
    try {
      final paginationData = userLocalDatasource.getPaginationData();
      return Right(paginationData);
    } catch (e) {
      if (e is ParsingException) {
        return Left(ParsingFailure());
      }
      return Left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, void>> savePaginationData(PageInfo pageInfo) async {
    try {
      await userLocalDatasource.savePaginationData(pageInfo);
      return const Right(null);
    } catch (e) {
      if (e is ParsingException) {
        return Left(ParsingFailure());
      }
      return Left(GeneralFailure());
    }
  }
}
