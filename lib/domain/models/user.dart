class User {
  late int id;
  late String nombre;
  late String email;
  late String password;

  User(
      {required this.id,
      required this.nombre,
      required this.email,
      required this.password});

  factory User.desdeJson(Map<String, dynamic> jsonMap) {
    return User(
        id: int.parse(jsonMap['id']),
        nombre: jsonMap['nombre'],
        email: jsonMap['email'],
        password: jsonMap['pass']);
  }
}
