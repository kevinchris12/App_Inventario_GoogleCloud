import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/auth/auth_bloc.dart';
import '../../logic/auth/auth_state.dart';
import 'dashboard_layout.dart';
import 'register_layout.dart';
import '../screens/loading_screen.dart';
import 'package:app_inventario/core/utils/navigation_utils.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';
import '../../logic/inventario/inventario_bloc.dart';
import '../../logic/inventario/inventario_event.dart';
import '../../logic/producto/producto_bloc.dart';
import '../../services/inventario_service.dart';
import '../../services/producto_service.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(primaryColor: const Color(0xFF4662B2)),
      home: const LoadingScreen(),
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              replaceWithoutAnimationGlobal(
                MultiRepositoryProvider(
                  providers: [
                    RepositoryProvider<InventarioService>(
                      create: (_) => InventarioService(state.userId),
                    ),
                    RepositoryProvider<ProductoService>(
                      create: (_) => ProductoService(state.userId),
                    ),
                  ],
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider<InventarioBloc>(
                        create: (context) =>
                            InventarioBloc(context.read<InventarioService>())
                              ..add(CargarUltimoInventario()),
                      ),
                      BlocProvider<ProductoBloc>(
                        create: (context) =>
                            ProductoBloc(context.read<ProductoService>()),
                      ),
                    ],
                    child: const DashboardLayout(),
                  ),
                ),
              );

              // Pantalla central del app
              context.read<NavigationBloc>().add(NavigateToHome());
            } else if (state is AuthUnauthenticated || state is AuthError) {
              // Vuelve a la pantalla de login
              replaceWithoutAnimationGlobal(const RegisterLayout());
              context.read<NavigationBloc>().add(NavigateToLogin());
            }
          },
          child: child,
        );
      },
    );
  }
}
