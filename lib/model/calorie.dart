import 'package:hive/hive.dart';

import 'food_item.dart';
part 'calorie.g.dart';

@HiveType(typeId: 2)
class TotalCalorie extends HiveObject {
  @HiveField(0)
  int totalCalorie;
  @HiveField(1)
  String dateTime;


  TotalCalorie({
    required this.totalCalorie,
    required this.dateTime
  });

  factory TotalCalorie.fromJson(Map<String, dynamic>json){
    return TotalCalorie(
        totalCalorie: json['totalCalorie']??'',
        dateTime: json['dateTime']??'',
    );
  }
}