import 'package:get/get.dart';
import 'package:com.proyecto.busmate/domain/models/Bus.dart';

import '../../data/peticionesBus.dart';

class ControlBus extends GetxController {
  final RxList<Bus> listaBuses = <Bus>[].obs;
  final Rx<Bus?> selectedBus = Rx<Bus?>(null);

  @override
  void onInit() {
    super.onInit();
    listarBuses();
  }

  Future<List<Bus>> listarBuses() async {
    try {
      final List<Bus> buses = await PeticionesBus.obtenerBuses();
      listaBuses.assignAll(buses);
      return buses; // Agrega esta línea para devolver la lista de buses
    } catch (e) {
      print('Error al obtener los buses: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<void> guardarBus(Bus bus) async {
    try {
      // Verificar si el bus ya existe por el número de placa
      bool busExistente = await PeticionesBus.verificarBusExistente(bus.placa);
      if (busExistente) {
        throw Exception('Ya existe un bus con esa placa');
      }

      await PeticionesBus.guardarBus(bus);
      listarBuses();
      print('Bus guardado correctamente');
    } catch (e) {
      print('Error al guardar el bus: $e');
    }
  }

  Future<void> eliminarBus(String placa) async {
    try {
      await PeticionesBus.eliminarBus(placa);
      listarBuses();
      print('Bus eliminado correctamente');
    } catch (e) {
      print('Error al eliminar el bus: $e');
    }
  }

  void clearSelectedBus() {
    selectedBus.value = null;
  }
}
