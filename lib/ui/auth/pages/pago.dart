import 'package:com.proyecto.busmate/ui/auth/pages/profileUser.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/controller/gestionPago.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String _qrText = ' ';
  int _ticketCount = 1;
  bool isScanningEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Saldo disponible: \$',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Cantidad de pasajes: $_ticketCount',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_ticketCount > 1) {
                      _ticketCount--;
                    }
                  });
                },
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _ticketCount++;
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    final gestionPago firebaseService = gestionPago();

    controller.scannedDataStream.listen((scanData) async {
      if (isScanningEnabled) {
        setState(() {
          _qrText = scanData.code!;
          isScanningEnabled = false;
        });

        final User? currentUser = await firebaseService.getCurrentUser();
        if (currentUser != null) {
          final String userEmail = currentUser.email!;
          final double newBalance = 2000.0;

          // Llamar al método para actualizar el saldo
          firebaseService.updateBalance(userEmail, newBalance);
          _showPaymentSuccessMessage();
        }
      }
    });
  }

  void _showPaymentSuccessMessage() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Pago Exitoso'),
            content: Text('El pago se ha realizado con éxito.'),
            actions: [
              TextButton(
                onPressed: () {
                  if (mounted) {
                    setState(() {
                      isScanningEnabled = true;
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Profile()),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
