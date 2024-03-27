import 'package:flutter/material.dart';
import 'package:recipe/models/Recipe.dart';
import 'package:recipe/screens/Details.dart';
import 'package:recipe/screens/firestore.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Firestore db = Firestore();
  List<Recipe> bookmarkedRecipes = [];

  @override
  void initState() {
    super.initState();
    fetchBookmarkedRecipes();
  }

  Future<void> fetchBookmarkedRecipes() async {
    List<String> bookmarkedRecipeIds = await db.getBookmarks();

    List<Recipe> recipes = [];
    for (String id in bookmarkedRecipeIds) {
      Recipe? recipe = await db.getRecipeById(id);
      if (recipe != null) {
        recipes.add(recipe);
      }
    }

    setState(() {
      bookmarkedRecipes = recipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: bookmarkedRecipes.length,
        itemBuilder: (context, index) {
          final recipe = bookmarkedRecipes[index];
          return ListTile(
            title: Text(recipe.name),
            leading: const Icon(Icons.dining, color: Colors.blue),
            trailing: IconButton(
              onPressed: () async {
                db.toggleBookmark(recipe);
                setState(() {
                  recipe.isBookmarked = !recipe.isBookmarked;
                });
              },
              icon: recipe.isBookmarked
                  ? Icon(Icons.bookmark)
                  : Icon(Icons.bookmark_outline),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Details(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}