import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/pages/registrar.dart';
import 'auth/pages/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/login',
      routes: {
        "/login": (context) => const Login(),
        "/registrar": (context) => RegisterScreen(),
      },
    );
  }
}
