import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controller/controlUser.dart';

class Saldo extends StatelessWidget {
  final controlU = Get.find<ControlUserAuth>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saldo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final saldo = controlU.saldo.value;
              return Text(
                'Saldo actual: \$${saldo.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              );
            }),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showRecargarBottomSheet(context);
              },
              child: Text('Recargar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecargarBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Recargar saldo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Valor',
                  hintText: 'Ingrese el valor a recargar',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Flexible(
                child: ElevatedButton(
                  onPressed: () async {
                    await controlU.recargarSaldo(double.parse(controller.text));
                    controlU
                        .updateSaldo(); // Actualiza el saldo después de la recarga
                    Navigator.pop(context);
                    controller.clear();
                  },
                  child: Text('Recargar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
