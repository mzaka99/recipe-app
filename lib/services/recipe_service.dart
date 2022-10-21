import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = 'https://masak-apa-tomorisakura.vercel.app';

class RecipeService {
  dynamic fetchRecipe() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/recipes'));

      final resposeData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return (resposeData['results']);
      } else {
        throw Exception(resposeData['message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  dynamic fetchRecipeDetail({required String keyword}) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/recipe/$keyword'));

      final resposeData = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return (resposeData['results']);
      } else {
        throw Exception(resposeData['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}
