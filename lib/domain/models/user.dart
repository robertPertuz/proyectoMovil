class User {
  late String? nombre;
  late String? email;
  late String? password;
  late double? saldo;

  User(
      {required this.nombre,
      required this.email,
      required this.password,
      this.saldo = 100.0});

  factory User.desdeJson(Map<String, dynamic> jsonMap) {
    return User(
        nombre: jsonMap['nombre'],
        email: jsonMap['email'],
        password: jsonMap['pass'],
        saldo: jsonMap['saldo']);
  }
}
