import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_inventario/presentation/widgets/info_inventario.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_state.dart';
import '../widgets/productos_paginados.dart';

class InventarioEdicionXScreen extends StatelessWidget {
  const InventarioEdicionXScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 30),
                onPressed: () {
                  context.read<NavigationBloc>().add(NavigateToInventarios());
                  context.read<InventarioBloc>().add(CargarUltimoInventario());
                  context.read<InventarioBloc>().add(
                    CargarInventariosPaginados(),
                  );
                },
              ),
            ],
          ),
          BlocBuilder<InventarioBloc, InventarioState>(
            buildWhen: (prev, curr) =>
                prev.inventarioVacio != curr.inventarioVacio ||
                prev.inventarioCargando != curr.inventarioCargando ||
                prev.inventarioCargado != curr.inventarioCargado,
            builder: (context, state) {
              return InfoInventario(state: state);
            },
          ),
          SizedBox(height: screenHeight * 0.01),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Las ',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                TextSpan(
                  text: 'modificaciones realizadas ',
                  style: TextStyle(
                    color: Color(0xFF4662B2),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'actualizarán el inventario general de productos ',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                TextSpan(
                  text: 'automáticamente.',
                  style: TextStyle(
                    color: Color(0xFF4662B2),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          BlocBuilder<ProductoBloc, ProductoState>(
            buildWhen: (prev, curr) =>
                prev.productosPaginadosVacios !=
                    curr.productosPaginadosVacios ||
                prev.productosPaginadosCargando !=
                    curr.productosPaginadosCargando ||
                prev.productosPaginadosCargados !=
                    curr.productosPaginadosCargados ||
                prev.modoSeleccion != curr.modoSeleccion ||
                prev.productosSeleccionados != curr.productosSeleccionados,
            builder: (context, state) {
              return ProductosPaginadosWidget(state: state);
            },
          ),
        ],
      ),
    );
  }
}
