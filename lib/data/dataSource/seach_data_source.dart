import 'package:dio/dio.dart';
import 'package:iranicard_demo/common/exception.dart';
import 'package:iranicard_demo/data/model/search_query.dart';

import '../../common/http_response_validator.dart';
import '../model/search_response.dart';

abstract class ISearchDataSource {
  Future<List<SearchResponse>> getResult(
      SearchQuery searchQuery, String accessTocken);
}

class SearchRemoteDataSource
    with HttpResponseValidator
    implements ISearchDataSource {
  final Dio httpClient;

  SearchRemoteDataSource(this.httpClient);
  @override
  Future<List<SearchResponse>> getResult(
      SearchQuery searchQuery, String accessTocken) async {
    final response = await httpClient.get('v1/advance-search',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessTocken'
        }),
        data: {
          'keyword': searchQuery.keyword,
        });

    final List<SearchResponse> results = [];

    if (response.statusCode == 422) {
      String message = response.data['message'];
      throw AppException(message: message);
    } else {
      validateResponse(response); //check for 200 reposnse code
      int index = 0;
      for (var product in response.data['data']) {
        if (index >= 20) break;
        index += 1;

        final String id = product["product_id"];
        final String url = product["medias"][0]["url"];
        final String name = product["product_name"];
        final String type = product["category_name"] ?? "";

        results.add(SearchResponse(
            id: id, image: url, name: name, type: type, isBookmarked: false));
      }
    }
    return results;
  }
}
