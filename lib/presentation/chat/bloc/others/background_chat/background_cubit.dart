import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/data/chat/datasources/others/change_background_color.dart';

part 'background_state.dart';

class BackgroundCubit extends Cubit<BackgroundState> {
  BackgroundCubit() : super(const InitialBackground([Colors.white, Colors.white])){
    loadBackgroundColor();
  }
  Future<void> loadBackgroundColor() async {
    // Lấy giá trị backgroundColor từ SharedPreferences
    emit(ChangeBackgroundLoading());
    try{
      final backgroundColor = await getBackground();
      emit(GetBackgroundSuccess(backgroundColor));
    } catch (e) {
      emit(BackgroundError(e.toString()));
    }
  }

}

