import 'package:com.proyecto.busmate/domain/controller/controlUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _showPassword = false;
  ControlUserAuth controlU = Get.find();

  final TextEditingController controlEmail = TextEditingController();
  final TextEditingController controlPassword = TextEditingController();
  final TextEditingController controlName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff88d948),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
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
              Flexible(
                child: Text(
                  'Registro de Usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: TextField(
                  controller: controlName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de usuario',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 59, 61, 59)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: TextField(
                  controller: controlEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo electrónico',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 59, 61, 59)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Color(0xFF4CAF50),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: TextField(
                  controller: controlPassword,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 59, 61, 59)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white.withOpacity(0.5)),
                          
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF4CAF50),
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 50),
              Flexible(
                child: ElevatedButton(
                  onPressed: () async {
                    await controlU.crearUser(
                        controlEmail.text, controlPassword.text);
                    await controlU.guardarUsuario(
                        controlName.text, controlEmail.text);
                    if (controlU.userValido != null) {
                      // Mostrar un mensaje de registro exitoso
                      Get.snackbar('Registro exitoso',
                          'El usuario se ha registrado correctamente',
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3));

                      // Redirigir al usuario a la página de inicio
                      Get.toNamed('/login');
                    } else {
                      // Mostrar un mensaje de error de registro
                      Get.snackbar('Error de registro',
                          'No se pudo completar el registro',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3));
                    }
                  },
                  child: Text('Registrarse'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF4CAF50),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: Flexible(
                  child: Text(
                    '¿Ya estás registrado? Inicia sesión',
                    style: TextStyle(color: Colors.white),
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
