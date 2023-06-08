import 'package:cloud_firestore/cloud_firestore.dart';

import '../domain/models/conductor.dart';

class PeticionesConductor {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> guardarConductor(Conductor conductor) async {
    try {
      await firestore.collection('conductores').add({
        'cedula': conductor.cedula,
        'nombre': conductor.nombre,
        'telefono': conductor.telefono,
      });
      print('Conductor guardado correctamente');
    } catch (e) {
      print('Error al guardar el conductor: $e');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerConductores() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('conductores').get();
      List<Map<String, dynamic>> conductores = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return conductores;
    } catch (e) {
      print('Error al obtener los conductores: $e');
      return [];
    }
  }

  static Future<void> eliminarConductor(String cedula) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('conductores')
          .where('cedula', isEqualTo: cedula)
          .get();

      if (snapshot.docs.isNotEmpty) {
        String conductorId = snapshot.docs.first.id;
        await firestore.collection('conductores').doc(conductorId).delete();
        print('Conductor eliminado correctamente');
      } else {
        print('No se encontró ningún conductor con la cédula proporcionada');
      }
    } catch (e) {
      print('Error al eliminar el conductor: $e');
    }
  }

  static Future<void> actualizarConductor(
      String conductorId, Conductor conductor) async {
    try {
      await firestore.collection('conductores').doc(conductorId).update({
        'nombre': conductor.nombre,
        'telefono': conductor.telefono,
      });
      print('Conductor actualizado correctamente');
    } catch (e) {
      print('Error al actualizar el conductor: $e');
    }
  }
}
