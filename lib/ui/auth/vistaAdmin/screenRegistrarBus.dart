import 'package:flutter/material.dart';
import 'package:com.proyecto.busmate/domain/controller/controlRuta.dart';
import 'package:com.proyecto.busmate/domain/controller/controlConductor.dart';
import 'package:com.proyecto.busmate/domain/controller/controlBus.dart';
import 'package:com.proyecto.busmate/domain/models/Ruta.dart';
import 'package:com.proyecto.busmate/domain/models/conductor.dart';
import 'package:com.proyecto.busmate/domain/models/Bus.dart';

class RegistrarBus extends StatefulWidget {
  @override
  _BusRegistrationScreenState createState() => _BusRegistrationScreenState();
}

class _BusRegistrationScreenState extends State<RegistrarBus> {
  Ruta? selectedRoute;
  Conductor? selectedDriver;
  TextEditingController _plateController = TextEditingController();
  final ControladorRuta _controladorRuta = ControladorRuta();
  final ControladorConductor _controladorConductor = ControladorConductor();
  final ControlBus _controlBus = ControlBus();

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
            FutureBuilder<List<Ruta>>(
              future: _controladorRuta.obtenerRutas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al cargar las rutas');
                } else if (snapshot.hasData) {
                  final routes = snapshot.data!;
                  return DropdownButtonFormField<Ruta>(
                    value: selectedRoute,
                    onChanged: (newValue) {
                      setState(() {
                        selectedRoute = newValue;
                      });
                    },
                    items: routes.map((route) {
                      final String nombre = route.nombre;
                      return DropdownMenuItem<Ruta>(
                        value: route,
                        child: Text(nombre),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Ruta',
                    ),
                  );
                } else {
                  return Text('No hay rutas disponibles');
                }
              },
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<Conductor>?>(
              future: _controladorConductor.obtenerConductores(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al cargar los conductores');
                } else if (snapshot.hasData) {
                  final drivers = snapshot.data!;
                  return DropdownButtonFormField<Conductor>(
                    value: selectedDriver,
                    onChanged: (newValue) {
                      setState(() {
                        selectedDriver = newValue;
                      });
                    },
                    items: drivers.map((driver) {
                      final String nombre = driver.nombre;
                      return DropdownMenuItem<Conductor>(
                        value: driver,
                        child: Text(nombre),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Conductor',
                    ),
                  );
                } else {
                  return Text('No hay conductores disponibles');
                }
              },
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
    Ruta? selectedRoute = this.selectedRoute;
    Conductor? selectedDriver = this.selectedDriver;

    if (plate.isNotEmpty && selectedRoute != null && selectedDriver != null) {
      Bus bus = Bus(
        placa: plate,
        ruta: selectedRoute,
        conductor: selectedDriver,
      );

      _controlBus.guardarBus(bus);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Bus guardado'),
            content: Text('El bus se ha guardado correctamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, complete todos los campos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}
