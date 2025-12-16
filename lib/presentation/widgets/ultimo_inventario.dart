import 'package:flutter/material.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../core/utils/inventario_utils.dart';

class UltimoInventario extends StatelessWidget {
  final InventarioState state;

  const UltimoInventario({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageSize = screenWidth * 0.15;
    final fontSize = screenWidth * 0.04;

    String nombre = "Negocio 1";
    String fecha = "No hay inventarios registrados";

    if (state.ultimoInventarioVacio == true) {
      nombre = 'Negocio 1';
      fecha = 'No hay inventarios registrados';
    }
    if (state.ultimoInventarioCargado != null) {
      nombre = 'Negocio 1';
      final ultimoInventario = state.ultimoInventarioCargado!;
      fecha = formatDate(ultimoInventario.creadoEn);
    }

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: screenWidth * 0.04),
                  child: Image.asset(
                    'assets/images/lista.png',
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.9,
                          ),
                          children: [
                            TextSpan(text: 'Último Inventario realizado:\n'),
                            TextSpan(
                              text: fecha,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
