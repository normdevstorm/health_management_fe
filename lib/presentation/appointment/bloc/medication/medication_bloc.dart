import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/domain/prescription/usecases/prescription_usecase.dart';
import '../../../../app/app.dart';
import '../../../../app/config/api_exception.dart';
part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final PrescriptionUseCase prescriptionUseCase;
  MedicationBloc({required this.prescriptionUseCase}) : super(MedicationState.initial()) {
    on<GetAllMedicationEvent>(
        (event, emit) => _onGetAllMedicationEvent(event, emit));
  }
  
  _onGetAllMedicationEvent(GetAllMedicationEvent event, Emitter<MedicationState> emit)async {
    emit(MedicationState.loading());
    try {
      final medications = await prescriptionUseCase.getAllMedications();
      emit(MedicationState.success(medications)); 
    } on ApiException catch (e) {
      emit(MedicationState.error(ApiException.getErrorMessage(e)));
    }
  }
}
