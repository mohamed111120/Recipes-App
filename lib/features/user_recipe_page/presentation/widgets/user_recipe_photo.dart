import 'package:flutter/material.dart';

class UserRecipePhoto extends StatelessWidget {
  const UserRecipePhoto({super.key, required this.recipePhoto});
  final String recipePhoto;
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 300,
      decoration:  BoxDecoration(
        image: DecorationImage(

          fit: BoxFit.cover,
          image: NetworkImage(
              recipePhoto),
        ),
      ),
    );
  }
}
