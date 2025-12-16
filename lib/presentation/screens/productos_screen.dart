import 'package:app_inventario/presentation/widgets/ultimo_inventario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_state.dart';
import '../widgets/productos_paginados.dart';
import '../../services/inventario_producto_coordinator.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final coordinator = InventarioProductoCoordinator(
      context.read<InventarioBloc>(),
      context.read<ProductoBloc>(),
      context.read<NavigationBloc>(),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 30),
                onPressed: () {
                  context.read<InventarioBloc>().add(
                    CargarUltimosTresInventarios(),
                  );

                  coordinator.inventarioScreenCoordinador();
                },
              ),
            ],
          ),
          BlocBuilder<InventarioBloc, InventarioState>(
            buildWhen: (prev, curr) =>
                prev.ultimoInventarioVacio != curr.ultimoInventarioVacio ||
                prev.ultimoInventarioCargando !=
                    curr.ultimoInventarioCargando ||
                prev.ultimoInventarioCargado != curr.ultimoInventarioCargado,
            builder: (context, state) {
              return UltimoInventario(state: state);
            },
          ),
          SizedBox(height: screenHeight * 0.005),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Todos los productos existentes ',
                  style: TextStyle(
                    color: Color(0xFF4662B2),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'se mostrarán aquí.',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: screenWidth * 0.035,
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
