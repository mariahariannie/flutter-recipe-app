// ignore_for_file: file_names
class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String imgUrl;
  final String ins;
  bool isBookmarked;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.imgUrl,
    required this.ins,
    required this.isBookmarked
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['idMeal'],
      name: json['strMeal'],
      category: json['strCategory'],
      area: json['strArea'],
      imgUrl: json['strMealThumb'],
      ins: json['strInstructions'],
      isBookmarked: false
    );
  }
}