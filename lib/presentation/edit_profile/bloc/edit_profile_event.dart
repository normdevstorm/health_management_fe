// profile_event.dart
import 'package:equatable/equatable.dart';
import 'package:health_management/domain/user/entities/account_entity.dart';
import 'package:health_management/domain/user/entities/user_entity.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện gửi yêu cầu lấy thông tin người dùng theo ID
final class GetUserByIdEvent extends EditProfileEvent {
  final int userId;

  const GetUserByIdEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

// Sự kiện gửi yêu cầu cập nhật hồ sơ
final class ProfileUpdateSubmittedEvent extends EditProfileEvent {
  final UserEntity userEntity;
  const ProfileUpdateSubmittedEvent(this.userEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [userEntity];
}

// Dữ liệu yêu cầu cập nhật tài khoản
final class UpdateAccountRequestEvent extends EditProfileEvent {
  final AccountEntity accountEntity;

  const UpdateAccountRequestEvent(this.accountEntity);

  @override
  List<Object?> get props => [accountEntity];
}
