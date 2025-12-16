import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_state.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import 'login_switch_buttons.dart';

class RegisterLayout extends StatelessWidget {
  const RegisterLayout({super.key});

  Widget _buildContent(String actualPage) {
    if (actualPage == 'LoginScreenState') return const LoginScreen();
    if (actualPage == 'RegisterScreenState') return const RegisterScreen();
    return const Center(child: Text("Pantalla de registro desconocida"));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final String actualPage = state.currentRoute;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFe8e8e8),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage('assets/images/img_app.png'),
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  RegisterButtonsRow(),
                  Expanded(child: _buildContent(actualPage)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
