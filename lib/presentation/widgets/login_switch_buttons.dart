import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';

class RegisterButtonsRow extends StatefulWidget {
  const RegisterButtonsRow({super.key});

  @override
  State<RegisterButtonsRow> createState() => _RegisterButtonsRowState();
}

class _RegisterButtonsRowState extends State<RegisterButtonsRow> {
  bool isFirstActive = true;

  void _onFirstButtonPressed() {
    setState(() => isFirstActive = true);
    context.read<NavigationBloc>().add(NavigateToLogin());
  }

  void _onSecondButtonPressed() {
    setState(() => isFirstActive = false);
    context.read<NavigationBloc>().add(NavigateToRegister());
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFFFFFFFF);
    const inactiveColor = Color(0xFFe8e8e8);
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _onFirstButtonPressed();
            },
            child: Container(
              height: screenHeight * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isFirstActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                "Iniciar Sesión",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _onSecondButtonPressed();
            },
            child: Container(
              height: screenHeight * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: !isFirstActive ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text(
                "Registrarse",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
