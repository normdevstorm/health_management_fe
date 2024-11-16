import 'package:health_management/app/utils/errors/failure.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:either_dart/either.dart';

abstract class ContactsRepository {
  Future<Either<Failure, List<UserChatModel>>> getAllContacts();
}
