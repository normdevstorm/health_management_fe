import 'package:either_dart/either.dart';

import '../../../app/utils/errors/failure.dart';
import '../../../data/chat/datasources/contacts/contacts_data_source.dart';
import '../../../data/chat/repositories/contacts_repository.dart';
import '../models/user_model.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsRemoteDataSource contactsRemoteDataSource;

  ContactsRepositoryImpl(this.contactsRemoteDataSource);

  @override
  Future<Either<Failure, List<UserChatModel>>> getAllContacts() async {
    try {
      final result = await contactsRemoteDataSource.getAllContacts();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
