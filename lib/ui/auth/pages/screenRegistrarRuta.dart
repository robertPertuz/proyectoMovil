import 'package:flutter/material.dart';

class RegistrarRuta extends StatefulWidget {
  @override
  _RouteRegistrationScreenState createState() =>
      _RouteRegistrationScreenState();
}

class _RouteRegistrationScreenState extends State<RegistrarRuta> {
  List<String> neighborhoods = [];
  TextEditingController neighborhoodController = TextEditingController();

  void addNeighborhood() {
    String newNeighborhood = neighborhoodController.text.trim();
    if (newNeighborhood.isNotEmpty) {
      setState(() {
        neighborhoods.add(newNeighborhood);
        neighborhoodController.clear();
      });
    }
  }

  void saveRoute() {
    // Lógica para guardar la ruta con los barrios registrados
    // ...
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
                  return ListTile(
                    title: Text(neighborhoods[index]),
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
