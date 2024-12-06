import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/di/injection.dart';
import 'package:health_management/domain/chat/models/account_model.dart';
import 'package:health_management/domain/chat/usecases/app_use_cases.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final usecases = getIt<AppChatUseCases>();
  AccountCubit() : super(AccountInitialState());

  Future<void> changePassword(String newPassword) async {
    emit(AccountLoadingState());
    final result = await usecases.user.updateAccount(newPassword);
    result.fold(
      (error) => emit(AccountErrorState(message: error.toString())),
      (success) => emit(AccountUpdated()),
    );
  }
}
