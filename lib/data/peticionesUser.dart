import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Peticioneslogin {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

//Registro Usando Correo Electronico y nombre en BD

  static Future<void> guardarUsuario(String nombre, String correo) async {
    try {
      await firestore.collection('usuarios').add({
        'nombre': nombre,
        'correo': correo,
      });
      print('Datos guardados correctamente');
    } catch (e) {
      print('Error al guardar los datos: $e');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('usuarios').get();
      List<Map<String, dynamic>> usuarios = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return usuarios;
    } catch (e) {
      print('Error al obtener los usuarios: $e');
      return [];
    }
  }

  static Future<dynamic> crearRegistroEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print("funcion " + usuario.toString());
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña Debil');
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya Existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Correo no encontrado');
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Password incorrecto');
        return '2';
      }
    }
  }

  static Future<void> cerrarSesion() async {
    await auth.signOut();
  }
}
