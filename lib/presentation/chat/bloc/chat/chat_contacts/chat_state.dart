part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatError extends ChatState {
  final String message;
  const ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}


class ChatDeletedSuccess extends ChatState {}
