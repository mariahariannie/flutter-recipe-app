// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/models/Recipe.dart';
import 'package:recipe/screens/Details.dart';

class Randomizer extends StatefulWidget {
  const Randomizer({Key? key}) : super(key: key);
  static const String routeName = "randomizer";
  
  @override
  _RandomizerState createState() => _RandomizerState();
}

class _RandomizerState extends State<Randomizer> {
  Recipe? randomRecipe;

  @override
  void initState() {
    super.initState();
    displayRandomRecipe();
    
  }
  Future<void> displayRandomRecipe() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data["meals"];
      if (meals != null && meals.isNotEmpty) {
        setState(() {
          randomRecipe = Recipe.fromJson(meals[0]);
        });
      } else {
        print("No meal data found");
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You will make:"),
            SizedBox(height: 10.0),
            randomRecipe != null
                ? GestureDetector(
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(recipe: randomRecipe!),
                        ),
                      );
                    },
                    child: Column(
                    children: [
                      Image.network(
                        randomRecipe!.imgUrl,
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        "${randomRecipe!.name}!",
                        style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)
                      ),
                    ],
                  ),
                )
              : Text("What to cook today?"),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: displayRandomRecipe,
                  child: Text("Shuffle"),
                ),
          ],
        ),
      )
    );
  }
}