import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../logic/producto/producto_state.dart';
import '../widgets/campos_producto.dart';

class VisualizacionProductoXScreen extends StatelessWidget {
  const VisualizacionProductoXScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Image(
                  image: AssetImage('assets/images/img_app_31.png'),
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
                onPressed: () {},
              ),
              Image(
                image: AssetImage('assets/images/img_app.png'),
                width: screenWidth * 0.15,
                height: screenWidth * 0.15,
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: screenWidth * 0.09,
                ),
                onPressed: () {
                  context.read<InventarioBloc>().add(
                    CargarInventario(
                      context.read<InventarioBloc>().state.invCargadoId,
                    ),
                  );

                  context.read<ProductoBloc>().add(
                    CargarProductosPaginados(
                      inventarioId: context
                          .read<InventarioBloc>()
                          .state
                          .invCargadoId,
                    ),
                  );

                  context.read<NavigationBloc>().add(
                    NavigateToInventarioEdicionX(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Puedes tomar ',
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                TextSpan(
                  text: 'fotos o videos ',
                  style: TextStyle(
                    color: Color(0xFF4662B2),
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'del producto para obtener sus datos ',
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
                prev.productoCargando != curr.productoCargando ||
                prev.productoCargado != curr.productoCargado,
            builder: (context, state) {
              return CamposProductoWidget(state: state);
            },
          ),
        ],
      ),
    );
  }
}
