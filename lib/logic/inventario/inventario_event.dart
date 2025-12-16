import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class InventarioEvent extends Equatable {
  const InventarioEvent();

  @override
  List<Object?> get props => [];
}

/// Almacenar inventario ID
class PublicarInventarioIdInvBloc extends InventarioEvent {
  final String? invCargadoId;
  const PublicarInventarioIdInvBloc(this.invCargadoId);

  @override
  List<Object?> get props => [invCargadoId];
}

/// Cargar inventarios
class CargarUltimoInventario extends InventarioEvent {}

class CargarUltimosTresInventarios extends InventarioEvent {}

class CargarInventariosPaginados extends InventarioEvent {
  final DocumentSnapshot? lastDoc;
  final int limit;

  const CargarInventariosPaginados({this.lastDoc, this.limit = 10});
}

class CargarInventario extends InventarioEvent {
  final String? id;
  const CargarInventario(this.id);

  @override
  List<Object?> get props => [id];
}

/// Agregar inventarios
class AgregarInventario extends InventarioEvent {
  const AgregarInventario();

  @override
  List<Object?> get props => [];
}

/// Eliminar inventarios
class EliminarInventariosSeleccionados extends InventarioEvent {}

class HabilitarSeleccionInventario extends InventarioEvent {
  final String id;
  const HabilitarSeleccionInventario(this.id);
}

class AlternarSeleccionInventario extends InventarioEvent {
  final String id;
  const AlternarSeleccionInventario(this.id);
}

/// Modificar inventarios
class ActualizarInventario extends InventarioEvent {
  const ActualizarInventario();

  @override
  List<Object?> get props => [];
}
