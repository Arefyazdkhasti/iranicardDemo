class SearchResponse {
  final String id;
  final String image;
  final String name;
  final String type;
  bool isBookmarked;

  SearchResponse(
      {required this.id,
      required this.image,
      required this.name,
      required this.type,
      required this.isBookmarked});
}
