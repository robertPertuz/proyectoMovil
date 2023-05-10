import 'package:bus_mate/ui/auth/pages/profileUser.dart';
import 'package:bus_mate/ui/auth/ruta.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/pages/pago.dart';
import 'auth/pages/registrar.dart';
import 'auth/pages/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus',
      theme: ThemeData(primarySwatch: Colors.green), // Color de la app
      initialRoute: '/profile',

      routes: {
        "/login": (context) => const Login(),
        "/registrar": (context) => RegisterScreen(),
        "/profile": (context) => const Profile(),
        "/ruta": (context) => BusRouteMap(),
        "/pago": (context) => PaymentView(),
      },
    );
  }
}
