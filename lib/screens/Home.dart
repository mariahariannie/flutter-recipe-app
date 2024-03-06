// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:recipe/screens/Dashboard.dart';
import 'package:recipe/screens/Randomizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static const String routeName = "home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  final List<Widget> _pages = [Dashboard(),/*, Bookmarks(),*/ Randomizer()];
  
  BottomNavigationBarItem _bottomNavigationBarItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: pageIndex == index ? Colors.blue : null),
      label: label
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Recipe App"),
      ),
      body: _pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: Colors.blue,
        items: [
          _bottomNavigationBarItem(Icons.dashboard, "Dashboard", 0),
          //_bottomNavigationBarItem(Icons.bookmark, "Bookmarks", 1),
          _bottomNavigationBarItem(Icons.loop, "Randomizer", 2),
        ],
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        }
      )
    );
  }
}
