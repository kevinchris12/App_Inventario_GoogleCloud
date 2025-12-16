import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Controla la duración del llenado de la barra
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward(); // inicia la animación automáticamente
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFe8e8e8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_app.png',
              width: screenWidth * 0.5,
              height: screenWidth * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.02),

            // Barra de progreso animada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 10,
                  color: Colors.white,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _controller.value, // progreso animado
                        child: Container(color: const Color(0xFF4662B2)),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
