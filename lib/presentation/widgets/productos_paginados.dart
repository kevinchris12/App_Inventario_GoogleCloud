import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_state.dart';
import '../../core/utils/inventario_utils.dart';

class ProductosPaginadosWidget extends StatefulWidget {
  final ProductoState state;

  const ProductosPaginadosWidget({super.key, required this.state});

  @override
  State<ProductosPaginadosWidget> createState() =>
      _ProductosPaginadosWidgetState();
}

class _ProductosPaginadosWidgetState extends State<ProductosPaginadosWidget> {
  int currentPage = 1;

  int _limitItemsPerPage() {
    if (context.read<NavigationBloc>().state.currentRoute ==
        'InventarioScreenState') {
      return 5;
    } else {
      return 10;
    }
  }

  Widget _buttonExpand(dynamic screenWidth) {
    if (context.read<NavigationBloc>().state.currentRoute ==
        'InventarioScreenState') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: screenWidth * 0.09,
            height: screenWidth * 0.09,
            color: Color(0xFF21211F),
            child: IconButton(
              icon: Image.asset(
                'assets/images/img_app_38.png',
                width: screenWidth * 0.045,
                height: screenWidth * 0.045,
              ),
              onPressed: () {
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
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double fontsizeButtons = screenWidth * 0.034;
    final double fontsizeTittle = screenWidth * 0.035;

    final state = widget.state;

    final productos = state.productosPaginadosCargados;
    final seleccionados = state.productosSeleccionados;
    final modoSeleccion = state.modoSeleccion;

    final int totalProductos = state.totalProductosEnInventario;

    if (state.productosPaginadosCargando == true) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.productosPaginadosVacios == true) {
      return Center(child: Text("No hay productos registrados"));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buttonExpand(screenWidth),

          Container(
            width: double.infinity,
            //padding: const EdgeInsets.all(8),
            color: Color(0xFF2C2C2A),
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.22,
                  child: Text(
                    'Producto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontsizeTittle,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4662B2),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.2,
                  child: Text(
                    'Categoría',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontsizeTittle,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4662B2),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.16,
                  child: Text(
                    'Cantidad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontsizeTittle,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4662B2),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                  child: Text(
                    'Fecha de Caducidad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontsizeTittle,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4662B2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),

          // 🔹 Listado de productos
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final prod = productos[index];
              final bool isSelected = seleccionados.contains(prod.id);

              return InkWell(
                onLongPress: () {
                  context.read<ProductoBloc>().add(
                    HabilitarSeleccionProducto(prod.id),
                  );
                },
                onTap: () {
                  if (modoSeleccion) {
                    context.read<ProductoBloc>().add(
                      AlternarSeleccionProducto(prod.id),
                    );
                  }
                },
                child: Row(
                  children: [
                    if (modoSeleccion)
                      Icon(
                        seleccionados.contains(prod.id)
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: seleccionados.contains(prod.id)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    SizedBox(width: screenWidth * 0.01),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (!modoSeleccion) {
                            context.read<ProductoBloc>().add(
                              CargarProducto(prod.id),
                            );

                            context.read<InventarioBloc>().add(
                              PublicarInventarioIdInvBloc(
                                context.read<ProductoBloc>().state.inventarioId,
                              ),
                            );

                            context.read<NavigationBloc>().add(
                              NavigateToVisualizacionProductoX(),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.22,
                              child: Text(
                                prod.nombre,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontsizeButtons,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.22,
                              child: Text(
                                prod.categoria ?? 'Sin categoría',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontsizeButtons,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.1,
                              child: Text(
                                prod.cantidad.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontsizeButtons,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.25,
                              child: Text(
                                prod.fechaCaducidad != null
                                    ? formatDate(
                                        prod.fechaCaducidad!,
                                        conHora: false,
                                      )
                                    : 'No Especificado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: fontsizeButtons,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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
                        context.read<ProductoBloc>().add(
                          CargarProductosPaginados(
                            inventarioId: state.inventarioId,
                            limit: _limitItemsPerPage(),
                          ),
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
                        productos.length == _limitItemsPerPage() &&
                        ((totalProductos -
                                (currentPage * _limitItemsPerPage())) >
                            0)
                    ? () {
                        setState(() => currentPage++);
                        context.read<ProductoBloc>().add(
                          CargarProductosPaginados(
                            inventarioId: state.inventarioId,
                            lastDoc: state.lastDoc,
                            limit: _limitItemsPerPage(),
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
