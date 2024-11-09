// profile_event.dart
import 'package:equatable/equatable.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

final class GetInformationUser extends EditProfileEvent {
  const GetInformationUser();

  @override
  List<Object?> get props => [];
}

// Sự kiện gửi yêu cầu cập nhật hồ sơ
final class ProfileUpdateSubmittedEvent extends EditProfileEvent {
  final UserEntity userEntity;
  final AccountEntity accountEntity;
  const ProfileUpdateSubmittedEvent(this.userEntity, this.accountEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [userEntity, accountEntity];
}
