import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/navigation/navigation_bloc.dart';
import '../../logic/navigation/navigation_event.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: screenWidth * 0.09,
              ),
              onPressed: () {
                context.read<NavigationBloc>().add(NavigateToPreviousPage());
              },
            ),
            Text(
              'Notificaciones',
              style: TextStyle(
                color: Color(0xFF4662B2),
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image(
              image: AssetImage('assets/images/img_app_15.png'),
              width: screenWidth * 0.08,
              height: screenWidth * 0.08,
            ),
          ],
        ),
        SizedBox(height: screenHeight * 0.01),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: screenWidth * 0.02,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.25,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3D3D3A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Todos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.33,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C2C2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Productos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.22,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C2C2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: Text(
                    'App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.27,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C2C2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Alertas',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color(0xFF3D3D3A),
          child: ListTile(
            title: Text(
              'Notificación 1',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            subtitle: Text(
              'Detalle de la notificación 1. Detalle de la notificación 1. Detalle de la notificación 1.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Color(0xFF3D3D3A),
          child: ListTile(
            title: Text(
              'Notificación 2',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.045,
              ),
            ),
            subtitle: Text(
              'Detalle de la notificación 2. Detalle de la notificación 2.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
