import 'package:bus_mate/ui/auth/pages/profileUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/pages/login.dart';
import 'auth/pages/profileUser.dart';

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
        "/profile": (context) => const Profile(),
      },
    );
  }
}
