import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  /// Estados para indicar un exito o error en las operaciones
  final String? mensajeError;
  final String? mensajeExito;

  final String currentRoute;
  final String? previousRoute;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigationState({
    this.mensajeError,
    this.mensajeExito,

    required this.currentRoute,
    this.previousRoute,

    this.showBottomNav = false,
    this.showBottomFloatingActionButton = false,
  });

  NavigationState copyWith({
    String? mensajeError,
    String? mensajeExito,

    String? currentRoute,
    String? previousRoute,

    bool? showBottomNav,
    bool? showBottomFloatingActionButton,
  }) {
    return NavigationState(
      mensajeError: mensajeError ?? this.mensajeError,
      mensajeExito: mensajeExito ?? this.mensajeExito,
      currentRoute: currentRoute ?? this.currentRoute,
      previousRoute: previousRoute ?? this.previousRoute,
      showBottomNav: showBottomNav ?? this.showBottomNav,
      showBottomFloatingActionButton:
          showBottomFloatingActionButton ?? this.showBottomFloatingActionButton,
    );
  }

  @override
  List<Object?> get props => [
    mensajeError,
    mensajeExito,

    currentRoute,
    previousRoute,

    showBottomNav,
    showBottomFloatingActionButton,
  ];
}
