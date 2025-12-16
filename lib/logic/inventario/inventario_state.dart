import 'package:equatable/equatable.dart';
import '../../models/inventario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InventarioState extends Equatable {
  /// Estados para indicar un exito o error en las operaciones
  final String? mensajeError;
  final String? mensajeExito;

  /// Estado para almacenar el total de inventarios
  final int totalInventarios;

  /// Estados para obtener el ultimo inventario
  final Inventario? ultimoInventarioCargado;
  final bool ultimoInventarioCargando;
  final bool ultimoInventarioVacio;

  /// Estados para obtener los ultimos 3 inventarios
  final List<Inventario> ultimosTresInventariosCargados;
  final bool ultimosTresInventariosCargando;
  final bool ultimosTresInventariosVacios;

  /// Estados para leer todos los inventarios paginados
  final List<Inventario> inventariosPaginadosCargados;
  final DocumentSnapshot? lastDoc;
  final bool inventariosPaginadosCargando;
  final bool inventariosPaginadosVacios;

  /// Estados para obtener un inventario especifico
  final Inventario? inventarioCargado;
  final bool inventarioCargando;
  final bool inventarioVacio;
  final String? invCargadoId;

  /// Estados para eliminar inventarios
  final List<String> inventariosSeleccionados;
  final bool modoSeleccion;

  const InventarioState({
    this.mensajeError,
    this.mensajeExito,

    this.totalInventarios = 0,

    this.ultimoInventarioCargado,
    this.ultimoInventarioCargando = false,
    this.ultimoInventarioVacio = false,

    this.ultimosTresInventariosCargados = const [],
    this.ultimosTresInventariosCargando = false,
    this.ultimosTresInventariosVacios = false,

    this.inventariosPaginadosCargados = const [],
    this.lastDoc,
    this.inventariosPaginadosCargando = false,
    this.inventariosPaginadosVacios = false,

    this.inventarioCargado,
    this.inventarioCargando = false,
    this.inventarioVacio = false,
    this.invCargadoId,

    this.inventariosSeleccionados = const [],
    this.modoSeleccion = false,
  });

  /// Estado inicial
  factory InventarioState.inicial() => const InventarioState();

  /// CopyWith
  InventarioState copyWith({
    String? mensajeError,
    String? mensajeExito,

    int? totalInventarios,

    Inventario? ultimoInventarioCargado,
    bool? ultimoInventarioCargando,
    bool? ultimoInventarioVacio,

    List<Inventario>? ultimosTresInventariosCargados,
    bool? ultimosTresInventariosCargando,
    bool? ultimosTresInventariosVacios,

    List<Inventario>? inventariosPaginadosCargados,
    DocumentSnapshot? lastDoc,
    bool? inventariosPaginadosCargando,
    bool? inventariosPaginadosVacios,

    Inventario? inventarioCargado,
    bool? inventarioCargando,
    bool? inventarioVacio,
    String? invCargadoId,

    List<String>? inventariosSeleccionados,
    bool? modoSeleccion,
  }) {
    return InventarioState(
      mensajeError: mensajeError,
      mensajeExito: mensajeExito,

      totalInventarios: totalInventarios ?? this.totalInventarios,

      ultimoInventarioCargado:
          ultimoInventarioCargado ?? this.ultimoInventarioCargado,
      ultimoInventarioCargando:
          ultimoInventarioCargando ?? this.ultimoInventarioCargando,
      ultimoInventarioVacio:
          ultimoInventarioVacio ?? this.ultimoInventarioVacio,

      ultimosTresInventariosCargados:
          ultimosTresInventariosCargados ?? this.ultimosTresInventariosCargados,
      ultimosTresInventariosCargando:
          ultimosTresInventariosCargando ?? this.ultimosTresInventariosCargando,
      ultimosTresInventariosVacios:
          ultimosTresInventariosVacios ?? this.ultimosTresInventariosVacios,

      inventariosPaginadosCargados:
          inventariosPaginadosCargados ?? this.inventariosPaginadosCargados,
      lastDoc: lastDoc ?? this.lastDoc,
      inventariosPaginadosCargando:
          inventariosPaginadosCargando ?? this.inventariosPaginadosCargando,
      inventariosPaginadosVacios:
          inventariosPaginadosVacios ?? this.inventariosPaginadosVacios,

      inventarioCargado: inventarioCargado ?? this.inventarioCargado,
      inventarioCargando: inventarioCargando ?? this.inventarioCargando,
      inventarioVacio: inventarioVacio ?? this.inventarioVacio,
      invCargadoId: invCargadoId,

      inventariosSeleccionados:
          inventariosSeleccionados ?? this.inventariosSeleccionados,
      modoSeleccion: modoSeleccion ?? this.modoSeleccion,
    );
  }

  @override
  List<Object?> get props => [
    mensajeError,
    mensajeExito,

    totalInventarios,

    ultimoInventarioCargado,
    ultimoInventarioCargando,
    ultimoInventarioVacio,

    ultimosTresInventariosCargados,
    ultimosTresInventariosCargando,
    ultimosTresInventariosVacios,

    inventariosPaginadosCargados,
    lastDoc,
    inventariosPaginadosCargando,
    inventariosPaginadosVacios,

    inventarioCargado,
    inventarioCargando,
    inventarioVacio,
    invCargadoId,

    inventariosSeleccionados,
    modoSeleccion,
  ];
}
