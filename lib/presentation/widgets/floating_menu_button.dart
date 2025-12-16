import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../services/inventario_producto_coordinator.dart';

class FloatingMenuButton extends StatelessWidget {
  final List<String> nombresButtons;

  const FloatingMenuButton({super.key, required this.nombresButtons});

  int colorButton(String nombre) {
    if (nombre == 'Agregar Inventario' ||
        nombre == 'Agregar Producto' ||
        nombre == 'Agregar Campo') {
      return 0xFF4662B2;
    } else if (nombre == 'Eliminar Inventario' ||
        nombre == 'Eliminar Producto' ||
        nombre == 'Eliminar Campo') {
      return 0xFF762730;
    } else if (nombre == 'Modificar Campo') {
      return 0xFF645A96;
    } else {
      return 0xFF4662B2; // Color por defecto
    }
  }

  void actionButton(String nombre, BuildContext context) {
    final coordinator = InventarioProductoCoordinator(
      context.read<InventarioBloc>(),
      context.read<ProductoBloc>(),
      context.read<NavigationBloc>(),
    );

    if (nombre == 'Agregar Inventario') {
      coordinator.agregarInventarioCoordinador();

      context.read<NavigationBloc>().add(NavigateToInventarioEdicionX());
    }
    if (nombre == 'Eliminar Inventario') {
      // Elimina un conjunto de inventarios seleccionados
      context.read<InventarioBloc>().add(EliminarInventariosSeleccionados());
    }
    if (nombre == 'Agregar Producto') {
      coordinator.agregarProductoCoordinador();

      context.read<NavigationBloc>().add(NavigateToVisualizacionProductoX());
    }
    if (nombre == 'Eliminar Producto') {
      coordinator.eliminarProductoCoordinador();
    }
  }

  List<SpeedDialChild> _buildDialChildren(
    List<String> nombres,
    BuildContext context,
  ) {
    return List.generate(nombres.length, (index) {
      final nombre = nombres[index];
      final colorbutton = colorButton(nombre);
      return SpeedDialChild(
        label: nombre,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Color(colorbutton),
          fontWeight: FontWeight.bold,
        ),
        labelBackgroundColor: const Color(0xFF21211F),
        onTap: () {
          actionButton(nombre, context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      backgroundColor: const Color(0xFF21211F),
      foregroundColor: const Color(0xFF4662B2),
      spacing: 1,
      spaceBetweenChildren: 0,
      overlayColor: Colors.black,
      overlayOpacity: 0.3,
      curve: Curves.easeInOut,
      children: _buildDialChildren(nombresButtons, context),
      child: Image.asset('assets/images/img_app_28.png', fit: BoxFit.contain),
    );
  }
}
