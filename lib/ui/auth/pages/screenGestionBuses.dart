import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GestionBuses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Buses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/RegistroBus');
              // ...
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Lógica para modificar un bus
              // ...
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Lógica para eliminar un bus
              // ...
            },
          ),
        ],
      ),
      body: Container(
        // Contenido de la pantalla de gestión de buses
        child: Text('Aquí va el contenido de la gestión de buses'),
      ),
    );
  }
}
