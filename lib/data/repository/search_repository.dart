
import 'package:iranicard_demo/data/dataSource/seach_data_source.dart';
import 'package:iranicard_demo/data/model/search_query.dart';
import 'package:iranicard_demo/data/model/search_response.dart';

import '../../common/http_client.dart';

final searchRepository = SearchRepository(SearchRemoteDataSource(httpClient));

abstract class ISearchRepository {
  Future<List<SearchResponse>> getResult(SearchQuery searchQuery,String accessTocken);
}

class SearchRepository implements ISearchRepository {
  final ISearchDataSource dataSource;

  SearchRepository(this.dataSource);

  @override
  Future<List<SearchResponse>> getResult(SearchQuery searchQuery,String accessTocken) => dataSource.getResult(searchQuery,accessTocken);
}