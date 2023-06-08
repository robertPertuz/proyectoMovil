import 'package:com.proyecto.busmate/domain/models/Ruta.dart';
import 'package:com.proyecto.busmate/domain/models/conductor.dart';

class Bus {
  String placa;
  Ruta ruta;
  Conductor conductor;

  Bus({required this.placa, required this.ruta, required this.conductor});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      placa: json['placa'] ?? '',
      ruta: json['ruta'] != null
          ? Ruta(json['ruta']['nombre'], json['ruta']['barrios'])
          : Ruta('', []),
      conductor: json['conductor'] != null
          ? Conductor.fromJson(json['conductor'])
          : Conductor(cedula: '', nombre: '', telefono: ''),
    );
  }
}
