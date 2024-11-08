import 'package:bloc/bloc.dart';
import 'package:health_management/domain/user/usecases/user_usecase.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_event.dart';
import 'package:health_management/presentation/edit_profile/bloc/edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final UserUseCase userUseCase;

  EditProfileBloc({required this.userUseCase})
      : super(EditProfileState.initial()) {
    on<GetUserByIdEvent>((event, emit) => _onGetUserByIdEvent(event, emit));
  }

  _onGetUserByIdEvent(
      GetUserByIdEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileState.loading());
    try {
      final userResponse = await userUseCase.getUserById(3);
      emit(EditProfileState.success(userResponse));
    } catch (e) {
      emit(EditProfileState.error(e.toString()));
    }
  }
}
