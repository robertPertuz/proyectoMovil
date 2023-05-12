import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
              leading: const Icon(Icons.bus_alert_outlined),
              title: const Text('Rutas'),
              onTap: () {
                Get.toNamed('/ruta');
              },
            ),
            ListTile(
              leading: const Icon(Icons.money_sharp),
              title: const Text('Pagos'),
              onTap: () {
                Get.toNamed('/pago');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Get.toNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bienvenido a BusMate'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/rutas');
                },
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Rutas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/pagos');
                },
                child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Pagos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/historial');
                },
                child: Container(
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      'Historial',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sugerencias');
                },
                child: Container(
                  color: Colors.purple,
                  child: Center(
                    child: Text(
                      'Cajón de Sugerencias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
