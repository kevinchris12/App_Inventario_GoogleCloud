import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'logic/auth/auth_bloc.dart';
import 'logic/auth/auth_event.dart';
import 'services/firebase_auth_service.dart';
import 'presentation/widgets/app_view.dart';
import '../../logic/navigation/navigation_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // services
        RepositoryProvider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(context.read<FirebaseAuthService>())
                  ..add(AuthCheckRequested()),
          ),
          BlocProvider<NavigationBloc>(create: (_) => NavigationBloc()),
        ],
        child: const AppView(),
      ),
    );
  }
}
