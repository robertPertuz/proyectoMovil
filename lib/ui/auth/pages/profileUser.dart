import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controller/controlUser.dart';

class Profile extends StatelessWidget {
  final ControlUserAuth _authController = Get.find<ControlUserAuth>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Nombre'),
              accountEmail: Text('Correo'),
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
}
