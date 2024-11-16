// ignore: implementation_imports
import 'package:either_dart/src/either.dart';
import 'package:health_management/data/chat/repositories/user_repository.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';

import '../../../app/utils/errors/failure.dart';
import '../../../data/chat/datasources/user/user_data_source.dart';
import '../models/user_model.dart';

class UserChatRepositoryImpl implements UserChatRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  UserChatRepositoryImpl(this._userRemoteDataSource);
  @override
  Future<Either<Failure, UserChatModel>> getCurrentUserData() async {
    try {
      final result = await _userRemoteDataSource.getCurrentUserData();
      return Right(result!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatProfile>> getProfile(String uid) async {
    try {
      final result = await _userRemoteDataSource.getProfile(uid);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<UserChatModel> getUserById(String id) {
    return _userRemoteDataSource.getUserById(id);
  }

  @override
  Future<Either<Failure, void>> insertAccount(ChatAccount account) async {
    try {
      final result = await _userRemoteDataSource.insertAccount(account);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertProfile(ChatProfile profile) async {
    try {
      final result = await _userRemoteDataSource.insertProfile(profile);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
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
  Future<Either<Failure, void>> updateAccount(String newPassword) async {
    try {
      final result = await _userRemoteDataSource.updateAccount(newPassword);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(ChatProfile newProfile) async {
    try {
      final result = await _userRemoteDataSource.updateProfile(newProfile);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserChatModel user) async {
    try {
      final result = await _userRemoteDataSource.insertUser(user);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileImage(String path) async {
    try {
      final result = await _userRemoteDataSource.updateProfileImage(path);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
