import 'package:hive/hive.dart';

import '../../common/http_response_validator.dart';
import '../model/search_response.dart';

abstract class IBookmarkDataSource {
  Future<List<SearchResponse>> getBookmarks();
  Future<void> changeBookmardStatus(SearchResponse item);
}

class BookmarkLocalDataSource
    with HttpResponseValidator
    implements IBookmarkDataSource {
  @override
  Future<List<SearchResponse>> getBookmarks() async {
    final box = await Hive.openBox<SearchResponse>('bookmarks');
    List<SearchResponse> bookmarks =
        box.values.where((item) => item.isBookmarked).toList();
    return bookmarks;
  }

  @override
  Future<void> changeBookmardStatus(SearchResponse item) async {
    final box = await Hive.openBox<SearchResponse>('bookmarks');
    if (item.isBookmarked) {
      await box.put(item.id, item);
    } else {
      await box.delete(item.id);
    }
  }
}
