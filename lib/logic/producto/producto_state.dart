import 'package:equatable/equatable.dart';
import '../../models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductoState extends Equatable {
  /// Estados para indicar un exito o error en las operaciones
  final String? mensajeError;
  final String? mensajeExito;

  /// Estados para almacenar el ID del inventario cargado
  final String? inventarioId;

  /// Estado para almacenar el total de productos en el inventario cargado
  final int totalProductosEnInventario;

  /// Estados para leer todos los productos de un inventario, paginados
  final List<Product> productosPaginadosCargados;
  final DocumentSnapshot? lastDoc;
  final bool productosPaginadosCargando;
  final bool productosPaginadosVacios;

  /// Estados para eliminar productos de un inventario
  final List<String> productosSeleccionados;
  final bool modoSeleccion;

  /// Estados para obtener un producto especifico
  final Product? productoCargado;
  final bool productoCargando;
  final bool productoVacio;

  /// Estados para almacenar el ID del producto cargado
  final String? productoId;

  const ProductoState({
    this.mensajeError,
    this.mensajeExito,

    this.inventarioId,

    this.totalProductosEnInventario = 0,

    this.productosPaginadosCargados = const [],
    this.lastDoc,
    this.productosPaginadosCargando = false,
    this.productosPaginadosVacios = false,

    this.productosSeleccionados = const [],
    this.modoSeleccion = false,

    this.productoCargado,
    this.productoCargando = false,
    this.productoVacio = false,

    this.productoId,
  });

  /// Estado inicial
  factory ProductoState.inicial() => const ProductoState();

  ProductoState copyWith({
    /// Estados para indicar un exito o error en las operaciones
    String? mensajeError,
    String? mensajeExito,

    /// Estados para almacenar el ID del inventario cargado
    String? inventarioId,

    int? totalProductosEnInventario,

    /// Estados para leer todos los productos de un inventario, paginados
    List<Product>? productosPaginadosCargados,
    DocumentSnapshot? lastDoc,
    bool? productosPaginadosCargando,
    bool? productosPaginadosVacios,

    List<String>? productosSeleccionados,
    bool? modoSeleccion,

    Product? productoCargado,
    bool? productoCargando,
    bool? productoVacio,

    String? productoId,
  }) {
    return ProductoState(
      mensajeError: mensajeError,
      mensajeExito: mensajeExito,

      inventarioId: inventarioId,

      totalProductosEnInventario:
          totalProductosEnInventario ?? this.totalProductosEnInventario,

      productosPaginadosCargados:
          productosPaginadosCargados ?? this.productosPaginadosCargados,
      lastDoc: lastDoc ?? this.lastDoc,
      productosPaginadosCargando:
          productosPaginadosCargando ?? this.productosPaginadosCargando,
      productosPaginadosVacios:
          productosPaginadosVacios ?? this.productosPaginadosVacios,

      productosSeleccionados:
          productosSeleccionados ?? this.productosSeleccionados,
      modoSeleccion: modoSeleccion ?? this.modoSeleccion,

      productoCargado: productoCargado ?? this.productoCargado,
      productoCargando: productoCargando ?? this.productoCargando,
      productoVacio: productoVacio ?? this.productoVacio,

      productoId: productoId ?? this.productoId,
    );
  }

  @override
  List<Object?> get props => [
    mensajeError,
    mensajeExito,

    inventarioId,

    totalProductosEnInventario,

    productosPaginadosCargados,
    lastDoc,
    productosPaginadosCargando,
    productosPaginadosVacios,

    productosSeleccionados,
    modoSeleccion,

    productoCargado,
    productoCargando,
    productoVacio,

    productoId,
  ];
}
