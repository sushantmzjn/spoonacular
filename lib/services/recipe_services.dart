import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spoonacular/api.dart';
import 'package:spoonacular/api_key.dart';
import 'package:spoonacular/model/recipe.dart';
import 'package:spoonacular/model/recipe_detail.dart';

import '../api_exception.dart';


final getRecipe = FutureProvider((ref) => RecipeService.getRecipe());

final getRecipeDetail = FutureProvider.family((ref, int id) => RecipeService.getRecipeDetail(id: id));

class RecipeService {
  static Dio dio = Dio();

  //get recipe
  static Future<List<Recipe>> getRecipe() async {
    try {
      final response = await dio.get(Api.getRecipe,
          queryParameters: {'apiKey': apiKey});
      final data = (response.data['results'] as List).map((e) => Recipe.fromJson(e)).toList();
      return data;
    } on DioError catch (err) {
      // print(err);
      throw DioException.getDioError(err);
    }
  }

  //get recipe details
static Future<RecipeDetail> getRecipeDetail({
required int id
})async{
    try{
      final res = await dio.get('https://api.spoonacular.com/recipes/$id/information',
      queryParameters: {'apiKey': apiKey });
     // final data = (res.data as List).map((e) => RecipeDetail.fromJson(e)).toList();
      final data =RecipeDetail.fromJson(res.data);
      // print(res.data);
      return data;

    }on DioError catch(err){
      throw DioException.getDioError(err);
      // return Left(DioException.getDioError(err));
    }
}
}
