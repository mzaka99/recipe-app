import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/screens/recipe_detail.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel dataRecipe;
  const RecipeCard({super.key, required this.dataRecipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        RecipeDetail.routeName,
        arguments: dataRecipe.key,
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5.0,
              offset: const Offset(0.0, 0.75),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                dataRecipe.thumb,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                dataRecipe.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.times),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.work),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.difficulty),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.rice_bowl_rounded),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(dataRecipe.serving),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
