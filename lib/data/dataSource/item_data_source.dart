import 'package:dio/dio.dart';

import '../../common/http_response_validator.dart';
import '../model/ItemEntity.dart';

abstract class IItemDataSource {
  Future<List<ItemEntity>> getAllOnlineShopping(String accessTocken);
  Future<List<ItemEntity>> getAllGiftCards(String accessTocken);
}

class ItemRemoteDataSource
    with HttpResponseValidator
    implements IItemDataSource {
  final Dio httpClient;

  ItemRemoteDataSource(this.httpClient);
  @override
  Future<List<ItemEntity>> getAllOnlineShopping(String accessTocken) async {
    final response =
        await httpClient.get('modules/Onlineshopping/v1/client/listProduct',
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': '*/*',
              'Authorization': 'Bearer $accessTocken'
            }));
    validateResponse(response);

    final List<ItemEntity> items = [];
    for (var product in response.data['data']) {
      final String id = product["_id"] as String;
      final String title = product["name"] ?? "";
      final String subtitle = product["delivery_type"] ?? "";
      final String url = product["medias_ratio16x9"][0]["url"] as String;
      items.add(
          ItemEntity(id: id, imageUrl: url, subtitle: subtitle, title: title));
    }
    return items;
  }

  @override
  Future<List<ItemEntity>> getAllGiftCards(String accessTocken) async {
    final response = await httpClient.get(
        'modules/giftcard/v1/client/listProduct',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessTocken'
        }));
    validateResponse(response);
    final List<ItemEntity> items = [];
    for (var product in response.data['data']) {
      final String id = product["_id"] as String;
      final String title = product["name"] ?? "";
      final String subtitle = product["slug"] ?? "";
      final String url = product["medias"][0]["url"] as String;
      items.add(
          ItemEntity(id: id, imageUrl: url, subtitle: subtitle, title: title));
    }
    return items;
  }
}
