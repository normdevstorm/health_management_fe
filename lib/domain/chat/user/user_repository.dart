import 'package:either_dart/either.dart';
import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/user/user_model.dart';

abstract class UserChatRepository {
  Future<Either<Failure, UserModel>> getCurrentUserData();
  Stream<UserModel> getUserById(String id);
  Future<Either<Failure, void>> setUserStateStatus(bool isOnline);
  Future<Either<Failure, void>> insertUser(UserModel user);
}
