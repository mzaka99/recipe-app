import 'package:flutter/foundation.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/services/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  String errorMessage = '';
  List<RecipeModel> _recipes = [];
  List<RecipeModel> get recipes => [..._recipes];

  RecipeModelDetail? recipeDetail;

  RecipeModel findByKey(String key) {
    return _recipes.firstWhere((data) => data.key == key);
  }

  Future<void> extractDataRecipe() async {
    try {
      final extractData = await RecipeService().fetchRecipe() as List<dynamic>;
      final List<RecipeModel> loadData = [];
      extractData
          .map((data) => loadData.add(RecipeModel.fromJson(data)))
          .toList();
      _recipes = loadData;
      errorMessage = '';
      notifyListeners();
    } on Exception catch (e) {
      errorMessage = e as String;
      notifyListeners();
    }
  }

  Future<void> extractDataRecipeDetail(String keyword) async {
    try {
      final extractData =
          await RecipeService().fetchRecipeDetail(keyword: keyword);
      RecipeModelDetail? loadData;
      loadData = RecipeModelDetail(
        desc: extractData['desc'],
        author: Author(
            user: extractData['author']['user'],
            datePublished: extractData['author']['datePublished']),
        needItem: (extractData['needItem'] as List<dynamic>)
            .map((data) => data['item_name'])
            .toList(),
        ingredient: (extractData['ingredient'] as List<dynamic>),
        step: (extractData['step'] as List<dynamic>),
      );
      recipeDetail = loadData;
      notifyListeners();
    } on Exception catch (e) {
      errorMessage = e as String;
      notifyListeners();
    }
  }
}
