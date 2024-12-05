import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/models/profile_model.dart';
import 'package:health_management/domain/chat/models/user_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final usecase = getIt.call<AppChatUseCases>;
  UserCubit() : super(UserInitialState());

  UserChatModel? userModel;
  ChatProfile? profile;
  ChatAccount? account;
  Future<void> getCurrentUser() async {
    final result = await usecase()
        .user
        .getCurrentUserData(); //type: Either<Failure, UserModel>
    result.fold(
      (error) => emit(UserError(message: error.toString())),
      (success) {
        userModel = success;
        emit(GetCurrentUserSuccess());
      },
    );
  }

  Stream<UserChatModel> getUserById(String id) {
    return usecase().user.getUserById(id);
  }

  Future<void> setUserStateStatus(bool isOnline) async {
    final result = await usecase().user.setUserStateStatus(isOnline);
    result.fold(
      (l) => emit(SetUserStatusError()),
      (r) => emit(SetUserStatusSuccess()),
    );
  }

  Future<void> updateProfileImage(String path) async {
    final result = usecase().user.updateProfileImage(path);
    result.fold((l) => emit(UserError(message: l.message)),
        (r) => emit(UpdateProfileImageSuccess()));
  }

  Future<void> getProfile(String uid) async {
    final result = await usecase().user.getProfile(uid);
    result.fold((l) => emit(UserError(message: l.message)), (r) {
      profile = r as ChatProfile?;
      emit(GetProfileSuccess(profile: r));
    });
  }
}
