part of 'background_cubit.dart';

abstract class BackgroundState extends Equatable {
  const BackgroundState();

  @override
  List<Object?> get props => [];
}

class InitialBackground extends BackgroundState {
  final List<Color> defaultBackground;
  const InitialBackground(this.defaultBackground);
  @override
  List<Object?> get props => defaultBackground;
}

class ChangeBackgroundLoading extends BackgroundState {}

class GetBackgroundSuccess extends BackgroundState {
  final List<Color> gradientColors;

  const GetBackgroundSuccess(this.gradientColors);

  @override
  List<Object?> get props => [gradientColors];
}

class BackgroundError extends BackgroundState {
  final String message;

  const BackgroundError(this.message);

  @override
  List<Object?> get props => [message];
}
