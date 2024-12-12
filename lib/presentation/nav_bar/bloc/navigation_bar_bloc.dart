import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_bar_event.dart';
part 'navigation_bar_state.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  NavigationBarBloc()
      : super(const NavigationBarState(showNavigationBar: true)) {
    on<NavigationBarEvent>((event, emit) {});
    on<NavigationBarChangeStatus>((event, emit) {
      emit(NavigationBarState(showNavigationBar: event.showNavigationBar));
    });
  }
}
