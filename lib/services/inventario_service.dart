import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/inventario_model.dart';

class InventarioService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String uid;

  InventarioService(this.uid);

  CollectionReference<Map<String, dynamic>> inventariosRef() =>
      _db.collection('usuarios').doc(uid).collection('inventarios');

  /// 🔹 Obtiene conteo total de inventarios
  Future<int> countInventarios() async {
    final query = _db.collection('usuarios').doc(uid).collection('inventarios');

    final snapshot = await query.count().get();

    return snapshot.count ?? 0;
  }

  /// 🔹 Obtiene el último inventario creado
  Future<Inventario?> obtenerUltimoInventario() async {
    final snap = await inventariosRef()
        .orderBy('creadoEn', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;

    return Inventario.fromDoc(snap.docs.first);
  }

  /// 🔹 Obtiene inventario especifico
  Future<Inventario?> obtenerInventario(String? id) async {
    final doc = await inventariosRef().doc(id).get();

    return Inventario.fromDoc(doc);
  }

  /// 🔹 Obtiene los últimos 3 inventarios creados
  Future<List<Inventario>> obtenerUltimosTresInventarios() async {
    final snap = await inventariosRef()
        .orderBy('creadoEn', descending: true)
        .limit(3)
        .get();

    return snap.docs.map((doc) => Inventario.fromDoc(doc)).toList();
  }

  /// 🔹 Paginación de inventarios (10 por página)
  Future<List<Inventario>> obtenerInventariosPaginados({
    DocumentSnapshot? lastDoc,
    int limit = 10,
  }) async {
    Query<Map<String, dynamic>> q = inventariosRef()
        .orderBy('creadoEn', descending: true)
        .limit(limit);
    if (lastDoc != null) q = q.startAfterDocument(lastDoc);
    final snap = await q.get();
    return snap.docs.map((d) => Inventario.fromDoc(d)).toList();
  }

  /// 🔹 Obtiene el DocumentSnapshot del último inventario en una lista
  Future<DocumentSnapshot?> getLastDocOfList(
    List<Inventario> inventarios,
  ) async {
    if (inventarios.isEmpty) return null;
    return inventarios.last.reference; // si tienes referencia guardada
  }

  /// 🔹 Crea un nuevo inventario con nombre consecutivo
  Future<DocumentReference> crearInventario() async {
    // Traer último para calcular siguiente número
    final snap = await inventariosRef()
        .orderBy('creadoEn', descending: true)
        .limit(1)
        .get();

    int siguiente = 1;
    if (snap.docs.isNotEmpty) {
      final ultimo = Inventario.fromDoc(snap.docs.first);
      // Intentamos extraer número si nombre tiene formato "Inventario N"
      final regex = RegExp(r'\d+$');
      final match = regex.firstMatch(ultimo.nombre);
      if (match != null) {
        final num = int.tryParse(match.group(0)!);
        if (num != null) siguiente = num + 1;
      } else {
        // si no coincide, igual incrementamos en 1 a modo seguro
        siguiente = 2;
      }
    }

    final nombre = 'Inventario $siguiente';
    final data = {
      'nombre': nombre,
      'creadoEn': FieldValue.serverTimestamp(),
      'actualizadoEn': FieldValue.serverTimestamp(),
    };

    return await inventariosRef().add(data);
  }

  /// 🔹 Edita un inventario (por ahora solo nombre)
  Future<void> editarInventario(String? id) async {
    await inventariosRef().doc(id).update({
      'actualizadoEn': FieldValue.serverTimestamp(),
    });
  }

  /// Eliminar inventario: borra productos en subcolección y el doc del inventario
  Future<void> eliminarInventario(String id) async {
    final invDoc = inventariosRef().doc(id);
    // eliminar subcolección productos en batch (si hay muchas, mejor usar Cloud Function)
    final productosSnap = await invDoc.collection('productos').get();
    final batch = _db.batch();

    for (final doc in productosSnap.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(invDoc);

    await batch.commit();
  }
}
