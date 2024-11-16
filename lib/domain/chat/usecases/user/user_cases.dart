import 'package:health_management/app/utils/errors/exception.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/data/chat/repositories/user_repository.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';

// ignore: implementation_imports
import 'package:either_dart/src/either.dart';

class UserChatUseCase implements UserChatRepository {
  final UserChatRepository _repository;

  UserChatUseCase(this._repository);

  @override
  Future<Either<Failure, UserChatModel>> getCurrentUserData() {
    return _repository.getCurrentUserData();
  }

  @override
  Future<Either<Failure, ChatProfile>> getProfile(String uid) {
    if (uid.isEmpty) {
      throw FirebaseDatabaseException('getProfile: uid is empty');
    } else {
      return _repository.getProfile(uid);
    }
  }

  @override
  Stream<UserChatModel> getUserById(String id) {
    return _repository.getUserById(id);
  }

  @override
  Future<Either<Failure, void>> insertAccount(ChatAccount account) {
    if (account.email.isEmpty || account.password.isEmpty) {
      throw FirebaseDatabaseException(
          'insertAccount: email or password is empty');
    } else {
      return _repository.insertAccount(account);
    }
  }

  @override
  Future<Either<Failure, void>> insertProfile(ChatProfile profile) {
    if (profile.userName.isEmpty) {
      throw FirebaseDatabaseException('insertProfile: userName is empty');
    } else {
      return _repository.insertProfile(profile);
    }
  }

  @override
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline) {
    return _repository.setUserStateStatus(isOnline);
  }

  @override
  Future<Either<Failure, void>> updateAccount(String newPassword) {
    if (newPassword.isEmpty) {
      throw FirebaseDatabaseException('updateAccount: newPassword is empty');
    } else {
      return _repository.updateAccount(newPassword);
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(ChatProfile newProfile) {
    if (newProfile.userName.isEmpty) {
      throw FirebaseDatabaseException('updateProfile: userName is empty');
    } else {
      return _repository.updateProfile(newProfile);
    }
  }

  @override
  Future<Either<Failure, void>> insertUser(UserChatModel user) {
    if (user.uid.isEmpty) {
      throw FirebaseDatabaseException('insertUser: uid is empty');
    } else {
      return _repository.insertUser(user);
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileImage(String path) {
    if (path.isEmpty) {
      throw FirebaseDatabaseException('updateProfileImage: path is empty');
    } else {
      return _repository.updateProfileImage(path);
    }
  }
}
