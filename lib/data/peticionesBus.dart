import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.proyecto.busmate/domain/models/Bus.dart';

class PeticionesBus {
  static Future<void> guardarBus(Bus bus) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference busesRef = firestore.collection('buses');

      Map<String, dynamic> busData = {
        'placa': bus.placa,
        'ruta': {
          'nombre': bus.ruta.nombre,
          'barrios': bus.ruta.barrios,
        },
        'conductor': {
          'cedula': bus.conductor.cedula,
          'nombre': bus.conductor.nombre,
          'telefono': bus.conductor.telefono,
        },
      };

      await busesRef.add(busData);
      print('Bus guardado correctamente');
    } catch (e) {
      print('Error al guardar el bus: $e');
    }
  }

  static Future<List<Bus>> obtenerBuses() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference busesRef = firestore.collection('buses');

      QuerySnapshot snapshot = await busesRef.get();
      List<Bus> buses = snapshot.docs.map((doc) {
        Map<String, dynamic>? busData = doc.data() as Map<String, dynamic>?;
        if (busData != null) {
          return Bus.fromJson(busData);
        } else {
          throw Exception('Data is null');
        }
      }).toList();

      return buses;
    } catch (e) {
      print('Error al obtener los buses: $e');
      return []; // Return an empty list in case of an error
    }
  }

  static Future<void> eliminarBus(String placa) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference busesRef = firestore.collection('buses');

      QuerySnapshot snapshot =
          await busesRef.where('placa', isEqualTo: placa).get();
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });

      print('Bus eliminado correctamente');
    } catch (e) {
      print('Error al eliminar el bus: $e');
    }
  }

  static Future<bool> verificarBusExistente(String placa) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference busesRef = firestore.collection('buses');

    QuerySnapshot snapshot =
        await busesRef.where('placa', isEqualTo: placa).get();
    return snapshot.docs.isNotEmpty;
  }
}
