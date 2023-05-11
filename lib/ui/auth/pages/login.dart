import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controller/controlUser.dart';

class Login extends StatelessWidget {
  ControlUserAuth controlU = Get.find();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        color: const Color(0xff88d948),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(),
            Flexible(
              child: const Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Flexible(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: controlEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo email@example',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: controlPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await controlU.ingresarUser(
                        controlEmail.toString(), controlPassword.toString());
                    if (controlU.userValido != null) {
                      Get.toNamed('/profile');
                    } else {
                      Get.snackbar('Error', 'Usuario o contraseña incorrectos');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/registrar');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child:
                      const Text('Registrarse', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      )),
    );
  }
}
