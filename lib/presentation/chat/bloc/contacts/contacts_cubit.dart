import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';
part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final _useCases = getIt.call<AppChatUseCases>;
  ContactsCubit() : super(GetAllContactsInitial());

  List<String> contactsUid = [];
  final List<UserChatModel> _contacts = [];
  List<UserChatModel> get getContacts => _contacts;

  Future<void> getAllContacts() async {
    emit(GetAllContactsLoading());
    try {
      final contacts = await _useCases().contacts.getAllContacts();
      contacts.fold(
        (error) => emit(GetAllContactsError(message: error.message)),
        (success) {
          emit(GetAllContactsSuccess(contacts: success));
          contactsUid = success.map((e) => e.uid).toList();
          _contacts.addAll(success);
        },
      );
    } catch (e) {
      emit(GetAllContactsError(message: e.toString()));
    }
  }
}
