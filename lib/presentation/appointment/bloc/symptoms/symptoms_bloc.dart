import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/app/config/api_exception.dart';
import 'package:health_management/data/symptom/models/recommend_ai_response.dart';
import 'package:health_management/domain/symptoms/usecase/symptom_usecase.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  final SymptomUseCase symptomUseCase;

  SymptomsBloc(this.symptomUseCase) : super(SymptomsState.initial()) {
    on<FetchSymptomsEvent>(_onFetchSymptoms);
    on<DiagnoseSymptomsEvent>(_onDiagnoseSymptoms);
  }

  Future<void> _onFetchSymptoms(
    FetchSymptomsEvent event,
    Emitter<SymptomsState> emit,
  ) async {
    emit(SymptomsState.loading());
    try {
      final symptoms = await symptomUseCase.getSymptoms();
      print('SymptomsBloc Fetched: $symptoms'); // Debug
      emit(SymptomsState.success(symptoms: symptoms));
    } on ApiException catch (e) {
      emit(SymptomsState.error(ApiException.getErrorMessage(e)));
    } catch (e) {
      emit(SymptomsState.error('An unexpected error occurred: $e'));
    }
  }

  Future<void> _onDiagnoseSymptoms(
    DiagnoseSymptomsEvent event,
    Emitter<SymptomsState> emit,
  ) async {
    emit(SymptomsState.loading());
    try {
      final response = await symptomUseCase.diagnose(event.symptoms);
      print('Diagnose Response: ${response.toJson()}');
      emit(SymptomsState.success(
        symptoms: state.symptoms,
        diagnosisResponse: response,
      ));
    } on ApiException catch (e) {
      emit(SymptomsState.error(ApiException.getErrorMessage(e)));
    } catch (e) {
      emit(SymptomsState.error('An unexpected error occurred: $e'));
    }
  }
}

extension RecommendAiResponseExtension on RecommendAiResponse {
  Map<String, dynamic> toJson() {
    return {
      'diagnoses': diagnoses
          .map((e) => {
                'disease': e.disease,
                'confidence': e.confidence,
                'department': e.department,
                'explanation': e.explanation,
              })
          .toList(),
      'final_diagnosis': finalDiagnosis,
      'recommendations': recommendations,
    };
  }
}
