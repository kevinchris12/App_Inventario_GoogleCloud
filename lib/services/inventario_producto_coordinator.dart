import '../logic/producto/producto_bloc.dart';
import '../logic/producto/producto_event.dart';
import '../logic/inventario/inventario_bloc.dart';
import '../logic/inventario/inventario_event.dart';
import '../logic/navigation/navigation_bloc.dart';
import '../logic/navigation/navigation_event.dart';

class InventarioProductoCoordinator {
  final InventarioBloc inventarioBloc;
  final ProductoBloc productoBloc;
  final NavigationBloc navigationBloc;

  InventarioProductoCoordinator(
    this.inventarioBloc,
    this.productoBloc,
    this.navigationBloc,
  );

  Future<void> agregarInventarioCoordinador() async {
    /// Agregando inventario
    /// luego publicando su Inventario ID en InventarioBloc
    /// CargarInventario(ref.id)
    inventarioBloc.add(AgregarInventario());

    // Esperar el resultado del evento: AgregarInventario
    await inventarioBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'Inventario creado correctamente',
    );

    /// Publicando el Inventario ID en ProductoBloc
    productoBloc.add(PublicarInventarioId(inventarioBloc.state.invCargadoId));

    /// Cargando productos paginados para el inventario creado
    productoBloc.add(
      CargarProductosPaginados(inventarioId: inventarioBloc.state.invCargadoId),
    );
  }

  Future<void> agregarProductoCoordinador() async {
    /// Actualizar fecha de actualizacion del inventario
    /// Luego publicando el Inventario ID en InventarioBloc
    inventarioBloc.add(ActualizarInventario());

    // Esperar el resultado del evento: ActualizarInventario
    await inventarioBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'Inventario actualizado correctamente',
    );

    /// Publicando el Inventario ID en ProductoBloc
    productoBloc.add(PublicarInventarioId(inventarioBloc.state.invCargadoId));

    // Esperar el resultado del evento: PublicarInventarioId
    await productoBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'ID de inventario almacenado',
    );

    /// Agrega un producto
    productoBloc.add(AgregarProducto());
  }

  Future<void> eliminarProductoCoordinador() async {
    /// Actualizar fecha de actualizacion del inventario
    /// Luego publicando el Inventario ID en InventarioBloc
    inventarioBloc.add(ActualizarInventario());

    // Esperar el resultado del evento: ActualizarInventario
    await inventarioBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'Inventario actualizado correctamente',
    );

    /// Publicando el Inventario ID en ProductoBloc
    productoBloc.add(PublicarInventarioId(inventarioBloc.state.invCargadoId));

    // Esperar el resultado del evento: PublicarInventarioId
    await productoBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'ID de inventario almacenado',
    );

    /// Elimina un conjunto de productos seleccionados
    /// luego publicando su Inventario ID en ProductoBloc
    /// CargarProductosPaginados(inventarioId: state.inventarioId),
    productoBloc.add(EliminarProductosSeleccionados());

    // Esperar el resultado del evento: EliminarProductosSeleccionados
    await productoBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'Productos eliminados',
    );

    /// Carga un inventario especifico
    /// luego publicando su Inventario ID en InventarioBloc
    inventarioBloc.add(CargarInventario(inventarioBloc.state.invCargadoId));
  }

  Future<void> inventarioScreenCoordinador() async {
    /// Navegar a InventarioScreen
    navigationBloc.add(NavigateToInventario());

    // Esperar el resultado del evento: CargarProductosPaginados
    await navigationBloc.stream.firstWhere(
      (s) => s.mensajeExito == 'Navigated to Inventario successfully',
    );

    /// Cargar productos paginados para InventarioScreen
    productoBloc.add(
      CargarProductosPaginados(
        inventarioId: inventarioBloc.state.ultimoInventarioCargado!.id,
        limit: 5,
      ),
    );
  }
}
