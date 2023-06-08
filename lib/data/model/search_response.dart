import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class SearchResponse {
  @HiveField(0) final String id;
  @HiveField(1) final String image;
  @HiveField(2) final String name;
  @HiveField(3) final String type;
  @HiveField(4) bool isBookmarked;

  SearchResponse(
      {required this.id,
      required this.image,
      required this.name,
      required this.type,
      required this.isBookmarked});
}
