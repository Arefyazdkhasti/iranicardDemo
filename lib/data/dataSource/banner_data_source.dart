
import 'package:dio/dio.dart';

import '../../common/http_response_validator.dart';
import '../model/BannerEntity.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('client/listProduct');
    validateResponse(response);
    final List<BannerEntity> banners = [];
    (response.data as List).forEach((jsonObject) {
     // banners.add(BannerEntity.fromJson(jsonObject));
    });
    return banners;
  }
}
