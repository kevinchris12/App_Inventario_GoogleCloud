import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String? sku;
  final String nombre;
  final int cantidad;
  final String? categoria;
  final DateTime? fechaCaducidad;
  final String? codigoBarras;
  final String? ultimoInventarioRelacionado;
  final DocumentSnapshot? productReference;

  const Product({
    required this.id,
    required this.nombre,
    required this.cantidad,

    this.sku,
    this.categoria,
    this.fechaCaducidad,
    this.codigoBarras,
    this.ultimoInventarioRelacionado,
    this.productReference,
  });

  @override
  List<Object?> get props => [
    id,
    sku,
    nombre,
    cantidad,
    categoria,
    fechaCaducidad,
    codigoBarras,
    ultimoInventarioRelacionado,
  ];

  /// 🔹 Factory para convertir un documento Firestore a modelo
  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Product(
      id: doc.id,
      sku: data['sku'] ?? '',
      nombre: data['nombre'] ?? '',
      cantidad: (data['cantidad'] ?? 0) as int,
      categoria: data['categoria'] ?? '',
      fechaCaducidad: (data['fechaCaducidad'] as Timestamp?)?.toDate(),
      codigoBarras: data['codigoBarras'] ?? '',
      ultimoInventarioRelacionado: data['ultimoInventarioRelacionado'] ?? '',
      productReference: doc,
    );
  }
}
