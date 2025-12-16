import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'producto_event.dart';
import 'producto_state.dart';
import '../../services/producto_service.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  final ProductoService _productoService;

  ProductoBloc(this._productoService) : super(ProductoState.inicial()) {
    on<PublicarInventarioId>(_onPublicarInventarioId);
    on<AgregarProducto>(_onAgregarProducto);
    on<CargarProductosPaginados>(_onCargarProductosPaginados);
    on<EliminarProductosSeleccionados>(_onEliminarProductosSeleccionados);
    on<HabilitarSeleccionProducto>(_onHabilitarSeleccionProducto);
    on<AlternarSeleccionProducto>(_onAlternarSeleccionProducto);
    on<CargarProducto>(_onCargarProducto);
    on<ActualizarCampos>(_onActualizarCampos);
  }

  // Publicar ID de inventario cargado
  Future<void> _onPublicarInventarioId(
    PublicarInventarioId event,
    Emitter<ProductoState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          mensajeExito: 'ID de inventario almacenado',
          inventarioId: event.inventarioId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al almacenar id de inventario cargado: $e',
        ),
      );
    }
  }

  // Agregar producto
  Future<void> _onAgregarProducto(
    AgregarProducto event,
    Emitter<ProductoState> emit,
  ) async {
    try {
      final ref = await _productoService.crearProducto(
        inventarioId: state.inventarioId,
      );

      emit(
        state.copyWith(
          mensajeExito: 'Producto creado',
          productoId: ref.id,
          inventarioId: state.inventarioId,
        ),
      );

      add(CargarProducto(ref.id));
    } catch (e) {
      emit(state.copyWith(mensajeError: 'Error al crear: $e'));
    }
  }

  // Obtener productos paginados
  Future<void> _onCargarProductosPaginados(
    CargarProductosPaginados event,
    Emitter<ProductoState> emit,
  ) async {
    emit(
      state.copyWith(
        productosPaginadosCargando: true,
        productosPaginadosVacios: false,
      ),
    );

    try {
      final resultados = await _productoService.obtenerProductosPaginados(
        inventarioId: event.inventarioId,
        lastDoc: event.lastDoc,
        limit: event.limit,
      );

      final totalProductos = await _productoService.countProductos(
        inventarioId: event.inventarioId!,
      );

      if (resultados.isEmpty) {
        emit(
          state.copyWith(
            productosPaginadosVacios: true,
            productosPaginadosCargando: false,
          ),
        );
        return;
      }

      final ultimoDoc = await _productoService.getLastProductoDoc(resultados);

      emit(
        state.copyWith(
          productosPaginadosVacios: false,
          productosPaginadosCargando: false,
          productosPaginadosCargados: resultados,
          lastDoc: ultimoDoc,
          inventarioId: event.inventarioId,
          totalProductosEnInventario: totalProductos,
          mensajeExito: 'Productos paginados cargados',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al paginar inventarios: $e',
          productosPaginadosCargando: false,
        ),
      );
    }
  }

  /// 🔹 Cargar inventario especifico
  Future<void> _onCargarProducto(
    CargarProducto event,
    Emitter<ProductoState> emit,
  ) async {
    emit(
      state.copyWith(
        productoCargando: true,
        productoVacio: false,
        inventarioId: state.inventarioId,
      ),
    );
    try {
      final producto = await _productoService.obtenerProducto(
        event.prodId,
        state.inventarioId,
      );

      if (producto == null) {
        emit(state.copyWith(productoVacio: true, productoCargando: false));
      } else {
        emit(
          state.copyWith(
            productoVacio: false,
            productoCargando: false,
            productoCargado: producto,
            productoId: event.prodId,
            inventarioId: state.inventarioId,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al obtener producto: $e',
          productoCargando: false,
        ),
      );
    }
  }

  Future<void> _onEliminarProductosSeleccionados(
    EliminarProductosSeleccionados event,
    Emitter<ProductoState> emit,
  ) async {
    try {
      final ids = state.productosSeleccionados;

      for (final id in ids) {
        await _productoService.eliminarProducto(
          inventarioId: state.inventarioId,
          productoId: id,
        );
      }

      emit(
        state.copyWith(
          mensajeExito: 'Productos eliminados',
          productosSeleccionados: [],
          modoSeleccion: false,
          inventarioId: state.inventarioId,
        ),
      );

      add(
        CargarProductosPaginados(inventarioId: state.inventarioId),
      ); // Actualizar lista
    } catch (e) {
      emit(state.copyWith(mensajeError: 'Error al eliminar inventarios: $e'));
    }
  }

  Future<void> _onHabilitarSeleccionProducto(
    HabilitarSeleccionProducto event,
    Emitter<ProductoState> emit,
  ) async {
    try {
      final nuevos = List<String>.from(state.productosSeleccionados);
      if (!nuevos.contains(event.id)) nuevos.add(event.id);

      emit(state.copyWith(modoSeleccion: true, productosSeleccionados: nuevos));
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al habilitar seleccion de productos: $e',
        ),
      );
    }
  }

  Future<void> _onAlternarSeleccionProducto(
    AlternarSeleccionProducto event,
    Emitter<ProductoState> emit,
  ) async {
    try {
      final nuevos = List<String>.from(state.productosSeleccionados);

      if (nuevos.contains(event.id)) {
        nuevos.remove(event.id);
      } else {
        nuevos.add(event.id);
      }

      emit(
        state.copyWith(
          modoSeleccion: nuevos.isNotEmpty,
          productosSeleccionados: nuevos,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al alternar seleccion de productos: $e',
        ),
      );
    }
  }

  Future<void> _onActualizarCampos(
    ActualizarCampos event,
    Emitter<ProductoState> emit,
  ) async {
    emit(
      state.copyWith(productoCargando: true, inventarioId: state.inventarioId),
    );

    /// Validaciones tempranas
    final inventarioId = state.inventarioId;
    if (inventarioId == null) {
      emit(
        state.copyWith(
          productoCargando: false,
          mensajeError: 'Inventario no definido.',
        ),
      );
      return;
    }

    try {
      await _productoService.actualizarProducto(
        inventarioId: inventarioId,
        productoId: event.producto.id,
        cambios: event.nuevosValores,
      );

      // Volver a leer el producto actualizado
      final actualizado = await _productoService.obtenerProducto(
        event.producto.id,
        inventarioId,
      );
      emit(
        state.copyWith(
          productoCargando: false,
          productoCargado: actualizado,
          inventarioId: state.inventarioId,
          mensajeExito: 'Producto actualizado correctamente',
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          productoCargando: false,
          mensajeError: 'Error al actualizar producto: $err',
        ),
      );
    }
  }
}
