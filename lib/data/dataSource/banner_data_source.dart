import 'package:dio/dio.dart';

import '../../common/http_response_validator.dart';
import '../model/BannerEntity.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll(String accessTocken);
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll(String accessTocken) async {
    final response = await httpClient.get('v1/dashboardSections',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $accessTocken'
              }));
    validateResponse(response);
    final List<BannerEntity> banners = [];
    for (var newItem in response.data['data']['new_items']) {
      final product = newItem["product"];
      final String id = product["_id"] as String;
      final String url = product["medias"][0]["url"]as String;
      banners.add(BannerEntity(id: id, imageUrl: url));
    }
    return banners;
  }
}
