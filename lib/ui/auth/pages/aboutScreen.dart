import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Aplicación de Geolocalización del Transporte Público en Valledupar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Descripción:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Esta aplicación te permite localizar en tiempo real los diferentes medios de transporte público en Valledupar. '
              'Podrás ver las rutas, calcular tarifas, realizar pagos, enviar sugerencias y acceder a tu historial de viajes.',
            ),
            SizedBox(height: 16),
            Text(
              'Creadores:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Roberts Pertuz'),
            Text('Nemer Velandia'),
            SizedBox(height: 16),
            Text(
              'Funciones principales:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
                '• Pagos: Realiza pagos seguros y convenientes desde la aplicación.'),
            Text(
                '• Rutas: Explora las diferentes rutas de transporte público disponibles en Valledupar.'),
            Text(
                '• Sugerencias: Envía tus sugerencias y comentarios para mejorar la experiencia.'),
            Text(
                '• Historial: Accede a tu historial de viajes y revisa los detalles de tus desplazamientos.'),
            SizedBox(height: 16),
            Text(
              'Universidad Popular del Cesar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
