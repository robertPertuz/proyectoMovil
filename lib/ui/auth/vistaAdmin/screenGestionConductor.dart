import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/controller/controlConductor.dart';

import '../../../domain/models/conductor.dart';

class GestionConductores extends StatefulWidget {
  @override
  _GestionConductoresState createState() => _GestionConductoresState();
}

class _GestionConductoresState extends State<GestionConductores> {
  final ControladorConductor controlador = Get.put(ControladorConductor());
  late Future<List<Conductor>?> _conductoresFuture;
  List<String> _selectedConductores = [];

  @override
  void initState() {
    super.initState();
    _conductoresFuture = controlador.obtenerConductores();
  }

  Future<void> _refreshConductores() async {
    setState(() {
      _conductoresFuture = controlador.obtenerConductores();
    });
  }

  void _toggleConductorSelection(String conductorId) {
    setState(() {
      if (_selectedConductores.contains(conductorId)) {
        _selectedConductores.remove(conductorId);
      } else {
        _selectedConductores.add(conductorId);
      }
    });
  }

  Future<void> _eliminarConductoresSeleccionados() async {
    for (String conductorId in _selectedConductores) {
      await controlador.eliminarConductor(conductorId);
    }
    _selectedConductores.clear();
    _refreshConductores();
  }

  Future<void> _actualizarConductores() async {
    await controlador.obtenerConductores();
    _refreshConductores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Conductores'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/RegistroConductor')!.then((value) {
                if (value != null && value) {
                  _refreshConductores(); // Refresh conductor list on successful registration
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _selectedConductores.isEmpty
                ? null
                : _eliminarConductoresSeleccionados,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _actualizarConductores,
          ),
        ],
      ),
      body: FutureBuilder<List<Conductor>?>(
        future: _conductoresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los conductores'),
            );
          } else if (snapshot.hasData) {
            final conductores = snapshot.data!;

            return ListView.builder(
              itemCount: conductores.length,
              itemBuilder: (context, index) {
                final conductor = conductores[index];
                final nombre = conductor.nombre;
                final telefono = conductor.telefono;
                final cedula = conductor.cedula;

                return Container(
                  color: _selectedConductores.contains(cedula)
                      ? Colors.grey[200]
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(nombre),
                    subtitle: Text(telefono),
                    tileColor: _selectedConductores.contains(cedula)
                        ? Colors.grey[200]
                        : null,
                    onTap: () {
                      _toggleConductorSelection(cedula);
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No hay conductores disponibles'),
            );
          }
        },
      ),
    );
  }
}
