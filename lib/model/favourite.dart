import 'package:hive/hive.dart';
part 'favourite.g.dart';

@HiveType(typeId: 1)
class Favourite extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String image;

  Favourite({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Favourite.fromJson(Map<String, dynamic> json) {
    return Favourite(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        image: json['image'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'image': this.image,
    };
  }
}
