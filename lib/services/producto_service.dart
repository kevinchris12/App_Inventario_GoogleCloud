import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid;

  ProductoService(this.uid);

  CollectionReference<Map<String, dynamic>> productosRef(
    String? inventarioId,
  ) => _db
      .collection('usuarios')
      .doc(uid)
      .collection('inventarios')
      .doc(inventarioId)
      .collection('productos');

  /// 🔹 Crear producto dentro de un inventario
  Future<DocumentReference> crearProducto({
    required String? inventarioId,
  }) async {
    final nombre = 'Producto Nuevo';
    final doc = await _db
        .collection('usuarios')
        .doc(uid)
        .collection('inventarios')
        .doc(inventarioId)
        .get();
    final nombreInventario = doc.data()?['nombre'];

    final data = {
      'nombre': nombre,
      'sku': '',
      'cantidad': 0,
      'categoria': '',
      'fechaCaducidad': null,
      'codigoBarras': '',
      'ultimoInventarioRelacionado': nombreInventario ?? '',
    };

    return await productosRef(inventarioId).add(data);
  }

  /// 🔹 Obtiene producto especifico
  Future<Product?> obtenerProducto(String? id, String? inventarioId) async {
    final doc = await productosRef(inventarioId).doc(id).get();

    return Product.fromDoc(doc);
  }

  /// 🔹 Obtiene conteo total de productos
  Future<int> countProductos({required String inventarioId}) async {
    final query = _db
        .collection('usuarios')
        .doc(uid)
        .collection('inventarios')
        .doc(inventarioId)
        .collection('productos');

    final snapshot = await query.count().get();

    return snapshot.count ?? 0;
  }

  /// 🔹 Obtener productos paginados (10 por página)
  Future<List<Product>> obtenerProductosPaginados({
    required String? inventarioId,
    DocumentSnapshot? lastDoc,
    int limit = 10,
  }) async {
    Query<Map<String, dynamic>> q = productosRef(
      inventarioId,
    ).orderBy('nombre', descending: true).limit(limit);

    if (lastDoc != null) q = q.startAfterDocument(lastDoc);

    final snap = await q.get();

    return snap.docs.map((doc) => Product.fromDoc(doc)).toList();
  }

  /// 🔹 Obtener último DocumentSnapshot para paginación de productos
  Future<DocumentSnapshot?> getLastProductoDoc(List<Product> productos) async {
    if (productos.isEmpty) return null;
    return productos.last.productReference;
  }

  Future<void> eliminarProducto({
    required String? inventarioId,
    required String productoId,
  }) async {
    await productosRef(inventarioId).doc(productoId).delete();
  }

  Future<void> actualizarProducto({
    required String inventarioId,
    required String productoId,
    required Map<String, dynamic> cambios,
  }) async {
    final docRef = productosRef(inventarioId).doc(productoId);
    await docRef.update(cambios);
  }
}
