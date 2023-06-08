class Ruta {
  String nombre;
  List<dynamic> barrios;

  Ruta(this.nombre, this.barrios);

  factory Ruta.fromJson(Map<String, dynamic> json) {
    return Ruta(
      json['nombre'],
      json['barrios'],
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ruta && other.nombre == nombre;
  }

  @override
  int get hashCode => nombre.hashCode;
}
