import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../data/peticionesUser.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUser(String email, String pass) async {
    _response.value = await Peticioneslogin.crearRegistroEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> ingresarUser(String email, String pass) async {
    _response.value = await Peticioneslogin.ingresarEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No Se Completo la Consulta";
    } else if (respuesta == "1") {
      _mensaje.value = "Correo no encontrado'";
    } else if (respuesta == "2") {
      _mensaje.value = "Password incorrecto";
    } else {
      _mensaje.value = "Proceso Realizado Correctamente";
      _usuario.value = respuesta;
    }
  }
    Future<void> cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    _response.value = null;
    _mensaje.value = 'Sesión cerrada correctamente';
    _usuario.value = null;
  }

  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _usuario.value;
}
