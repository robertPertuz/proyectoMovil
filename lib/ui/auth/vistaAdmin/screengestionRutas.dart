import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/controller/controlRuta.dart';

import '../../../domain/models/Ruta.dart';

class GestionRutas extends StatefulWidget {
  @override
  _GestionRutasState createState() => _GestionRutasState();
}

class _GestionRutasState extends State<GestionRutas> {
  final ControladorRuta controlador = Get.put(ControladorRuta());
  late Future<List<Ruta>> _rutasFuture;
  List<String> _selectedRutas = [];

  @override
  void initState() {
    super.initState();
    _rutasFuture = controlador.obtenerRutas();
  }

  Future<void> _refreshRutas() async {
    setState(() {
      _rutasFuture = controlador.obtenerRutas();
    });
  }

  void _toggleRutaSelection(String nombre) {
    setState(() {
      if (_selectedRutas.contains(nombre)) {
        _selectedRutas.remove(nombre);
      } else {
        _selectedRutas.add(nombre);
      }
    });
  }

  Future<void> _eliminarRutasSeleccionadas() async {
    for (String nombre in _selectedRutas) {
      await controlador.eliminarRuta(nombre);
    }
    _selectedRutas.clear();
    _refreshRutas();
  }

  Future<void> _actualizarRutas() async {
    await controlador.obtenerRutas();
    _refreshRutas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Rutas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.toNamed('/RegistroRuta')!.then((value) {
                if (value != null && value) {
                  _refreshRutas(); // Refresh route list on successful registration
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed:
                _selectedRutas.isEmpty ? null : _eliminarRutasSeleccionadas,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _actualizarRutas,
          ),
        ],
      ),
      body: FutureBuilder<List<Ruta>>(
        future: _rutasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar las rutas'),
            );
          } else if (snapshot.hasData) {
            final rutas = snapshot.data!;

            return ListView.builder(
              itemCount: rutas.length,
              itemBuilder: (context, index) {
                final ruta = rutas[index];
                final barrios = ruta.barrios;
                final nombre = ruta.nombre;

                return Container(
                  color: _selectedRutas.contains(nombre)
                      ? Colors.grey[200]
                      : Colors.transparent,
                  child: ListTile(
                    title: Text(nombre),
                    subtitle: Text(barrios.join(', ')),
                    tileColor: _selectedRutas.contains(nombre)
                        ? Colors.grey[200]
                        : null,
                    onTap: () {
                      _toggleRutaSelection(nombre);
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No hay rutas disponibles'),
            );
          }
        },
      ),
    );
  }
}
