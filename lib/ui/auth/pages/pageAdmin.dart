import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administración'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/GestionBuses');
                },
                child: Container(
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_bus,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Gestionar Buses',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/GestionConductor');
                },
                child: Container(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Gestionar Conductores',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/GestionRutas');
                },
                child: Container(
                  color: Colors.orange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.map,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Gestionar Rutas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Funcionalidad para reportes
                  // Aquí puedes agregar la navegación o la lógica que desees
                },
                child: Container(
                  color: Colors.purple,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.receipt,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Reportes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
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
