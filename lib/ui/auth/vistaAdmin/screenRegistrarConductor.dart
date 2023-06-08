import 'package:com.proyecto.busmate/domain/controller/controlConductor.dart';
import 'package:com.proyecto.busmate/domain/models/conductor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroConductor extends StatefulWidget {
  @override
  _RegistrarRutaState createState() => _RegistrarRutaState();
}

class _RegistrarRutaState extends State<RegistroConductor> {
  TextEditingController TextCedula = TextEditingController();
  TextEditingController TextNombre = TextEditingController();
  TextEditingController TextTelefono = TextEditingController();
  ControladorConductor controlc = ControladorConductor();
  Conductor conductor = Conductor(cedula: '', nombre: '', telefono: '');

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
              controller: TextCedula,
              decoration: InputDecoration(
                labelText: 'Cedula',
              ),
            ),
            TextField(
              controller: TextNombre,
              decoration: InputDecoration(
                labelText: 'Nombre del Conductor',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: TextTelefono,
              decoration: InputDecoration(
                labelText: 'Telefono',
              ),
              onSubmitted: (_) {},
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Guardar'),
              onPressed: () async {
                conductor.cedula = TextCedula.text;
                conductor.nombre = TextNombre.text;
                conductor.telefono = TextTelefono.text;
                bool exito = await controlc.guardarConductor(conductor);
                if (exito) {
                  Get.snackbar(
                    'Registro exitoso',
                    'El conductor se ha guardado correctamente',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: Duration(seconds: 3),
                  );
                  TextCedula.clear();
                  TextNombre.clear();
                  TextTelefono.clear();
                } else {
                  Get.snackbar(
                    'Error',
                    'No se pudo guardar el conductor',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: Duration(seconds: 3),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
