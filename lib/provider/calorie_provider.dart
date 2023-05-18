


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../main.dart';
import '../model/total calorie model/calorie.dart';



final calorieAddProvider =  StateNotifierProvider<CalorieProvider, List<TotalCalorie>>(
        (ref) => CalorieProvider(ref.watch(box1)));

class CalorieProvider  extends StateNotifier<List<TotalCalorie>>{
  CalorieProvider(super.state);


  // String add(TotalCalorie totalCalorie) {
  //   if (state.isNotEmpty) {
  //     final lastTotalCalorie = state.last;
  //
  //     if (lastTotalCalorie.dateTime == totalCalorie.dateTime) {
  //       // Add meal to the existing TotalCalorie object
  //       final newMealList = [...lastTotalCalorie.meal, ...totalCalorie.meal];
  //
  //       final updatedTotalCalorie = TotalCalorie(
  //         totalCalorie: lastTotalCalorie.totalCalorie + totalCalorie.totalCalorie,
  //         dateTime: lastTotalCalorie.dateTime,
  //         meal: newMealList,
  //       );
  //
  //       final box = Hive.box<TotalCalorie>('total_calorie');
  //       box.putAt(state.length - 1, updatedTotalCalorie);
  //
  //       state = [...state]..[state.length - 1] = updatedTotalCalorie;
  //       // state = [...state];
  //       print('meal added');
  //       return 'meal added';
  //     }
  //   }
  //
  //   // Create a new TotalCalorie object
  //   final newTotalCalorie = TotalCalorie(
  //     totalCalorie: totalCalorie.totalCalorie,
  //     dateTime: totalCalorie.dateTime,
  //     meal: totalCalorie.meal,
  //   );
  //
  //   final box = Hive.box<TotalCalorie>('total_calorie');
  //   box.add(newTotalCalorie);
  //   state = [...state, newTotalCalorie];
  //
  //   return 'Success';
  // }

//total calories calculate

  //add meals
  String add(TotalCalorie totalCalorie) {
    final matchingIndex = state.indexWhere((entry) => entry.dateTime == totalCalorie.dateTime);
    // print(matchingIndex);

    if (matchingIndex != -1) {
      // Add meal to the existing TotalCalorie object
      final existingTotalCalorie = state[matchingIndex];
      final newMealList = [...existingTotalCalorie.meal, ...totalCalorie.meal];

      final updatedTotalCalorie = TotalCalorie(
        totalCalorie: existingTotalCalorie.totalCalorie + totalCalorie.totalCalorie,
        dateTime: existingTotalCalorie.dateTime,
        meal: newMealList,
      );

      final box = Hive.box<TotalCalorie>('total_calorie');
      box.putAt(matchingIndex, updatedTotalCalorie);

      state = [...state]..[matchingIndex] = updatedTotalCalorie;

      print('Meal added');
      return 'meal added';
    }

    // Create a new TotalCalorie object
    final newTotalCalorie = TotalCalorie(
      totalCalorie: totalCalorie.totalCalorie,
      dateTime: totalCalorie.dateTime,
      meal: totalCalorie.meal,
    );

    final box = Hive.box<TotalCalorie>('total_calorie');
    box.add(newTotalCalorie);
    state = [...state, newTotalCalorie];

    return 'Success';
  }





  Map<String, int> calculateTotalCaloriesByDate() {
    final Map<String, int> totalCaloriesByDate = {};

    for (final totalCalorie in state) {
      final date = totalCalorie.dateTime;
      final totalCalories = totalCalorie.totalCalorie;

      if (totalCaloriesByDate.containsKey(date)) {
        totalCaloriesByDate[date] = totalCaloriesByDate[date]! + totalCalories;
      } else {
        totalCaloriesByDate[date] = totalCalories;
      }
    }

    return totalCaloriesByDate;
  }


}