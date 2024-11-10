
import 'package:bloc/bloc.dart';
import 'package:health_management/app/managers/local_storage.dart';
import 'package:health_management/data/user/models/request/update_account_request.dart';
import 'package:health_management/data/user/models/request/update_user_request.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserUseCase userUseCase;
  // final LogEvent logger;

  EditProfileBloc({required this.userUseCase})
      : super(EditProfileState.initial()) {
    on<GetInformationUser>((event, emit) => _onGetInformationUser(event, emit));
    on<ProfileUpdateSubmittedEvent>(
        (event, emit) => _onProfileUpdateSubmitEvent(event, emit));
  }

  _onGetInformationUser(
      GetInformationUser event, Emitter<EditProfileState> emit) async {
    emit(EditProfileState.loading());
    try {
      final userResponse = await SharedPreferenceManager.getUser();
      emit(EditProfileState.success(userResponse));
    } catch (e) {
      emit(EditProfileState.error(e.toString()));
    }
  }

  _onProfileUpdateSubmitEvent(
      ProfileUpdateSubmittedEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileState.loading());
    try {
      final user = await SharedPreferenceManager.getUser();
      final userId = user?.id;
      // tao request cho user
      UpdateAccountRequest updateAccountRequest = UpdateAccountRequest(
          email: event.accountEntity.email, phone: event.accountEntity.phone);

      UpdateUserRequest updateUserRequest = UpdateUserRequest(
          firstName: event.userEntity.firstName,
          lastName: event.userEntity.lastName,
          gender: event.userEntity.gender,
          dateOfBirth: event.userEntity.dateOfBirth,
          avatarUrl: event.userEntity.avatarUrl,
          account: updateAccountRequest);
      final userEntity =
          await userUseCase.updateUser(updateUserRequest, userId);
      await SharedPreferenceManager.setUser(userEntity);
      emit(EditProfileState.success(userEntity));
    } catch (e) {
      emit(EditProfileState.error(e.toString()));
    }
  }
}
