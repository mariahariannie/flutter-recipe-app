// ignore_for_file: file_names, library_private_types_in_public_api
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/models/Recipe.dart';
import 'package:recipe/screens/Details.dart';
import 'package:recipe/screens/firestore.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = "dashboard";

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Firestore db = Firestore();
  List<Recipe> recipeList = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    getRecipeList();
  }
  Future<void> getRecipeList() async {
    final searchKeyword = _searchController.text;
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$searchKeyword'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> recipesData = data['meals'];
      setState(() {
        recipeList = recipesData.map((meal) => Recipe.fromJson(meal)).toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (input) {
                getRecipeList();
              },
              decoration: const InputDecoration(
                hintText: 'Search for recipes...',
                icon: Icon(Icons.search)
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  final recipe = recipeList[index];
                  return ListTile(
                    title: Text(recipe.name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(recipe: recipe)
                        ),
                      );
                    },
                    trailing: IconButton(
                      onPressed: () async{
                        db.update(
                          FirebaseAuth.instance.currentUser!.email.toString(), recipe.name);
                        setState(() {
                          db.toggleBookmark(recipe);
                          print(recipe.isBookmarked);
                        });
                      },
                      icon: recipe.isBookmarked
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_outline),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}
