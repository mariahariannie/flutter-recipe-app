import 'package:flutter/material.dart';
import 'package:recipe/firebaseAuth.dart';
import 'package:recipe/screens/Dashboard.dart';
import 'package:recipe/screens/Home.dart';
import 'package:recipe/screens/Settings.dart';

final Map<String, WidgetBuilder> routes = {
  Home.routeName:(BuildContext context) => const Home(),
  Dashboard.routeName:(BuildContext context) => Dashboard(),
  Auth.routeName:(BuildContext context) => const Auth(),
  Settings.routeName:(BuildContext context) => const Settings(),
};