import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Peticioneslogin {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Registro Usando Correo Electronico y nombre en BD

  static Future<void> guardarUsuario(
      String nombre, String correo, double d) async {
    try {
      await firestore.collection('usuarios').add({
        'nombre': nombre,
        'correo': correo,
        'saldo': 0.0,
      });
      print('Datos guardados correctamente');
    } catch (e) {
      print('Error al guardar los datos: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerUsuarios() async {
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

  static Future<String> recargarSaldo(double cantidad) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        String correo = currentUser.email!;
        QuerySnapshot snapshot = await firestore
            .collection('usuarios')
            .where('correo', isEqualTo: correo)
            .get();
        if (snapshot.docs.isNotEmpty) {
          String documentId = snapshot.docs.first.id;
          Map<String, dynamic>? userData =
              snapshot.docs.first.data() as Map<String, dynamic>?;
          double saldoActual = userData?['saldo'] ?? 0.0;
          double nuevoSaldo = saldoActual + cantidad;
          await firestore
              .collection('usuarios')
              .doc(documentId)
              .update({'saldo': nuevoSaldo});
          return ('Recarga de saldo realizada correctamente');
        } else {
          return ('No se encontró ningún usuario con el correo proporcionado');
        }
      } else {
        return ('No se ha encontrado ningún usuario autenticado');
      }
    } catch (e) {
      return ('Error al recargar el saldo: $e');
    }
  }

  static Future<void> pagar() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        String correo = currentUser.email!;
        QuerySnapshot snapshot = await firestore
            .collection('usuarios')
            .where('correo', isEqualTo: correo)
            .get();
        if (snapshot.docs.isNotEmpty) {
          String documentId = snapshot.docs.first.id;
          Map<String, dynamic>? userData =
              snapshot.docs.first.data() as Map<String, dynamic>?;
          double saldoActual = userData?['saldo'] ?? 0.0;
          if (saldoActual >= 2000) {
            double nuevoSaldo = saldoActual - 2000;
            await firestore
                .collection('usuarios')
                .doc(documentId)
                .update({'saldo': nuevoSaldo});
            print('Pago realizado correctamente');
          } else {
            print('Saldo insuficiente');
          }
        } else {
          print('No se encontró ningún usuario con el correo proporcionado');
        }
      } else {
        print('No se ha encontrado ningún usuario autenticado');
      }
    } catch (e) {
      print('Error al realizar el pago: $e');
    }
  }

  static Future<void> cerrarSesion() async {
    await auth.signOut();
  }
}
