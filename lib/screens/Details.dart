// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:recipe/models/Recipe.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  static const String routeName = "details";

  final Recipe recipe;
  const Details({required this.recipe, Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map<String, dynamic>? recipeDetails;
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      
      setState(() {
        recipeDetails = data;
      });

    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Recipe recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Center(
        child: SingleChildScrollView(
        child: recipeDetails != null
        ? Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:[
                Image.network(
                recipe.imgUrl,
                width: 200,
                height: 200,
              ),
                SizedBox(height: 20),
                Text('${recipe.name}'),
                Text('${recipe.category}'),
                Text('${recipe.area}'),
                SizedBox(height: 20),
                Text('${recipe.ins}', textAlign: TextAlign.justify)
              ]
            )
          )
        )
        : CircularProgressIndicator()
        )
      )
    );
  }
}