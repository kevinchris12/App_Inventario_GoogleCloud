import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/product_model.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object?> get props => [];
}

/// Agregar producto
class AgregarProducto extends ProductoEvent {
  const AgregarProducto();
}

/// Almacenar inventario ID
class PublicarInventarioId extends ProductoEvent {
  final String? inventarioId;
  const PublicarInventarioId(this.inventarioId);

  @override
  List<Object?> get props => [inventarioId];
}

/// Cargar productos
class CargarProductosPaginados extends ProductoEvent {
  final String? inventarioId;
  final DocumentSnapshot? lastDoc;
  final int limit;

  const CargarProductosPaginados({
    required this.inventarioId,
    this.lastDoc,
    this.limit = 10,
  });
}

class CargarProducto extends ProductoEvent {
  final String? prodId;
  const CargarProducto(this.prodId);

  @override
  List<Object?> get props => [prodId];
}

/// Eliminar productos
class EliminarProductosSeleccionados extends ProductoEvent {}

class HabilitarSeleccionProducto extends ProductoEvent {
  final String id;
  const HabilitarSeleccionProducto(this.id);
}

class AlternarSeleccionProducto extends ProductoEvent {
  final String id;
  const AlternarSeleccionProducto(this.id);
}

/// Actualizar campos de un producto
class ActualizarCampos extends ProductoEvent {
  final Product producto;
  final Map<String, dynamic> nuevosValores;

  const ActualizarCampos({required this.producto, required this.nuevosValores});
}
