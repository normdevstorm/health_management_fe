part of 'in_chat_cubit.dart';

abstract class InChatState extends Equatable {
  const InChatState();
  @override
  List<Object?> get props => [];
}

class InChatInitialState extends InChatState {}

class InChatLoadingState extends InChatState {}

class InChatErrorState extends InChatState {
  final String message;
  const InChatErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class GetGroupChatStreamSuccess<T> extends InChatState {
  final T data;
  const GetGroupChatStreamSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class GetChatStreamSuccess<T> extends InChatState {
  final T data;
  const GetChatStreamSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class SendTextMessageSuccess extends InChatState {}

class SendFileMessageSuccess extends InChatState {}

class MessageSelected extends InChatState {}

class SelectedMessageIndexCleared extends InChatState {}

class CancelReplayState extends InChatState {}

class MessageSwipeState extends InChatState {}

class MessageSeenSuccess extends InChatState {}

class MessageDeleted extends InChatState {}

class MessageEdited extends InChatState {}
