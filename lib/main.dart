import 'package:flutter/material.dart';
import 'package:recipe/routes.dart';
import 'package:recipe/screens/Home.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    routes: routes,
  ));
}