import 'package:either_dart/either.dart';

import '../../../../app/utils/errors/failure.dart';
import '../../../../data/chat/repositories/contacts_repository.dart';
import '../../models/user_model.dart';

class ContactsUseCase {
  final ContactsRepository _contactsRepository;

  ContactsUseCase(this._contactsRepository);

  Future<Either<Failure, List<UserChatModel>>> getAllContacts() async {
    return await _contactsRepository.getAllContacts();
  }
}
