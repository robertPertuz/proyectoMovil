import 'package:get/get.dart';
import '../../data/peticionesRutas.dart';
import '../models/Ruta.dart';

class ControladorRuta extends GetxController {
  final PeticionesRuta _peticionesRuta = PeticionesRuta();

  Future<bool> guardarRuta(String nombre, List<String> barrios) async {
    // Verificar si la ruta ya existe
    List<Map<String, dynamic>> rutas = await _peticionesRuta.obtenerRutas();
    bool rutaExistente = rutas.any((r) => r['nombre'] == nombre);
    if (rutaExistente) {
      return false; // La ruta ya existe, retorna false
    }

    try {
      await PeticionesRuta.guardarRuta(nombre, barrios);
      return true; // La ruta se guarda correctamente
    } catch (e) {
      return false; // Error al guardar la ruta
    }
  }

  Future<List<Ruta>> obtenerRutas() async {
    try {
      List<Map<String, dynamic>> rutas = await _peticionesRuta.obtenerRutas();
      List<Ruta> rutasList = rutas.map((ruta) => Ruta.fromJson(ruta)).toList();
      return rutasList;
    } catch (e) {
      print('Error al obtener las rutas: $e');
      return [];
    }
  }

  Future<void> eliminarRuta(String nombre) async {
    await PeticionesRuta.eliminarRuta(nombre);
  }

  Future<void> actualizarRuta(String nombre, List<String> barrios) async {
    await PeticionesRuta.actualizarRuta(nombre, barrios);
  }
}
