import 'package:flutter/material.dart';
import 'package:recipe/firebaseAuth.dart';
import 'package:recipe/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: const Auth(),
    routes: routes,
  ));
}