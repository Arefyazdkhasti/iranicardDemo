
  import 'package:hive/hive.dart';

import '../data/model/search_response.dart';

class SearchResponseAdapter extends TypeAdapter<SearchResponse> {
  @override
  final int typeId = 0;

  @override
  SearchResponse read(BinaryReader reader) {
    final id = reader.readString();
    final image = reader.readString();
    final name = reader.readString();
    final type = reader.readString();
    final isBookmarked = reader.readBool();
    return SearchResponse(
      id: id,
      image: image,
      name: name,
      type: type,
      isBookmarked: isBookmarked,
    );
  }

  @override
  void write(BinaryWriter writer, SearchResponse obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.image);
    writer.writeString(obj.name);
    writer.writeString(obj.type);
    writer.writeBool(obj.isBookmarked);
  }
}