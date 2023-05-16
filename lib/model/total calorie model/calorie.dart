import 'package:hive/hive.dart';
import '../meal model/meal.dart';
part 'calorie.g.dart';


@HiveType(typeId: 2)
class TotalCalorie {
  @HiveField(0)
  int totalCalorie;
  @HiveField(1)
  String dateTime;
  @HiveField(2)
  List<Meal> meal;

  TotalCalorie({
    required this.totalCalorie,
    required this.dateTime,
    required this.meal
  });

  factory TotalCalorie.fromJson(Map<String, dynamic> json) {
    return TotalCalorie(
      totalCalorie: json['totalCalorie'],
      dateTime: json['dateTime'],
      meal: json['meal'],
    );
  }
}
