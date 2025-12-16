import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/inventario/inventario_state.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../logic/producto/producto_event.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';

class UltimosTresInventarios extends StatelessWidget {
  final InventarioState state;

  const UltimosTresInventarios({super.key, required this.state});

  /// 🔹 Formato: "[16, Enero, 2025, 6, 28, PM]"
  /// Devuelve una lista con día, mes, año, hora, minutos y periodo
  List _formatDate(DateTime? fecha) {
    if (fecha == null) return ["--", "--", "--", "--", "--", "--"];

    final meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ];

    final dia = fecha.day;
    final mes = meses[fecha.month - 1];
    final anho = fecha.year;

    int hora = fecha.hour;
    final minutos = fecha.minute.toString().padLeft(2, '0');
    final periodo = hora >= 12 ? "PM" : "AM";

    if (hora > 12) hora -= 12;
    if (hora == 0) hora = 12;

    return [dia, mes, anho, hora, minutos, periodo];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final fontsize = screenWidth * 0.035;

    String invId_1 = '';
    String invId_2 = '';
    String invId_3 = '';

    List fechaInventario1 = ["--", "--", "--", "--", "--", "--"];
    List fechaInventario2 = ["--", "--", "--", "--", "--", "--"];
    List fechaInventario3 = ["--", "--", "--", "--", "--", "--"];

    if (state.ultimosTresInventariosCargados.isNotEmpty) {
      int invs = (state.ultimosTresInventariosCargados).length;

      fechaInventario1 = _formatDate(
        (state.ultimosTresInventariosCargados)[0].creadoEn,
      );

      invId_1 = (state.ultimosTresInventariosCargados)[0].id;

      invs = invs - 1;

      if (invs != 0) {
        fechaInventario2 = _formatDate(
          (state.ultimosTresInventariosCargados)[1].creadoEn,
        );

        invId_2 = (state.ultimosTresInventariosCargados)[1].id;

        invs = invs - 1;

        if (invs != 0) {
          fechaInventario3 = _formatDate(
            (state.ultimosTresInventariosCargados)[2].creadoEn,
          );

          invId_3 = (state.ultimosTresInventariosCargados)[2].id;
        }
      }
    }

    return Container(
      width: screenWidth * 0.9,
      height: screenWidth * 0.55,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenWidth * 0.02,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Últimos Inventarios',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<NavigationBloc>().add(NavigateToInventarios());
                  context.read<InventarioBloc>().add(CargarUltimoInventario());
                  context.read<InventarioBloc>().add(
                    CargarInventariosPaginados(),
                  );
                },
                child: Image(
                  image: AssetImage('assets/images/img_app_26.png'),
                  width: screenWidth * 0.05,
                  height: screenWidth * 0.05,
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.02),
          Expanded(
            child: Container(
              color: Color(0xFFe8e8e8),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenWidth * 0.01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.18,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Inventario',
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.12,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Día',
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.16,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Hora',
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.22,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Mes',
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Año',
                              style: TextStyle(
                                fontSize: fontsize,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  GestureDetector(
                    onTap: () {
                      context.read<InventarioBloc>().add(
                        CargarInventario(invId_1),
                      );

                      context.read<ProductoBloc>().add(
                        CargarProductosPaginados(inventarioId: invId_1),
                      );

                      context.read<NavigationBloc>().add(
                        NavigateToInventarioEdicionX(),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 1,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.18,
                            child: Align(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/images/lista.png'),
                                width: screenWidth * 0.07,
                                height: screenWidth * 0.07,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.12,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario1[0].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.16,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${fechaInventario1[3].toString()}:${fechaInventario1[4].toString()} ${fechaInventario1[5].toString()}',
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.22,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario1[1].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario1[2].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  GestureDetector(
                    onTap: () {
                      context.read<InventarioBloc>().add(
                        CargarInventario(invId_2),
                      );

                      context.read<ProductoBloc>().add(
                        CargarProductosPaginados(inventarioId: invId_2),
                      );

                      context.read<NavigationBloc>().add(
                        NavigateToInventarioEdicionX(),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.18,
                            child: Align(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/images/lista.png'),
                                width: screenWidth * 0.07,
                                height: screenWidth * 0.07,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.12,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario2[0].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.16,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${fechaInventario2[3].toString()}:${fechaInventario2[4].toString()} ${fechaInventario2[5].toString()}',
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.22,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario2[1].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario2[2].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  GestureDetector(
                    onTap: () {
                      context.read<InventarioBloc>().add(
                        CargarInventario(invId_3),
                      );

                      context.read<ProductoBloc>().add(
                        CargarProductosPaginados(inventarioId: invId_3),
                      );

                      context.read<NavigationBloc>().add(
                        NavigateToInventarioEdicionX(),
                      );
                    },
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.18,
                            child: Align(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/images/lista.png'),
                                width: screenWidth * 0.07,
                                height: screenWidth * 0.07,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.12,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario3[0].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.16,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '${fechaInventario3[3].toString()}:${fechaInventario3[4].toString()} ${fechaInventario3[5].toString()}',
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.22,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario3[1].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                fechaInventario3[2].toString(),
                                style: TextStyle(
                                  fontSize: fontsize * 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                        ],
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
  }
}
