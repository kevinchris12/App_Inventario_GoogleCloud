import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../core/utils/inventario_utils.dart';

class InventariosPaginadosWidget extends StatefulWidget {
  final InventarioState state;

  const InventariosPaginadosWidget({super.key, required this.state});

  @override
  State<InventariosPaginadosWidget> createState() =>
      _InventariosPaginadosWidgetState();
}

class _InventariosPaginadosWidgetState
    extends State<InventariosPaginadosWidget> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final fontsize = screenWidth * 0.04;

    final state = widget.state;

    final inventarios = state.inventariosPaginadosCargados;
    final seleccionados = state.inventariosSeleccionados;
    final modoSeleccion = state.modoSeleccion;

    final int totalInventarios = state.totalInventarios;

    if (state.inventariosPaginadosCargando == true) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.inventariosPaginadosVacios == true) {
      return const Center(child: Text("No hay inventarios registrados"));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          // 🔹 Listado de inventarios
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inventarios.length,
            itemBuilder: (context, index) {
              final inv = inventarios[index];
              final bool isSelected = seleccionados.contains(inv.id);

              return InkWell(
                onLongPress: () {
                  context.read<InventarioBloc>().add(
                    HabilitarSeleccionInventario(inv.id),
                  );
                },
                onTap: () {
                  if (modoSeleccion) {
                    context.read<InventarioBloc>().add(
                      AlternarSeleccionInventario(inv.id),
                    );
                  }
                },
                child: Row(
                  children: [
                    if (modoSeleccion)
                      Icon(
                        seleccionados.contains(inv.id)
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: seleccionados.contains(inv.id)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    SizedBox(width: screenWidth * 0.01),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!modoSeleccion) {
                            context.read<InventarioBloc>().add(
                              CargarInventario(inv.id),
                            );

                            context.read<ProductoBloc>().add(
                              CargarProductosPaginados(inventarioId: inv.id),
                            );

                            context.read<NavigationBloc>().add(
                              NavigateToInventarioEdicionX(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.005,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          alignment: Alignment.center,
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.75,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                inv.nombre,
                                style: TextStyle(
                                  fontSize: fontsize,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Creado: ",
                                      style: TextStyle(
                                        color: Color(0xFF4662B2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontsize * 0.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: formatDate(inv.creadoEn),
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: fontsize * 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Actualizado: ",
                                      style: TextStyle(
                                        color: Color(0xFF4662B2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontsize * 0.8,
                                      ),
                                    ),
                                    TextSpan(
                                      text: formatDate(inv.actualizadoEn),
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: fontsize * 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: screenHeight * 0.005),
          ),

          SizedBox(height: screenHeight * 0.015),

          // 🔹 Flechas para cambiar página
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: currentPage > 1
                    ? () {
                        setState(() => currentPage--);
                        context.read<InventarioBloc>().add(
                          CargarInventariosPaginados(limit: 10),
                        );
                      }
                    : null,
              ),
              Container(
                width: screenWidth * 0.25,
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  "Página $currentPage",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed:
                    state.lastDoc != null &&
                        inventarios.length == 10 &&
                        ((totalInventarios - (currentPage * 10)) > 0)
                    ? () {
                        setState(() => currentPage++);
                        context.read<InventarioBloc>().add(
                          CargarInventariosPaginados(
                            lastDoc: state.lastDoc,
                            limit: 10,
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
