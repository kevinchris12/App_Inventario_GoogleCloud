import 'package:flutter/material.dart';
import 'package:app_inventario/presentation/widgets/app_view.dart';

void navigateWithoutAnimationGlobal(Widget page) {
  /*
Navega a una nueva página sin animación globalmente usando la clave del Navigator.
  [page] — El widget de la pantalla destino.
*/

  AppView.navigatorKey.currentState?.push(
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}

void replaceWithoutAnimationGlobal(Widget page) {
  /*
Reemplaza todas las rutas actuales por una nueva, sin animación.
  [page] — El widget de la pantalla destino.
*/

  AppView.navigatorKey.currentState?.pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
    (route) => false,
  );
}
