import 'package:com.proyecto.busmate/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'domain/controller/controlUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyA5Mx4nPIt6VdecxbmYwNNaS395Z_AAMBY",
              authDomain: "busmate-c749a.firebaseapp.com",
              projectId: "busmate-c749a",
              messagingSenderId: "1063671877089",
              appId: "1:1063671877089:android:50a2e2090d300cce7ad6a0"))
      : await Firebase.initializeApp();

  Get.put(ControlUserAuth());
  runApp(const App());
}
