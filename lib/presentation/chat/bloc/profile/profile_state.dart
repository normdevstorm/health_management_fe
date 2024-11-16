part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState<T> extends ProfileState {
  final ChatProfile profile;
  const ProfileLoadedState({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String message;
  const ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileUpdated extends ProfileState {}
