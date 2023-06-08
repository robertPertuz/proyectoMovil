import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:com.proyecto.busmate/data/peticionesConductor.dart';
import 'package:com.proyecto.busmate/domain/models/conductor.dart';

class ControladorConductor extends GetxController {
  final PeticionesConductor _peticionesConductor = PeticionesConductor();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> guardarConductor(Conductor conductor) async {
    // Verificar si el conductor ya existe
    List<Map<String, dynamic>> conductores =
        await _peticionesConductor.obtenerConductores();
    bool conductorExistente =
        conductores.any((c) => c['cedula'] == conductor.cedula);
    if (conductorExistente) {
      return false; // El conductor ya existe, retorna false
    }

    try {
      await PeticionesConductor.guardarConductor(conductor);
      return true; // El conductor se guarda correctamente
    } catch (e) {
      return false; // Error al guardar el conductor
    }
  }

  Future<List<Conductor>> obtenerConductores() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('conductores').get();
      List<Map<String, dynamic>> conductores = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      List<Conductor> conductoresList = conductores
          .map((conductor) => Conductor.fromJson(conductor))
          .toList();

      return conductoresList;
    } catch (e) {
      print('Error al obtener los conductores: $e');
      return [];
    }
  }

  Future<void> eliminarConductor(String conductorId) async {
    await PeticionesConductor.eliminarConductor(conductorId);
  }

  Future<void> actualizarConductor(
      String conductorId, Conductor conductor) async {
    await PeticionesConductor.actualizarConductor(conductorId, conductor);
  }
}
