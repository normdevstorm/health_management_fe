part of 'contacts_cubit.dart';

abstract class ContactsState extends Equatable {
  const ContactsState();

  @override
  List<Object> get props => [];
}

class GetAllContactsInitial extends ContactsState {}

class GetAllContactsLoading extends ContactsState {}

class GetAllContactsSuccess extends ContactsState {
  final List<UserChatModel> contacts;

  const GetAllContactsSuccess({required this.contacts});

  @override
  List<Object> get props => [contacts];
}

class GetAllContactsError extends ContactsState {
  final String message;

  const GetAllContactsError({required this.message});

  @override
  List<Object> get props => [message];
}
