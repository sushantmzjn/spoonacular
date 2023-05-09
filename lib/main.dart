import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spoonacular/model/calorie.dart';
import 'package:spoonacular/model/food_item.dart';
import 'package:spoonacular/view/dashboard_page.dart';

import 'model/favourite.dart';

//favourite box
final box = Provider<List<Favourite>>((ref) => []);
//foodItem box
final box1 = Provider<List<FoodItem>>((ref) => []);
//total calorie box
final box2 = Provider<List<TotalCalorie>>((ref) => []);


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
  ));
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteAdapter());
  Hive.registerAdapter(FoodItemAdapter());
  Hive.registerAdapter(TotalCalorieAdapter());
  final favouriteBox = await Hive.openBox<Favourite>('favourite');
  final foodItemBox = await Hive.openBox<FoodItem>('foodItem');
  final totalCalorieBox = await Hive.openBox<TotalCalorie>('totalCalorie');
  runApp(ProviderScope(
    overrides: [
      box.overrideWithValue(favouriteBox.values.toList()),
      box1.overrideWithValue(foodItemBox.values.toList()),
      box2.overrideWithValue(totalCalorieBox.values.toList())
    ],
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
              fontFamily: 'Nunito'
            ),
            home: DashBoard());
      },
    );
  }
}
