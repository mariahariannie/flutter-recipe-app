import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe/models/Recipe.dart';

class Firestore {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Map<String, bool> bookmarks = {};
  
  Future<List<String>> getBookmarks() async {
    List<String> bookmarkedRecipeIds = [];

    try {
      QuerySnapshot querySnapshot = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("bookmarkedRecipes")
          .get();

      bookmarkedRecipeIds = querySnapshot.docs.map((doc) {
        return doc.id;
      }).toList();
    } catch (e) {
      print("Error fetching bookmarks: $e");
    }

    return bookmarkedRecipeIds;
  }

  Future<Recipe?> getRecipeById(String id) async {
    try {
      DocumentSnapshot recipeDoc = await db
          .collection("bookedmarkedRecipes")
          .doc(id)
          .get();

      if (recipeDoc.exists) {
        return Recipe.fromJson(recipeDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching recipe details: $e");
    }

    return null;
  }

  Future<void> update(String email, String item) async {
    Map<String, bool> bookmark = {};

    await db
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        bookmark = Map.from(element["bookmarks"]);
        print(bookmark);
      }
    });

    for (var element in bookmark.keys) {
      if (element == item) {
        bookmark[item] = bookmark[item]! ? false : true;
      }
    }

    await db
        .collection("users")
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        element.reference.update({"bookmarks": bookmark});
      }
    });
    await getBookmarks();
  }
  
  void toggleBookmark(Recipe recipe) {
    recipe.isBookmarked = !recipe.isBookmarked;
    if (recipe.isBookmarked) {
      addBookmark(recipe);
    } else {
      removeBookmark(recipe);
    }
  }

  Future<void> addBookmark(Recipe recipe) async {
    try {
      DocumentSnapshot userDoc = await db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

      if (!userDoc.exists) {
        print("Recipe Document created");
        await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid).
        set({
          "userID": FirebaseAuth.instance.currentUser?.uid,
          "email": FirebaseAuth.instance.currentUser?.email
        });
      }
      
      await db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("bookmarkedRecipes")
      .doc(recipe.id).set({
        "recipeID": recipe.id,
        "name": recipe.name,
        "status": recipe.isBookmarked
      });
      print("Recipe added to bookmark");
    } catch (e) {
      print("Error adding bookmark: $e");
    }
  }

  Future<void> removeBookmark(Recipe recipe) async {
    try {
      await db
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection("bookmarkedRecipes")
      .doc(recipe.id)
      .delete();
      print("Recipe removed from bookmark");
    } catch (e) {
      print("Error removing bookmark: $e");
    }
  }

}