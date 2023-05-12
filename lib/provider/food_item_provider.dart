

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:spoonacular/model/calorie.dart';
import 'package:spoonacular/model/food_item.dart';
import '../main.dart';

final foodItemProvider = StateNotifierProvider<FoodItemProvider, List<TotalCalorie>>((ref) => FoodItemProvider(ref.watch(box2)));

class FoodItemProvider extends StateNotifier<List<TotalCalorie>>{
  FoodItemProvider(super.state);


  //add food items
// String add(FoodItem foodItem){
//   final newFoodItem = FoodItem(foodName: foodItem.foodName, calorie: foodItem.calorie, dateTime: foodItem.dateTime);
//   final box = Hive.box<FoodItem>('foodItem').add(newFoodItem);
//   state = [...state, newFoodItem];
//   return 'Success';
// }

  void add(TotalCalorie totalCalorie){
    if(state.isEmpty){
      final newAdd = TotalCalorie(
          totalCalorie: totalCalorie.totalCalorie,
          dateTime: totalCalorie.dateTime,
          foodItem: totalCalorie.foodItem
      );
      Hive.box<TotalCalorie>('totalCalorie').add(newAdd);
      state = [...state, newAdd];

    }else {
      final oldData = state.firstWhere((element) => element.dateTime == totalCalorie.dateTime,
          orElse: ()=> TotalCalorie(totalCalorie: 0, dateTime: 'no', foodItem: [])
      );
      // if(oldData.dateTime == 'no'){
      //   final newAdd = TotalCalorie(
      //       totalCalorie: totalCalorie.totalCalorie,
      //       dateTime: totalCalorie.dateTime,
      //       foodItem: totalCalorie.foodItem
      //   );
      //   Hive.box<TotalCalorie>('totalCalorie').add(newAdd);
      //   state = [...state, newAdd];
      // }
      state = [
        for(final l in state) if(l== oldData) oldData else l
      ];

    }
    // final d = totalCalorie.foodItem.map((e) => e.dateTime).toList();
    // // print(d.join(', '));
    // if(DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString())) ==
    //     DateFormat('yyyy-MM-dd').format(DateTime.parse(totalCalorie.dateTime))
    // // DateFormat('yyyy-MM-dd').format(DateTime.parse(d.join(', ')))
    //     ){
    //   final newAdd = TotalCalorie(
    //       totalCalorie: totalCalorie.totalCalorie,
    //       dateTime: totalCalorie.dateTime,
    //       foodItem: totalCalorie.foodItem
    //   );
    //   Hive.box<TotalCalorie>('totalCalorie').add(newAdd);
    //   state = [...state, newAdd];
    // }

  }


//update food items
// String update(int index,FoodItem updateFoodItem){
//   state[index] = updateFoodItem;
//   final newFoodItem = FoodItem(
//       foodName: updateFoodItem.foodName,
//       calorie: updateFoodItem.calorie,
//       dateTime: updateFoodItem.dateTime
//   );
//   final box = Hive.box<FoodItem>('foodItem').put(index, newFoodItem);
//   state=[...state];
//   return 'Updated';
// }

//get total calories
//   int get total{
//     int total = 0;
//     for(final foodItem in state){
//       // print(foodItem.dateTime);
//       if(DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString())) == foodItem.dateTime){
//       total += foodItem.calorie;
//       }
//     }
//     return total;
//   }

//get total calories
  int get total{
    int total = 0;
    for(final foodItems in state){
      // print(foodItem.dateTime);
      if(DateFormat('yyyy-MM-dd').format(DateTime.parse(DateTime.now().toString())) == foodItems.dateTime){
      total += int.parse(foodItems.foodItem.map((e) => e.calorie).join(', ').toString());
      }
    }
    return total;
  }


}






//----------------------------------------------------------------
final addFoodItemProvider = StateNotifierProvider<AddFoodItemProvider, List<FoodItem>>((ref) => AddFoodItemProvider(ref.watch(box1)));

class AddFoodItemProvider extends StateNotifier<List<FoodItem>>{
  AddFoodItemProvider(super.state);

  //add
String addItem(FoodItem foodItem){
  final newFoodItem = FoodItem(
      foodName: foodItem.foodName,
      calorie: foodItem.calorie,
      dateTime: foodItem.dateTime);
  final box = Hive.box<FoodItem>('foodItem').add(newFoodItem);
  state = [...state, newFoodItem];
  return 'done';
}

}