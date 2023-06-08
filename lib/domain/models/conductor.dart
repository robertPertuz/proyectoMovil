class Conductor {
  String cedula;
  String nombre;
  String telefono;

  Conductor(
      {required this.cedula, required this.nombre, required this.telefono});

  factory Conductor.fromJson(Map<String, dynamic> json) {
    return Conductor(
      cedula: json['cedula'],
      nombre: json['nombre'],
      telefono: json['telefono'],
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Conductor && other.nombre == nombre;
  }

  @override
  int get hashCode => nombre.hashCode;
}
