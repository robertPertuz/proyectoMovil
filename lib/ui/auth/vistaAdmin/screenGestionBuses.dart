import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/controller/controlBus.dart';
import 'package:com.proyecto.busmate/domain/models/Bus.dart';

class GestionBuses extends StatefulWidget {
  @override
  _GestionBusesState createState() => _GestionBusesState();
}

class _GestionBusesState extends State<GestionBuses> {
  final ControlBus controlador = Get.put(ControlBus());
  late Future<List<Bus>> _busesFuture;
  List<String> _selectedBuses = [];

  @override
  void initState() {
    super.initState();
    _refreshBuses();
  }

  Future<void> _refreshBuses() async {
    setState(() {
      _busesFuture = controlador.listarBuses();
    });
  }

  void _toggleBusSelection(String placa) {
    setState(() {
      if (_selectedBuses.contains(placa)) {
        _selectedBuses.remove(placa);
      } else {
        _selectedBuses.add(placa);
      }
    });
  }

  Future<void> _eliminarBusesSeleccionados() async {
    for (String placa in _selectedBuses) {
      await controlador.eliminarBus(placa);
    }
    _selectedBuses.clear();
    _refreshBuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Buses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/RegistroBus')!.then((value) {
                if (value != null && value) {
                  _refreshBuses(); // Refresh bus list on successful registration
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed:
                _selectedBuses.isEmpty ? null : _eliminarBusesSeleccionados,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshBuses,
          ),
        ],
      ),
      body: FutureBuilder<List<Bus>>(
        future: _busesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los buses'),
            );
          } else if (snapshot.hasData) {
            final buses = snapshot.data!;

            return ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, index) {
                final bus = buses[index];
                final placa = bus.placa;
                final nombreConductor = bus.conductor.nombre;
                final nombreRuta = bus.ruta.nombre;

                return ListTile(
                  title: Text('Placa: $placa'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Conductor: $nombreConductor'),
                      Text('Ruta: $nombreRuta'),
                    ],
                  ),
                  tileColor:
                      _selectedBuses.contains(placa) ? Colors.grey[200] : null,
                  onTap: () {
                    _toggleBusSelection(placa);
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text('No hay buses disponibles'),
            );
          }
        },
      ),
    );
  }
}
