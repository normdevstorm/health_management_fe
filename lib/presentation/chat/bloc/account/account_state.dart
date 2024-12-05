part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object?> get props => [];
}

class AccountInitialState extends AccountState {}

class AccountLoadingState extends AccountState {}

class AccountLoadedState<T> extends AccountState {
  final ChatAccount account;
  const AccountLoadedState({required this.account});
}

class AccountErrorState extends AccountState {
  final String message;
  const AccountErrorState({required this.message});
}

class AccountUpdated extends AccountState {}
