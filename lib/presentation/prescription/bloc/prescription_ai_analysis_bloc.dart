import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/data/prescription/models/request/prescription_ai_analysis_request.dart';
import 'package:health_management/domain/prescription/entities/prescription_side_effect_risk_entity.dart';
import 'package:health_management/domain/prescription/usecases/prescription_usecase.dart';

import '../../../app/app.dart';
import '../../../app/config/api_exception.dart';

part 'prescription_ai_analysis_event.dart';
part 'prescription_ai_analysis_state.dart';

class PrescriptionAiAnalysisBloc
    extends Bloc<PrescriptionAiAnalysisEvent, PrescriptionAiAnalysisState> {
  final PrescriptionUseCase prescriptionAiAnalysisUseCase;
  PrescriptionAiAnalysisBloc({required this.prescriptionAiAnalysisUseCase})
      : super(PrescriptionAiAnalysisState.initial()) {
    on<AnalyzePrescription>(
        (event, emit) => _onAnalyzePrescription(event, emit));
  }

  _onAnalyzePrescription(AnalyzePrescription event,
      Emitter<PrescriptionAiAnalysisState> emit) async {
    emit(PrescriptionAiAnalysisState.loading());
    try {
      final risks = await prescriptionAiAnalysisUseCase
          .analyzePrescriptionByAi(event.analyzedMedicines);
      emit(PrescriptionAiAnalysisState.success(risks ?? []));
      // emit(PrescriptionAiAnalysisState.success(const []));
    } on ApiException catch (e) {
      emit(PrescriptionAiAnalysisState.error(ApiException.getErrorMessage(e)));
    }
  }
}
