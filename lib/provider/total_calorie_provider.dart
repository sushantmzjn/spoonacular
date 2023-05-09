

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:spoonacular/model/calorie.dart';


import '../main.dart';

final totalCalorieProvider = StateNotifierProvider<TotalCalorieProvider, List<TotalCalorie>>((ref) => TotalCalorieProvider(ref.watch(box2)));

class TotalCalorieProvider extends StateNotifier<List<TotalCalorie>>{
  TotalCalorieProvider(super.state);

  //add
void addCalorie(TotalCalorie calorie){
  final newTotalCalorie = TotalCalorie(
      totalCalorie: calorie.totalCalorie,
      dateTime: calorie.dateTime, foodItem: []
  );
  final box = Hive.box<TotalCalorie>('totalCalorie').add(newTotalCalorie);
  state = [...state, newTotalCalorie];
}

//update
void totalCalorieUpdate(int index,TotalCalorie updateTotalCalorie){
  state[index] = updateTotalCalorie;
  final updateTotal = TotalCalorie(
      totalCalorie: updateTotalCalorie.totalCalorie,
      dateTime: updateTotalCalorie.dateTime, foodItem: []
  );
  final box= Hive.box<TotalCalorie>('totalCalorie').put(index, updateTotal);
  state=[...state];
}

}