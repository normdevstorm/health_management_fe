part of 'chat_group_cubit.dart';

class ChatGroupState extends Equatable {
  const ChatGroupState();

  @override
  List<Object> get props => [];
}

class ChatGroupInitial extends ChatGroupState {}

class ChatGroupError extends ChatGroupState {
  final String message;
  const ChatGroupError(this.message);
  @override
  List<Object> get props => [message];
}

class ChatGroupLoading extends ChatGroupState {}

class ChatGroupCreated extends ChatGroupState {}

class ChooseContactSuccess extends ChatGroupState {}
