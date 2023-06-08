import 'package:com.proyecto.busmate/ui/auth/vistaAdmin/screenGestionConductor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth/pages/aboutScreen.dart';
import 'auth/vistaAdmin/pageAdmin.dart';
import 'auth/pages/pago.dart';
import 'auth/pages/profileUser.dart';
import 'auth/pages/registrar.dart';
import 'auth/pages/login.dart';
import 'auth/vistaAdmin/screenRegistrarConductor.dart';
import 'auth/vistaAdmin/screenGestionBuses.dart';
import 'auth/vistaAdmin/screenRegistrarBus.dart';
import 'auth/vistaAdmin/screenRegistrarRuta.dart';
import 'auth/vistaAdmin/screengestionRutas.dart';
import 'auth/pages/screenRuta.dart';

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
        "/admin": (context) => AdminScreen(),
        "/GestionBuses": (context) => GestionBuses(),
        "/GestionConductor": (context) => GestionConductores(),
        "/GestionRutas": (context) => GestionRutas(),
        "/RegistroRuta": (context) => RegistrarRuta(),
        "/RegistroConductor": (context) => RegistroConductor(),
        "/RegistroBus": (context) => RegistrarBus(),
      },
    );
  }
}
