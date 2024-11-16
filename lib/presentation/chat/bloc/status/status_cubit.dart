import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/chat/models/status_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  final repository = getIt<AppChatUseCases>().status;

  StatusCubit() : super(StatusInitial());

  Future<void> addStatus(
      {required String username,
      required String profilePicture,
      required File statusImage,
      required List<String> uidOnAppContact,
      required String caption}) async {
    emit(StatusLoadingState());
    final result = await repository.uploadStatus(
        username: username,
        profilePicture: profilePicture,
        statusImage: statusImage,
        uidOnAppContact: uidOnAppContact,
        caption: caption);
    result.fold(
      (error) => emit(StatusErrorState(error.message)),
      (success) => emit(UploadStatusSuccess()),
    );
  }

  Stream<List<StatusModel>> getStatus() {
    return repository.getStatus();
  }
}
