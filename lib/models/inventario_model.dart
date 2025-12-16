import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Inventario extends Equatable {
  final String id;
  final String nombre;
  final DateTime? creadoEn;
  final DateTime? actualizadoEn;
  final DocumentSnapshot? reference;

  const Inventario({
    required this.id,
    required this.nombre,
    this.creadoEn,
    this.actualizadoEn,
    this.reference,
  });

  @override
  List<Object?> get props => [id, nombre, creadoEn, actualizadoEn];

  /// 🔹 Factory para convertir un documento Firestore a modelo
  factory Inventario.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Inventario(
      id: doc.id,
      nombre: data['nombre'] ?? '',
      creadoEn: (data['creadoEn'] as Timestamp?)?.toDate(),
      actualizadoEn: (data['actualizadoEn'] as Timestamp?)?.toDate(),
      reference: doc,
    );
  }
}
