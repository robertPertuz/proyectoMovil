import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../domain/controller/controlUser.dart';

class Profile extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();
  final String correctCode = '888777999';

  @override
  Widget build(BuildContext context) {
    final controlU = Get.find<ControlUserAuth>();

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Obx(() {
              final user = controlU.loggedInUser.value;
              return UserAccountsDrawerHeader(
                accountName: Text(user?.nombre ?? ''),
                accountEmail: Text(user?.email ?? ''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    user?.nombre?.substring(0, 1) ?? '',
                    style: const TextStyle(fontSize: 40.0),
                  ),
                ),
              );
            }),
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
                await controlU.cerrarSesion();
                _resetDrawerValues(); // Limpiar valores del Drawer
                Get.offAllNamed('/login');
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Modo Administrador'),
              subtitle: const Text('Requiere código de acceso'),
              onTap: () {
                _showAccessCodeDialog(context);
              },
            ),
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/saldo');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 50,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Saldo',
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
                  _resetDrawerValues(); // Limpiar valores del Drawer
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

  void _resetDrawerValues() {
    _codeController.clear();
  }
}
