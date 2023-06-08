import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/models/user.dart';
import '../../data/peticionesUser.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<firebase_auth.UserCredential> _usuario =
      Rxn<firebase_auth.UserCredential>();
  Rx<firebase_auth.User?> currentUser = Rx<firebase_auth.User?>(null);
  final Rx<User?> loggedInUser = Rx<User?>(null);
  RxDouble saldo = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _obtenerDatosUsuario();
  }

  Future<String> recargarSaldo(double cantidad) {
    return Peticioneslogin.recargarSaldo(cantidad);
  }

  Future<void> guardarUsuario(
      String nombre, String correo, double saldo) async {
    await Peticioneslogin.guardarUsuario(nombre, correo, saldo);
  }

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
      _mensaje.value = "No se completó la consulta";
    } else if (respuesta == "1") {
      _mensaje.value = "Correo no encontrado";
    } else if (respuesta == "2") {
      _mensaje.value = "Contraseña incorrecta";
    } else {
      _mensaje.value = "Proceso realizado correctamente";
      _usuario.value = respuesta;
    }
  }

  Future<void> cerrarSesion() async {
    await firebase_auth.FirebaseAuth.instance.signOut();
    _response.value = null;
    _mensaje.value = 'Sesión cerrada correctamente';
    _usuario.value = null;
  }

  // Método para obtener los datos del usuario actualmente autenticado desde Firestore
  Future<void> _obtenerDatosUsuario() async {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userEmail = currentUser.email;
      final usuarios = await Peticioneslogin.obtenerUsuarios();
      final usuarioActual = usuarios.firstWhere(
        (user) => user['correo'] == userEmail,
        orElse: () => {},
      );
      if (usuarioActual != null) {
        final nombre = usuarioActual['nombre'];
        final correo = usuarioActual['correo'];
        final saldo = usuarioActual['saldo'];
        final password = ""; // Recupera la contraseña desde la fuente de datos

        loggedInUser.value = User(
          nombre: nombre,
          email: correo,
          password: password,
          saldo: saldo,
        );
        updateSaldo(); // Actualiza el saldo al obtener los datos del usuario
      }
    }
  }

  void updateSaldo() {
    final loggedInUserValue = loggedInUser.value;
    if (loggedInUserValue != null) {
      saldo.value = loggedInUserValue.saldo ?? 0.0;
    }
  }

  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  firebase_auth.UserCredential? get userValido => _usuario.value;
}
