import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/navigation/navigation_state.dart';
import '../../logic/producto/producto_bloc.dart';
import '../screens/home_screen.dart';
import '../screens/inventario_screen.dart';
import '../screens/inventario_edicion_x_screen.dart';
import '../screens/inventarios_screen.dart';
import '../screens/notificaciones_screen.dart';
import '../screens/opciones_screen.dart';
import '../screens/visualizacion_producto_x_screen.dart';
import '../screens/productos_screen.dart';
import 'floating_menu_button.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../services/inventario_producto_coordinator.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  Widget _buildContent(String actualPage) {
    if (actualPage == 'HomeScreenState') return const HomeScreen();
    if (actualPage == 'InventarioScreenState') {
      return const InventarioScreen();
    }
    if (actualPage == 'NotificacionesScreenState') {
      return const NotificacionesScreen();
    }
    if (actualPage == 'OpcionesScreenState') {
      return const OpcionesScreen();
    }
    if (actualPage == 'InventariosScreenState') {
      return const InventariosScreen();
    }
    if (actualPage == 'InventarioEdicionXScreenState') {
      return const InventarioEdicionXScreen();
    }
    if (actualPage == 'VisualizacionProductoXScreenState') {
      return const VisualizacionProductoXScreen();
    }
    if (actualPage == 'ProductosScreenState') return const ProductosScreen();
    return const Center(child: Text("Pantalla desconocida"));
  }

  int _currentIndexFromState(String actualPage) {
    if (actualPage == 'HomeScreenState') return 0;
    if (actualPage == 'InventarioScreenState') return 1;
    if (actualPage == 'InventariosScreenState') return 1;
    if (actualPage == 'InventarioEdicionXScreenState') return 1;
    if (actualPage == 'VisualizacionProductoXScreenState') return 1;
    if (actualPage == 'ProductosScreenState') return 1;
    return 0;
  }

  Widget _floatingMenuButton(String actualPage) {
    if (actualPage == 'HomeScreenState' ||
        actualPage == 'InventarioScreenState') {
      return const FloatingMenuButton(nombresButtons: ['Agregar Inventario']);
    }
    if (actualPage == 'InventariosScreenState') {
      return const FloatingMenuButton(
        nombresButtons: ['Agregar Inventario', 'Eliminar Inventario'],
      );
    }
    if (actualPage == 'InventarioEdicionXScreenState') {
      return const FloatingMenuButton(
        nombresButtons: ['Agregar Producto', 'Eliminar Producto'],
      );
    }
    if (actualPage == 'VisualizacionProductoXScreenState') {
      return const FloatingMenuButton(
        nombresButtons: ['Agregar Campo', 'Eliminar Campo', 'Modificar Campo'],
      );
    }
    if (actualPage == 'ProductosScreenState') {
      return const FloatingMenuButton(nombresButtons: ['Agregar Inventario']);
    }
    return const FloatingMenuButton(nombresButtons: []);
  }

  Color _colorBackground(String actualPage) {
    if (actualPage == 'NotificacionesScreenState' ||
        actualPage == 'OpcionesScreenState') {
      return Color(0xFF21211F);
    } else {
      return Color(0xFFe8e8e8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final bool showBottomNav = state.showBottomNav;
        final bool showBottomFloatingActionButton =
            state.showBottomFloatingActionButton;
        final String actualPage = state.currentRoute;
        final index = _currentIndexFromState(actualPage);

        final coordinator = InventarioProductoCoordinator(
          context.read<InventarioBloc>(),
          context.read<ProductoBloc>(),
          context.read<NavigationBloc>(),
        );

        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildContent(actualPage),
            ),
            bottomNavigationBar: showBottomNav
                ? BottomNavigationBar(
                    currentIndex: index,
                    backgroundColor: Colors.white,
                    onTap: (i) {
                      if (i == 0) {
                        context.read<NavigationBloc>().add(NavigateToHome());

                        // Eventos de inventario para Homescreen
                        context.read<InventarioBloc>().add(
                          CargarUltimoInventario(),
                        );
                      } else if (i == 1) {
                        // Eventos de inventario para InventarioScreen
                        context.read<InventarioBloc>().add(
                          CargarUltimosTresInventarios(),
                        );

                        coordinator.inventarioScreenCoordinador();
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/img_app_20.png',
                          width: 24,
                          height: 24,
                        ),
                        activeIcon: Image.asset(
                          'assets/images/img_app_21.png',
                          width: 24,
                          height: 24,
                        ),
                        label: 'Inicio',
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          'assets/images/img_app_23.png',
                          width: 24,
                          height: 24,
                        ),
                        activeIcon: Image.asset(
                          'assets/images/img_app_22.png',
                          width: 24,
                          height: 24,
                        ),
                        label: 'Inventario',
                      ),
                    ],
                    selectedItemColor: Color(0xFF4662B2),
                    unselectedItemColor: Colors.black,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                  )
                : null,
            floatingActionButton: showBottomFloatingActionButton
                ? _floatingMenuButton(actualPage)
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            backgroundColor: _colorBackground(actualPage),
          ),
        );
      },
    );
  }
}
