import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'inventario_event.dart';
import 'inventario_state.dart';
import '../../services/inventario_service.dart';

class InventarioBloc extends Bloc<InventarioEvent, InventarioState> {
  final InventarioService _inventarioService;

  InventarioBloc(this._inventarioService) : super(InventarioState.inicial()) {
    on<CargarUltimoInventario>(_onCargarUltimoInventario);
    on<CargarUltimosTresInventarios>(_onCargarUltimosTresInventarios);
    on<CargarInventariosPaginados>(_onCargarInventariosPaginados);
    on<CargarInventario>(_onCargarInventario);
    on<AgregarInventario>(_onAgregarInventario);
    on<EliminarInventariosSeleccionados>(_onEliminarInventariosSeleccionados);
    on<HabilitarSeleccionInventario>(_onHabilitarSeleccionInventario);
    on<AlternarSeleccionInventario>(_onAlternarSeleccionInventario);
    on<ActualizarInventario>(_onActualizarInventario);
    on<PublicarInventarioIdInvBloc>(_onPublicarInventarioIdInvBloc);
  }

  // Publicar ID de inventario cargado
  Future<void> _onPublicarInventarioIdInvBloc(
    PublicarInventarioIdInvBloc event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          mensajeExito: 'ID de inventario almacenado',
          invCargadoId: event.invCargadoId,
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

  // Obtener inventarios paginados
  Future<void> _onCargarInventariosPaginados(
    CargarInventariosPaginados event,
    Emitter<InventarioState> emit,
  ) async {
    emit(
      state.copyWith(
        inventariosPaginadosCargando: true,
        inventariosPaginadosVacios: false,
      ),
    );

    try {
      final resultados = await _inventarioService.obtenerInventariosPaginados(
        lastDoc: event.lastDoc,
        limit: event.limit,
      );

      final totalInventarios = await _inventarioService.countInventarios();

      if (resultados.isEmpty) {
        emit(
          state.copyWith(
            inventariosPaginadosVacios: true,
            inventariosPaginadosCargando: false,
          ),
        );
        return;
      }

      final ultimoDoc = await _inventarioService.getLastDocOfList(resultados);

      emit(
        state.copyWith(
          inventariosPaginadosVacios: false,
          inventariosPaginadosCargando: false,
          inventariosPaginadosCargados: resultados,
          lastDoc: ultimoDoc,
          totalInventarios: totalInventarios,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al paginar inventarios: $e',
          inventariosPaginadosCargando: false,
        ),
      );
    }
  }

  /// 🔹 Cargar el último inventario
  Future<void> _onCargarUltimoInventario(
    CargarUltimoInventario event,
    Emitter<InventarioState> emit,
  ) async {
    emit(
      state.copyWith(
        ultimoInventarioCargando: true,
        ultimoInventarioVacio: false,
      ),
    );
    try {
      final ultimoInventario = await _inventarioService
          .obtenerUltimoInventario();

      if (ultimoInventario == null) {
        emit(
          state.copyWith(
            ultimoInventarioVacio: true,
            ultimoInventarioCargando: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            ultimoInventarioVacio: false,
            ultimoInventarioCargando: false,
            ultimoInventarioCargado: ultimoInventario,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al obtener último inventario: $e',
          ultimoInventarioCargando: false,
        ),
      );
    }
  }

  /// 🔹 Cargar inventario especifico
  Future<void> _onCargarInventario(
    CargarInventario event,
    Emitter<InventarioState> emit,
  ) async {
    emit(state.copyWith(inventarioCargando: true, inventarioVacio: false));
    try {
      final inventario = await _inventarioService.obtenerInventario(event.id);

      if (inventario == null) {
        emit(state.copyWith(inventarioVacio: true, inventarioCargando: false));
      } else {
        emit(
          state.copyWith(
            inventarioVacio: false,
            inventarioCargando: false,
            inventarioCargado: inventario,
            invCargadoId: event.id,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al obtener inventario: $e',
          inventarioCargando: false,
        ),
      );
    }
  }

  /// 🔹 Cargar los últimos tres inventarios
  Future<void> _onCargarUltimosTresInventarios(
    CargarUltimosTresInventarios event,
    Emitter<InventarioState> emit,
  ) async {
    emit(
      state.copyWith(
        ultimosTresInventariosCargando: true,
        ultimosTresInventariosVacios: false,
      ),
    );

    try {
      final ultimosTresInventarios = await _inventarioService
          .obtenerUltimosTresInventarios();

      if (ultimosTresInventarios.isNotEmpty) {
        emit(
          state.copyWith(
            ultimosTresInventariosVacios: false,
            ultimosTresInventariosCargando: false,
            ultimosTresInventariosCargados: ultimosTresInventarios,
          ),
        );
      } else {
        emit(
          state.copyWith(
            ultimosTresInventariosVacios: true,
            ultimosTresInventariosCargando: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al obtener últimos tres inventarios: $e',
          ultimosTresInventariosCargando: false,
        ),
      );
    }
  }

  // Agregar inventarios
  Future<void> _onAgregarInventario(
    AgregarInventario event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      final ref = await _inventarioService.crearInventario();

      emit(
        state.copyWith(
          mensajeExito: 'Inventario creado correctamente',
          invCargadoId: ref.id,
        ),
      );

      // Refrescando el ultimo inventario
      add(CargarInventario(ref.id));
    } catch (e) {
      emit(state.copyWith(mensajeError: 'Error al crear inventario: $e'));
    }
  }

  Future<void> _onActualizarInventario(
    ActualizarInventario event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      await _inventarioService.editarInventario(state.invCargadoId);

      emit(
        state.copyWith(
          invCargadoId: state.invCargadoId,
          mensajeExito: 'Inventario actualizado correctamente',
        ),
      );
    } catch (e) {
      emit(state.copyWith(mensajeError: 'Error al actualizar inventario: $e'));
    }
  }

  Future<void> _onEliminarInventariosSeleccionados(
    EliminarInventariosSeleccionados event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      final ids = state.inventariosSeleccionados;

      for (final id in ids) {
        await _inventarioService.eliminarInventario(id);
      }

      emit(
        state.copyWith(
          mensajeExito: 'Inventarios eliminados',
          inventariosSeleccionados: [],
          modoSeleccion: false,
        ),
      );

      add(CargarInventariosPaginados()); // Actualizar lista

      // Cargar ultimo inventario
      add(CargarUltimoInventario());
    } catch (e) {
      emit(state.copyWith(mensajeError: 'Error al eliminar inventarios: $e'));
    }
  }

  Future<void> _onHabilitarSeleccionInventario(
    HabilitarSeleccionInventario event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      final nuevos = List<String>.from(state.inventariosSeleccionados);
      if (!nuevos.contains(event.id)) nuevos.add(event.id);

      emit(
        state.copyWith(modoSeleccion: true, inventariosSeleccionados: nuevos),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al habilitar seleccion de inventarios: $e',
        ),
      );
    }
  }

  Future<void> _onAlternarSeleccionInventario(
    AlternarSeleccionInventario event,
    Emitter<InventarioState> emit,
  ) async {
    try {
      final nuevos = List<String>.from(state.inventariosSeleccionados);

      if (nuevos.contains(event.id)) {
        nuevos.remove(event.id);
      } else {
        nuevos.add(event.id);
      }

      emit(
        state.copyWith(
          modoSeleccion: nuevos.isNotEmpty,
          inventariosSeleccionados: nuevos,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mensajeError: 'Error al alternar seleccion de inventarios: $e',
        ),
      );
    }
  }
}
