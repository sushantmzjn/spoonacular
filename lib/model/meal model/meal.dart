import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  String name;
  @HiveField(1)
  int calorie;
  @HiveField(2)
  String dateTime;

  Meal({
    required this.name,
    required this.calorie,
    required this.dateTime,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      name: json['name'],
      calorie: json['calorie'],
      dateTime: json['dateTime'],
    );
  }
}
