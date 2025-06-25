part of 'symptoms_bloc.dart';

sealed class SymptomsEvent extends Equatable {
  const SymptomsEvent();

  @override
  List<Object> get props => [];
}

final class FetchSymptomsEvent extends SymptomsEvent {
  const FetchSymptomsEvent();
}

final class DiagnoseSymptomsEvent extends SymptomsEvent {
  final List<String> symptoms;

  const DiagnoseSymptomsEvent({required this.symptoms});

  @override
  List<Object> get props => [symptoms];
}
