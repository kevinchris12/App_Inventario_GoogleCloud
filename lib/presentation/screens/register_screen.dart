import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/auth/auth_bloc.dart';
import '../../../logic/auth/auth_event.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final fontsize = screenWidth * 0.035;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Crea tu cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ahorra tiempo ',
                      style: TextStyle(
                        color: Color(0xFF4662B2),
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'y realiza inventarios con ',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: fontsize,
                      ),
                    ),
                    TextSpan(
                      text: 'mayor facilidad.',
                      style: TextStyle(
                        color: Color(0xFF4662B2),
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Analiza información ',
                      style: TextStyle(
                        color: Color(0xFF4662B2),
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'de tus inventarios, ',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: fontsize,
                      ),
                    ),
                    TextSpan(
                      text: 'obtén recomendaciones ',
                      style: TextStyle(
                        color: Color(0xFF4662B2),
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'y toma desiciones con ',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: fontsize,
                      ),
                    ),
                    TextSpan(
                      text: 'mayor facilidad.',
                      style: TextStyle(
                        color: Color(0xFF4662B2),
                        fontSize: fontsize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(GoogleSignInRequested());
                },
                icon: Image.asset(
                  'assets/images/img_app_37.png', // logo de Google
                  height: 24,
                  width: 24,
                ),
                label: const Text(
                  'Continuar con Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  elevation: 2,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.black, thickness: 1.5)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('O acceda con'),
                  ),
                  Expanded(child: Divider(color: Colors.black, thickness: 1.5)),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.03),
              GestureDetector(
                onTap: () {
                  context.read<AuthBloc>().add(
                    SignUpRequested(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                    ),
                  );
                },
                child: Container(
                  height: screenHeight * 0.04,
                  width: screenWidth * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF4662B2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: fontsize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
