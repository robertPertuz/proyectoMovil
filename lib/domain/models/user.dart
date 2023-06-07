class User {
  late String nombre;
  late String email;
  late String password;

  User({required this.nombre, required this.email, required this.password});

  factory User.desdeJson(Map<String, dynamic> jsonMap) {
    return User(
        nombre: jsonMap['nombre'],
        email: jsonMap['email'],
        password: jsonMap['pass']);
  }
}
