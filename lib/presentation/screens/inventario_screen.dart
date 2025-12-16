import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_state.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../widgets/ultimos_3_inventarios.dart';
import '../widgets/productos_paginados.dart';

class InventarioScreen extends StatelessWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  context.read<NavigationBloc>().add(NavigateToOpciones());
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  context.read<NavigationBloc>().add(
                    NavigateToNotificaciones(),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Negocio 1',
                style: TextStyle(
                  color: Color(0xFF4662B2),
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.04,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          BlocBuilder<InventarioBloc, InventarioState>(
            buildWhen: (prev, curr) =>
                prev.ultimosTresInventariosVacios !=
                    curr.ultimosTresInventariosVacios ||
                prev.ultimosTresInventariosCargando !=
                    curr.ultimosTresInventariosCargando ||
                prev.ultimosTresInventariosCargados !=
                    curr.ultimosTresInventariosCargados,
            builder: (context, state) {
              return UltimosTresInventarios(state: state);
            },
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
