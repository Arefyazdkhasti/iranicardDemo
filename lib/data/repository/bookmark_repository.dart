

import 'package:iranicard_demo/data/model/search_response.dart';

import '../dataSource/bookmark_data_source.dart';

final bookmarkRepository = BookmarkRepository(BookmarkLocalDataSource());

abstract class IBookmarkRepository {
  Future<List<SearchResponse>> getBookmarks();
  Future<void> changeBookmardStatus(SearchResponse item);
}

class BookmarkRepository implements IBookmarkRepository {
  final IBookmarkDataSource dataSource;

  BookmarkRepository(this.dataSource);

  @override
  Future<List<SearchResponse>> getBookmarks() => dataSource.getBookmarks();

  @override
  Future<void> changeBookmardStatus(SearchResponse item) => dataSource.changeBookmardStatus(item);
}