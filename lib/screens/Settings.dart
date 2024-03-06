// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/components/LogoutButton.dart';
import 'package:recipe/firebaseAuth.dart';

class Settings extends StatefulWidget {
  static const String routeName = "settings";
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80.0),
                    Icon(Icons.dinner_dining,size: 80),
                    SizedBox(height:20.0),
                    Text("Thank you for using the App!", style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 50.0),
                    
              LogoutButton(
                text: "Logout", 
                iconData: Icons.logout, 
                onPressed: logout
              )
            ],
          ),
        ),
      )
    );
  }

  void logout() {
    FirebaseAuth.instance.signOut().then((value) => {
      GoogleSignIn().signOut().then((value) =>
        {Navigator.pushReplacementNamed(context, Auth.routeName)})
    });
  }
}