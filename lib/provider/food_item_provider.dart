

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:spoonacular/model/food_item.dart';
import '../main.dart';

final foodItemProvider = StateNotifierProvider<FoodItemProvider, List<FoodItem>>((ref) => FoodItemProvider(ref.watch(box1)));

class FoodItemProvider extends StateNotifier<List<FoodItem>>{
  FoodItemProvider(super.state);


  //add food items
String add(FoodItem foodItem){
  final newFoodItem = FoodItem(
      foodName: foodItem.foodName,
      calorie: foodItem.calorie,
      dateTime: foodItem.dateTime
  );
  final box = Hive.box<FoodItem>('foodItem').add(newFoodItem);
  state = [...state, newFoodItem];
  return 'Success';
}

//update food items
String update(int index,FoodItem updateFoodItem){
  state[index] = updateFoodItem;
  final newFoodItem = FoodItem(
      foodName: updateFoodItem.foodName,
      calorie: updateFoodItem.calorie,
      dateTime: updateFoodItem.dateTime
  );
  final box = Hive.box<FoodItem>('foodItem').put(index, newFoodItem);
  state=[...state];
  return 'Updated';
}

//get total calories
  int get total{
    int total = 0;
    for(final foodItem in state){
      total += foodItem.calorie;
    }
    return total;
  }

}