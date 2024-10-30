import 'package:either_dart/either.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/data/chat/datasource/user_datasource.dart';
import 'package:health_management/domain/chat/user/user_model.dart';
import 'package:health_management/domain/chat/user/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  UserRepositoryImpl(this._userRemoteDataSource);
  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async {
    try {
      final result = await _userRemoteDataSource.getCurrentUserData();
      return Right(result!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserModel> getUserById(String id) {
    return _userRemoteDataSource.getUserById(id);
  }

  @override
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline) async {
    try {
      final result = await _userRemoteDataSource.setUserStateStatus(isOnline);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserModel user) async {
    try {
      final result = await _userRemoteDataSource.insertUser(user);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
