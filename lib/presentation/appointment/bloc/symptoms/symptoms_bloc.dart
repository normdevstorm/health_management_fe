import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/symptoms/entities/symptoms_entity.dart';
import 'package:health_management/domain/symptoms/usecase/symptom_usecase.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  final SymptomUseCase symptomUseCase;

  SymptomsBloc(this.symptomUseCase) : super(SymptomsState.initial()) {
    on<FetchSymptomsEvent>(_onFetchSymptoms);
  }

  Future<void> _onFetchSymptoms(
    FetchSymptomsEvent event,
    Emitter<SymptomsState> emit,
  ) async {
    emit(SymptomsState.loading());
    try {
      final symptoms = await symptomUseCase.getSymptoms();
      emit(SymptomsState.success(symptoms: symptoms));
    } on Exception catch (e) {
      emit(SymptomsState.error(e.toString()));
    }
  }
}
