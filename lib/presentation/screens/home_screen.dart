import 'package:app_inventario/presentation/widgets/ultimo_inventario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                'Bienvenido Usuario 1 !',
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
                prev.ultimoInventarioVacio != curr.ultimoInventarioVacio ||
                prev.ultimoInventarioCargando !=
                    curr.ultimoInventarioCargando ||
                prev.ultimoInventarioCargado != curr.ultimoInventarioCargado,
            builder: (context, state) {
              return UltimoInventario(state: state);
            },
          ),
        ],
      ),
    );
  }
}
