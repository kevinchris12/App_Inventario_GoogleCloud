import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/auth/auth_event.dart';
import '../screens/configuracion_screen.dart';
import 'package:app_inventario/core/utils/navigation_utils.dart';

class OpcionesScreen extends StatelessWidget {
  const OpcionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF21211F),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: AssetImage('assets/images/img_app.png'),
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                  ),
                  SizedBox(width: screenWidth * 0.25),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: screenWidth * 0.09,
                    ),
                    onPressed: () {
                      context.read<NavigationBloc>().add(
                        NavigateToPreviousPage(),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/images/img_user.png'),
                      width: screenWidth * 0.16,
                      height: screenWidth * 0.16,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Text(
                      'Usuario 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.08),
              ListTile(
                leading: Image(
                  image: AssetImage('assets/images/img_app_12.png'),
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
                title: Text(
                  'Productos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                onTap: () {
                  context.read<InventarioBloc>().add(CargarUltimoInventario());

                  context.read<ProductoBloc>().add(
                    CargarProductosPaginados(
                      inventarioId: context
                          .read<InventarioBloc>()
                          .state
                          .ultimoInventarioCargado!
                          .id,
                    ),
                  );

                  context.read<InventarioBloc>().add(
                    PublicarInventarioIdInvBloc(
                      context
                          .read<InventarioBloc>()
                          .state
                          .ultimoInventarioCargado!
                          .id,
                    ),
                  );

                  context.read<NavigationBloc>().add(NavigateToProductos());
                },
              ),
              SizedBox(height: screenHeight * 0.001),
              ListTile(
                leading: Image(
                  image: AssetImage('assets/images/img_app_15.png'),
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
                title: Text(
                  'Configuración',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                onTap: () {
                  navigateWithoutAnimationGlobal(const ConfiguracionScreen());
                },
              ),
              SizedBox(height: screenHeight * 0.001),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                  size: screenWidth * 0.08,
                ),
                title: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                onTap: () {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
