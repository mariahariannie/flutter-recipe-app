// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe/components/LoginForm.dart';
import 'package:recipe/components/PasswordField.dart';
import 'package:recipe/components/PrimaryButton.dart';
import 'package:recipe/screens/Home.dart';

class Auth extends StatefulWidget {
  static const String routeName = "auth";
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final loginEmailTextController = TextEditingController();
  final loginPasswordTextController = TextEditingController();
  final registerEmailTextController = TextEditingController();
  final registerPasswordTextController = TextEditingController();
  final registerRepeatPasswordTextController = TextEditingController();
  bool obscureText = true;
  bool showLogin = true;
  bool showRegister = false;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Visibility(
            visible: showLogin,
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 80.0),
                    Icon(Icons.dinner_dining,size: 80),
                    SizedBox(height:20.0),
                    Text("Welcome to Happy Meal!", style: TextStyle(fontSize: 30.0)),
                    Text("Happy cooking!", style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 50.0),
                    
                    LoginForm(
                      labelText: "Email Address",
                      hintText: "Enter a valid email address",
                      iconData: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      controller: loginEmailTextController
                    ),
                    const SizedBox(height: 20),

                    PasswordField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      controller: loginPasswordTextController,
                    ),
                    const SizedBox(height: 20),

                    PrimaryButton(
                      text: "Login",
                      iconData: Icons.login,
                      onPressed: loginWithEmail
                    ),
                    const SizedBox(height: 20),

                    const Text("Or"),
                    SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        loginWithGoogle();
                      },
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          const Text("Don't have account?"),
                          TextButton(
                            onPressed: displayRegister,
                            child: const Text('Create a new account'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          Visibility(
            visible: showRegister,
            child: Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 80.0),
                    Icon(Icons.dinner_dining,size: 80),
                    SizedBox(height:20.0),
                    Text("Welcome to Happy Meal!", style: TextStyle(fontSize: 30.0)),
                    Text("Create an account", style: TextStyle(fontSize: 20.0)),
                    SizedBox(height: 50.0),
                    
                    LoginForm(
                      labelText: "Email Address",
                      hintText: "Enter a valid email address",
                      iconData: Icons.email,
                      textInputType: TextInputType.emailAddress,
                      controller: registerEmailTextController
                    ),
                    const SizedBox(height: 20),
                    
                    PasswordField(
                      labelText: "Password",
                      hintText: "Enter your password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      controller: registerPasswordTextController,
                    ),
                    const SizedBox(height: 20),

                    PasswordField(
                      labelText: "Repeat Password",
                      hintText: "Re-enter your password",
                      obscureText: obscureText,
                      onTap: setPasswordVisibility,
                      controller: registerRepeatPasswordTextController,
                    ),
                    const SizedBox(height: 20),

                    PrimaryButton(
                      text: "Confirm",
                      iconData: Icons.login,
                      onPressed: register
                    ),
                    const SizedBox(height: 20),
                    
                    Container(
                      margin: const EdgeInsets.only(left: 70.0),
                      child: Row(
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: displayLogin,
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void displayLogin() {
    setState(() {
      showLogin = true;
      showRegister = false;
    });
  }

  void displayRegister() {
    setState(() {
      showLogin = false;
      showRegister = true;
    });
  }
  
  void loginWithEmail() async {
    if (loginPasswordTextController.text.isNotEmpty &&
      loginEmailTextController.text.isNotEmpty) {
      try {
        final userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginEmailTextController.text,
                password: loginPasswordTextController.text);
        print(userCredential);
        Navigator.pushReplacementNamed(context, Home.routeName);
      } catch (e) {
        _showMyDialog('Email or password is invalid.');
      }
    } else {
      _showMyDialog('Please fill in all fields.');
    }
  }

  void loginWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential);
      Navigator.pushReplacementNamed(context, Home.routeName);
    } catch (e) {
      print(e);
    }
  }

  void register() async {
    if (registerPasswordTextController.text.isNotEmpty &&
        registerEmailTextController.text.isNotEmpty &&
        registerRepeatPasswordTextController.text.isNotEmpty) {
      try {
        if (registerPasswordTextController.text ==
            registerRepeatPasswordTextController.text) {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: registerEmailTextController.text,
              password: registerPasswordTextController.text);
          User? currentUser = FirebaseAuth.instance.currentUser;
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;
          final googleCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth?.accessToken,
              idToken: googleAuth?.idToken);
          if (currentUser != null && !currentUser.isAnonymous) {
            await currentUser.linkWithCredential(googleCredential);
            _showMyDialog('Account created successfully!');
          }
        } else {
          _showMyDialog('Password does not match.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          _showMyDialog('Please input up to 6 characters.');
        } else if (e.code == 'email-already-in-use') {
          _showMyDialog('Account already exists.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      _showMyDialog('Please fill in all fields.');
    }
  }

  void setPasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content:Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}