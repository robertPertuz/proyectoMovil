import 'package:flutter/material.dart';

class RegistrarBus extends StatefulWidget {
  @override
  _BusRegistrationScreenState createState() => _BusRegistrationScreenState();
}

class _BusRegistrationScreenState extends State<RegistrarBus> {
  String? selectedRoute; // Cambiado a nullable
  String? selectedDriver; // Cambiado a nullable
  TextEditingController _plateController = TextEditingController();

  List<String> routes = [
    'Ruta 1',
    'Ruta 2',
    'Ruta 3',
    // Agrega las rutas que desees
  ];

  List<String> drivers = [
    'Conductor 1',
    'Conductor 2',
    'Conductor 3',
    // Agrega los conductores que desees
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Bus'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _plateController,
              decoration: InputDecoration(
                labelText: 'Placa del Bus',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedRoute,
              onChanged: (newValue) {
                setState(() {
                  selectedRoute = newValue;
                });
              },
              items: routes.map((route) {
                return DropdownMenuItem<String>(
                  value: route,
                  child: Text(route),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Ruta',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedDriver,
              onChanged: (newValue) {
                setState(() {
                  selectedDriver = newValue;
                });
              },
              items: drivers.map((driver) {
                return DropdownMenuItem<String>(
                  value: driver,
                  child: Text(driver),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Conductor',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                saveBus();
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  void saveBus() {
    String plate = _plateController.text;
    // Guardar los datos del bus en la base de datos u otra acción necesaria
  }
}
