import 'package:flutter/material.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF21211F),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: screenWidth * 0.09,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.005),
              Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/images/img_app_15.png'),
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Seleccione la ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      TextSpan(
                        text: 'configuración deseada',
                        style: TextStyle(
                          color: Color(0xFF4662B2),
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              ListTile(
                leading: Image(
                  image: AssetImage('assets/images/img_app_15.png'),
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
                title: Text(
                  'Configuración 1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                // onTap: () {},
              ),
              SizedBox(height: screenHeight * 0.001),
              ListTile(
                leading: Image(
                  image: AssetImage('assets/images/img_app_15.png'),
                  width: screenWidth * 0.08,
                  height: screenWidth * 0.08,
                ),
                title: Text(
                  'Configuración 2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                // onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
