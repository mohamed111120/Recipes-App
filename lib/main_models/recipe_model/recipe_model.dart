import 'package:food_recipes/main_models/recipe_model/recipe_reviews.dart';
import 'package:food_recipes/main_models/recipe_model/recipe_steps_model.dart';

class RecipeModel {
  String? recipeId;
  String? recipeName;
  String? recipeDescription;
  String? recipePhoto;
  List<RecipeSteps>? recipeSteps;
  String? chefUid;
  int? recipeTime;
  int? clickCount = 0;
  bool? isFeatured = false;
  List<RecipeReviews>? recipeReviews;
  String? category;
  String? features;
  int? calories;

  RecipeModel({
    this.recipeId,
    required this.recipeName,
    required this.recipeDescription,
    required this.recipePhoto,
    required this.chefUid,
    required this.recipeSteps,
    required this.recipeTime,
    required this.clickCount,
    required this.isFeatured,
    required this.recipeReviews,
    required this.category,
    required this.features,
    required this.calories,
  });

  RecipeModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipe id'];
    recipeName = json['recipe name'];
    recipeDescription = json['recipe description'];
    recipePhoto = json['recipe photo'];
    chefUid = json['chef uid'];
    if (json['recipe steps'] != null) {
      recipeSteps = <RecipeSteps>[];
      json['recipe steps'].forEach((v) {
        recipeSteps?.add(RecipeSteps.fromJson(v));
      });
    }
    recipeTime = json['recipe time'];
    clickCount = json['click count'];
    isFeatured = json['is featured'];
    if (json['recipe reviews'] != null) {
      recipeReviews = <RecipeReviews>[];
      json['recipe reviews'].forEach((v) {
        recipeReviews?.add(RecipeReviews.fromJson(v));
      });
    }
    category = json['category'];
    features = json['features'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    return {
      'recipe id': recipeId,
      'recipe name': recipeName,
      'recipe description': recipeDescription,
      'recipe photo': recipePhoto,
      'recipe steps': recipeSteps?.map((v) => v.toJson()).toList(),
      'chef uid': chefUid,
      'recipe time': recipeTime,
      'click count': clickCount,
      'is featured': isFeatured,
      'recipe reviews': recipeReviews?.map((v) => v.toJson()).toList(),
      'category': category,
      'features': features,
      'calories': calories,
    };
  }
}
