import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/controller/controlRuta.dart';

class RegistrarRuta extends StatefulWidget {
  @override
  _RegistrarRutaState createState() => _RegistrarRutaState();
}

class _RegistrarRutaState extends State<RegistrarRuta> {
  List<String> neighborhoods = [];
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController TextNombre = TextEditingController();
  ControladorRuta controlr = ControladorRuta();

  void addNeighborhood() {
    String newNeighborhood = neighborhoodController.text.trim();
    if (newNeighborhood.isNotEmpty) {
      setState(() {
        neighborhoods.add(newNeighborhood);
        neighborhoodController.clear();
      });
    }
  }

  void removeNeighborhood(int index) {
    setState(() {
      neighborhoods.removeAt(index);
    });
  }

  Future<void> saveRoute() async {
    if (TextNombre.text.isNotEmpty && neighborhoods.isNotEmpty) {
      bool success = await controlr.guardarRuta(TextNombre.text, neighborhoods);
      if (success) {
        Get.snackbar(
          'Registro exitoso',
          'La ruta se ha guardado correctamente',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Registro fallido',
          'La ruta no se ha guardado correctamente',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Debe ingresar un nombre de ruta y al menos un barrio',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Ruta'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              saveRoute();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: TextNombre,
              decoration: InputDecoration(
                labelText: 'Nombre de la Ruta',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: neighborhoodController,
              decoration: InputDecoration(
                labelText: 'Barrio',
              ),
              onSubmitted: (_) {
                addNeighborhood();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Aceptar'),
              onPressed: () {
                addNeighborhood();
              },
            ),
            SizedBox(height: 16.0),
            Text(
              'Barrios registrados:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: neighborhoods.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(neighborhoods[index]),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      removeNeighborhood(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: ListTile(
                      title: Text(neighborhoods[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
