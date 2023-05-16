import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:spoonacular/view/dashboard_page.dart';

import 'model/favourite.dart';
import 'model/meal model/meal.dart';
import 'model/total calorie model/calorie.dart';

//favourite box
final box = Provider<List<Favourite>>((ref) => []);
//calorie box
final box1 = Provider<List<TotalCalorie>>((ref) => []);
//meal box
final box2 = Provider<List<Meal>>((ref) => []);



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // statusBarIconBrightness: Brightness.dark,
  ));
  await Hive.initFlutter();
  Hive.registerAdapter(FavouriteAdapter());
  Hive.registerAdapter(TotalCalorieAdapter());
  Hive.registerAdapter(MealAdapter());
  final favouriteBox = await Hive.openBox<Favourite>('favourite');
  final calorieBox =await Hive.openBox<TotalCalorie>('total_calorie');
  final mealBox =await Hive.openBox<Meal>('meal');

  // print(totalCalorieBox.isEmpty);
  runApp(ProviderScope(
    overrides: [
      box.overrideWithValue(favouriteBox.values.toList()),
      box1.overrideWithValue(calorieBox.values.toList()),
      box2.overrideWithValue(mealBox.values.toList()),
    ],
      child: MyApp()));
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
