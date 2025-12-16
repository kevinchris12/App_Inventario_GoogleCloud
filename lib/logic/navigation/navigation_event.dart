import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToHome extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToHome({
    this.destination = 'HomeScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = true,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToInventario extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToInventario({
    this.destination = 'InventarioScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = true,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToInventarioEdicionX extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToInventarioEdicionX({
    this.destination = 'InventarioEdicionXScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = true,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToLogin extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToLogin({
    this.destination = 'LoginScreenState',
    this.showBottomNav = false,
    this.showBottomFloatingActionButton = false,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToRegister extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToRegister({
    this.destination = 'RegisterScreenState',
    this.showBottomNav = false,
    this.showBottomFloatingActionButton = false,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToInventarios extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToInventarios({
    this.destination = 'InventariosScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = true,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToVisualizacionProductoX extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToVisualizacionProductoX({
    this.destination = 'VisualizacionProductoXScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = false,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToProductos extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToProductos({
    this.destination = 'ProductosScreenState',
    this.showBottomNav = true,
    this.showBottomFloatingActionButton = true,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToNotificaciones extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToNotificaciones({
    this.destination = 'NotificacionesScreenState',
    this.showBottomNav = false,
    this.showBottomFloatingActionButton = false,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToOpciones extends NavigationEvent {
  final String destination;

  final bool showBottomNav;
  final bool showBottomFloatingActionButton;

  const NavigateToOpciones({
    this.destination = 'OpcionesScreenState',
    this.showBottomNav = false,
    this.showBottomFloatingActionButton = false,
  });

  @override
  List<Object?> get props => [
    destination,
    showBottomNav,
    showBottomFloatingActionButton,
  ];
}

class NavigateToPreviousPage extends NavigationEvent {
  const NavigateToPreviousPage();

  @override
  List<Object?> get props => [];
}
