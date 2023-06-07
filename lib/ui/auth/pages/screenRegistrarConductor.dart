import 'package:flutter/material.dart';

class RegistroConductor extends StatefulWidget {
  @override
  _RegistrarRutaState createState() => _RegistrarRutaState();
}

class _RegistrarRutaState extends State<RegistroConductor> {
  TextEditingController TextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Conductor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nombre del Conductor',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: TextController,
              decoration: InputDecoration(
                labelText: 'Telefono',
              ),
              onSubmitted: (_) {},
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
