import 'package:health_management/app/utils/errors/failure.dart';
import 'package:either_dart/either.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';

abstract class UserChatRepository {
  Future<Either<Failure, UserChatModel>> getCurrentUserData();
  Stream<UserChatModel> getUserById(String id);
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline);
  Future<Either<Failure, void>> updateProfile(ChatProfile newProfile);
  Future<Either<Failure, void>> updateAccount(String newPassword);
  Future<Either<Failure, ChatProfile>> getProfile(String uid);
  Future<Either<Failure, void>> insertProfile(ChatProfile profile);
  Future<Either<Failure, void>> insertAccount(ChatAccount account);
  Future<Either<Failure, void>> insertUser(UserChatModel user);
  Future<Either<Failure, void>> updateProfileImage(String path);
}
