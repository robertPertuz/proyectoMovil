import 'package:cloud_firestore/cloud_firestore.dart';

class PeticionesRuta {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> guardarRuta(String nombre, List<String> barrios) async {
    try {
      await firestore.collection('rutas').add({
        'nombre': nombre,
        'barrios': barrios,
      });
      print('Ruta guardada correctamente');
    } catch (e) {
      print('Error al guardar la ruta: $e');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerRutas() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('rutas').get();
      List<Map<String, dynamic>> rutas = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return rutas;
    } catch (e) {
      print('Error al obtener las rutas: $e');
      return [];
    }
  }

  static Future<void> eliminarRuta(String nombre) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('rutas')
          .where('nombre', isEqualTo: nombre)
          .get();
      if (snapshot.docs.isNotEmpty) {
        await firestore.collection('rutas').doc(snapshot.docs[0].id).delete();
        print('Ruta eliminada correctamente');
      }
    } catch (e) {
      print('Error al eliminar la ruta: $e');
    }
  }

  static Future<void> actualizarRuta(
      String nombre, List<String> barrios) async {
    try {
      await firestore.collection('rutas').doc(nombre).update({
        'nombre': nombre,
        'barrios': barrios,
      });
      print('Ruta actualizada correctamente');
    } catch (e) {
      print('Error al actualizar la ruta: $e');
    }
  }
}
