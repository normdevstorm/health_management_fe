import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_management/app/app.dart';
import 'package:health_management/domain/health_provider/usecases/health_provider_usecase.dart';

part 'health_provider_state.dart';
part 'health_provider_event.dart';

class HealthProviderBloc
    extends Bloc<HealthProviderEvent, HealthProviderState> {
  final HealthProviderUseCase healthProviderUseCase;
  
  HealthProviderBloc({required this.healthProviderUseCase}) : super(HealthProviderState.initial()){
    on<GetAllHealthProviderEvent>(
        (event, emit) => _onGetAllHealthProviderEvent(event, emit));
  }
  
  _onGetAllHealthProviderEvent(GetAllHealthProviderEvent event, Emitter<HealthProviderState> emit) async {
    emit(HealthProviderState.loading());
    try {
      final healthProviders = await healthProviderUseCase.getAllHealthProvider();
      emit(HealthProviderState.success(healthProviders));
    } catch (e) {
      emit(HealthProviderState.error(e.toString()));
    }
  }


  
}
