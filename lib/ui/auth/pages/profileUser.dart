import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/controller/controlUser.dart';

class Profile extends StatelessWidget {
  final ControlUserAuth _authController = Get.find<ControlUserAuth>();
  final TextEditingController _codeController = TextEditingController();
  final String correctCode = '888777999';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Obx(() {
                final user = _authController.loggedInUser.value;
                return user != null ? Text(user.nombre) : const Text('');
              }),
              accountEmail: Obx(() {
                final user = _authController.loggedInUser.value;
                return user != null ? Text(user.email) : const Text('');
              }),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('A'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de BusMate'),
              onTap: () {
                Get.toNamed('/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () async {
                await _authController.cerrarSesion();
                Get.offAllNamed('/login');
              },
            ),
            ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Modo Administrador'),
                subtitle: const Text('Requiere codigo de acceso'),
                onTap: () {
                  _showAccessCodeDialog(context);
                })
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bienvenido a BusMate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/ruta');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.bus_alert_outlined,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Rutas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/pago');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.monetization_on,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Pagos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/historial');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.history,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Historial',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sugerencias');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.purple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.tips_and_updates,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Sugerencias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAccessCodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el código de acceso'),
          content: TextField(
            obscureText: true,
            controller: _codeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(hintText: 'Código'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                String enteredCode = _codeController.text.trim();
                if (enteredCode == correctCode) {
                  Navigator.of(context).pop(); // Cerrar el cuadro de diálogo
                  Get.toNamed('/admin');
                  _codeController
                      .clear(); // Navegar a la pantalla del modo administrador
                } else {
                  // Mostrar una alerta de código incorrecto
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Código incorrecto'),
                        content: Text('Por favor, inténtelo de nuevo.'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _codeController.clear();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
