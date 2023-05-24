import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/pages/aboutScreen.dart';
import 'auth/pages/pago.dart';
import 'auth/pages/profileUser.dart';
import 'auth/pages/registrar.dart';
import 'auth/pages/login.dart';
import 'auth/ruta.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bus',
      theme: ThemeData(primarySwatch: Colors.green), // Color de la app
      initialRoute: '/login',

      routes: {
        "/login": (context) => Login(),
        "/registrar": (context) => RegisterScreen(),
        "/profile": (context) => Profile(),
        "/ruta": (context) => BusRouteMap(),
        "/pago": (context) => PaymentView(),
        "/about": (context) => AboutScreen(),
      },
    );
  }
}
