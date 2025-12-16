import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
    : super(const NavigationState(currentRoute: 'HomeScreenState')) {
    on<NavigateToHome>(_onNavigateToHome);
    on<NavigateToInventario>(_onNavigateToInventario);
    on<NavigateToInventarios>(_onNavigateToInventarios);
    on<NavigateToInventarioEdicionX>(_onNavigateToInventarioEdicionX);
    on<NavigateToVisualizacionProductoX>(_onNavigateToVisualizacionProductoX);
    on<NavigateToProductos>(_onNavigateToProductos);

    on<NavigateToNotificaciones>(_onNavigateToNotificaciones);
    on<NavigateToOpciones>(_onNavigateToOpciones);

    on<NavigateToPreviousPage>(_onNavigateToPreviousPage);

    on<NavigateToLogin>(_onNavigateToLogin);
    on<NavigateToRegister>(_onNavigateToRegister);
  }

  Future<void> _onNavigateToHome(
    NavigateToHome event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToInventario(
    NavigateToInventario event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
        mensajeExito: 'Navigated to Inventario successfully',
      ),
    );
  }

  Future<void> _onNavigateToInventarios(
    NavigateToInventarios event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToInventarioEdicionX(
    NavigateToInventarioEdicionX event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToVisualizacionProductoX(
    NavigateToVisualizacionProductoX event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToProductos(
    NavigateToProductos event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToNotificaciones(
    NavigateToNotificaciones event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        previousRoute: state.currentRoute,
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToOpciones(
    NavigateToOpciones event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        previousRoute: state.currentRoute,
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToPreviousPage(
    NavigateToPreviousPage event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: state.previousRoute ?? 'HomeScreenState',
        showBottomNav: true,
        showBottomFloatingActionButton: true,
      ),
    );
  }

  Future<void> _onNavigateToLogin(
    NavigateToLogin event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }

  Future<void> _onNavigateToRegister(
    NavigateToRegister event,
    Emitter<NavigationState> emit,
  ) async {
    emit(
      state.copyWith(
        currentRoute: event.destination,
        showBottomNav: event.showBottomNav,
        showBottomFloatingActionButton: event.showBottomFloatingActionButton,
      ),
    );
  }
}
