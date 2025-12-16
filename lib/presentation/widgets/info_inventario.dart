import 'package:flutter/material.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../core/utils/inventario_utils.dart';

class InfoInventario extends StatelessWidget {
  final InventarioState state;

  const InfoInventario({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageSize = screenWidth * 0.15;
    final fontSize = screenWidth * 0.04;

    String nombre = "Negocio 1";
    String fechaCreacion = "No hay información registrada";
    String fechaModificacion = "No hay información registrada";

    if (state.inventarioVacio == true) {
      nombre = 'Negocio 1';
      fechaCreacion = "No hay información registrada";
      fechaModificacion = "No hay información registrada";
    }
    if (state.inventarioCargado != null) {
      nombre = 'Negocio 1';
      final inventario = state.inventarioCargado!;
      fechaCreacion = formatDate(inventario.creadoEn);
      fechaModificacion = formatDate(inventario.actualizadoEn);
    }

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
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
                            TextSpan(text: 'Este inventario se creó el:\n'),
                            TextSpan(
                              text: fechaCreacion,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: fontSize * 0.9,
                          ),
                          children: [
                            TextSpan(text: 'Este inventario se modificó el:\n'),
                            TextSpan(
                              text: fechaModificacion,
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
