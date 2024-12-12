part of 'navigation_bar_bloc.dart';

class NavigationBarEvent extends Equatable {
  const NavigationBarEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NavigationBarChangeStatus extends NavigationBarEvent {
  final bool showNavigationBar;
  const NavigationBarChangeStatus({required this.showNavigationBar});

  @override
  // TODO: implement props
  List<Object?> get props => [showNavigationBar];
}
