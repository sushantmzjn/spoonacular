import 'package:hive/hive.dart';
part 'food_item.g.dart';

@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  @HiveField(0)
  String foodName;
  @HiveField(1)
  int calorie;
  @HiveField(2)
  String dateTime;

  FoodItem({
    required this.foodName,
    required this.calorie,
    required this.dateTime,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      foodName: json['foodName'] ?? '',
      calorie: json['calorie'] ?? '',
      dateTime: json['dateTime'] ?? '',
    );
  }
}
