import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../logic/producto/producto_state.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CamposProductoWidget extends StatefulWidget {
  final ProductoState state;

  const CamposProductoWidget({super.key, required this.state});

  @override
  State<CamposProductoWidget> createState() => _CamposProductoWidgetState();
}

class _CamposProductoWidgetState extends State<CamposProductoWidget> {
  final Map<String, TextEditingController> _controllers = {};
  Map<String, dynamic> _originalValues = {};

  @override
  void initState() {
    super.initState();
    _cargarValoresIniciales();
  }

  @override
  void didUpdateWidget(covariant CamposProductoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.productoCargado != oldWidget.state.productoCargado) {
      _cargarValoresIniciales();
    }
  }

  @override
  void dispose() {
    // Liberar controladores cuando el widget desaparece
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _cargarValoresIniciales() {
    final producto = widget.state.productoCargado;

    if (producto == null) return;

    _originalValues = {
      'sku': producto.sku,
      'nombre': producto.nombre,
      'cantidad': producto.cantidad.toString(),
      'categoria': producto.categoria,
      'fechaCaducidad': producto.fechaCaducidad != null
          ? producto.fechaCaducidad!.toIso8601String().split('T').first
          : "",
      'codigoBarras': producto.codigoBarras,
      'ultimoInventarioRelacionado': producto.ultimoInventarioRelacionado,
    };

    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();

    for (final entry in _originalValues.entries) {
      _controllers[entry.key] = TextEditingController(text: entry.value);
    }

    setState(() {});
  }

  Map<String, dynamic> _obtenerCambios() {
    final cambios = <String, dynamic>{};

    _controllers.forEach((key, controller) {
      final original = _originalValues[key];
      final nuevo = controller.text;

      if (nuevo != original) {
        if (key == 'cantidad') {
          cambios[key] = int.tryParse(nuevo) ?? 0;
        } else if (key == 'fechaCaducidad') {
          if (controller.text.isNotEmpty) {
            cambios[key] = Timestamp.fromDate(DateTime.parse(controller.text));
          }
        } else {
          cambios[key] = nuevo;
        }
      }
    });

    return cambios;
  }

  void _deshacerCambios() {
    for (final entry in _controllers.entries) {
      entry.value.text = _originalValues[entry.key];
    }
    setState(() {});
  }

  List<String> _obtenerTitulosCampos(List<String> campos) {
    for (int i = 0; i < campos.length; i++) {
      if (campos[i] == 'sku') {
        campos[i] = 'SKU';
      } else if (campos[i] == 'nombre') {
        campos[i] = 'Nombre';
      } else if (campos[i] == 'cantidad') {
        campos[i] = 'Cantidad';
      } else if (campos[i] == 'categoria') {
        campos[i] = 'Categoría';
      } else if (campos[i] == 'fechaCaducidad') {
        campos[i] = 'Fecha de Caducidad';
      } else if (campos[i] == 'codigoBarras') {
        campos[i] = 'Código de Barras';
      } else if (campos[i] == 'ultimoInventarioRelacionado') {
        campos[i] = 'Último Inventario Relacionado';
      }
    }
    return campos;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cargando = widget.state.productoCargando;
    final producto = widget.state.productoCargado;
    final campos = _controllers.keys.toList();
    final tituloCampos = _obtenerTitulosCampos(_controllers.keys.toList());
    final fontsize = screenWidth * 0.035;

    if (cargando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (producto == null) {
      return const Center(child: Text("Sin datos del producto"));
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: campos.length,
            itemBuilder: (context, index) {
              final campo = campos[index];
              final tituloCampo = tituloCampos[index];
              final controller = _controllers[campo]!;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: campo == 'ultimoInventarioRelacionado'
                          ? screenWidth * 0.35
                          : screenWidth * 0.2,
                      height: screenHeight * 0.05,
                      alignment: Alignment.center,
                      color: const Color(0xFFFFFFFF),
                      child: Text(
                        tituloCampo,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontsize,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: campo == 'fechaCaducidad'
                          ? TextField(
                              controller: controller,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                final fechaActual =
                                    DateTime.tryParse(controller.text) ??
                                    DateTime.now();

                                final DateTime? nuevaFecha =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: fechaActual,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );

                                if (nuevaFecha != null) {
                                  setState(() {
                                    controller.text = nuevaFecha
                                        .toIso8601String()
                                        .split('T')
                                        .first;
                                  });
                                }
                              },
                            )
                          : TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              );
            },
          ),

          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final cambios = _obtenerCambios();
                      if (cambios.isNotEmpty) {
                        context.read<ProductoBloc>().add(
                          ActualizarCampos(
                            producto: producto,
                            nuevosValores: cambios,
                          ),
                        );

                        // Informar fecha de actualizacion del inventario
                        context.read<InventarioBloc>().add(
                          ActualizarInventario(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF249776),
                    ),
                    child: Text(
                      "Guardar cambios",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: fontsize,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _deshacerCambios,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF762730),
                    ),
                    child: Text(
                      "Deshacer cambios",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: fontsize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
