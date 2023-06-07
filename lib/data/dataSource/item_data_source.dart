import 'package:dio/dio.dart';

import '../../common/http_response_validator.dart';
import '../model/ItemEntity.dart';

abstract class IItemDataSource {
  Future<List<ItemEntity>> getAllOnlineShopping();
  Future<List<ItemEntity>> getAllGiftCards();
}

class ItemRemoteDataSource
    with HttpResponseValidator
    implements IItemDataSource {
  final Dio httpClient;

  ItemRemoteDataSource(this.httpClient);
  @override
  Future<List<ItemEntity>> getAllOnlineShopping() async {
    final response = await httpClient.get('modules/Onlineshopping/v1/client/listProduct',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Cookie':
              '_gcl_au=1.1.42682892.1686034795; _gid=GA1.2.139659297.1686034796; analytics_campaign={%22source%22:%22google%22%2C%22medium%22:%22organic%22}; _clck=1qb2pdo|2|fc9|0|1252; customer_access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI2NDgwMmEyODE2MWQwMzE1YzMwN2ZmMzIiLCJqdGkiOiI1NWE1YTA4YzZkYWI2ZTg2MGUzOTY5YWViNmZlMTFlZmIzNzE2NDlkZmJhZGUwNjU2YzE2NzU4M2JmMWUzZjQzYzIxNGY1ZTI0YWQyMTdkOSIsImlhdCI6MTY4NjEyNDQxMC44NTQyMTYsIm5iZiI6MTY4NjEyNDQxMC44NTQyMjYsImV4cCI6MTcxNzc0NjgxMC44Mzc5MzUsInN1YiI6IjYyMjViNTQ3NjViNGFiNTM1NDQ5OGVhYyIsInNjb3BlcyI6W119.CwEtU0otXx7LqDZfPDP5Sc9pWFeAShP2ZK9a9jFPhual5wYdKYnNkPUqCSp6GXSBUUlXLhSvBBwNk4bUKOohwJqYQ2GdLcojWHi7qhUM6sXAP4wzEsfXGeshgDNYzNgii4tS_yD-hvxfePK7KRw1Eggp8_mnSEpyeIWtdcKc6VZH__CHp6XjfZVhqtfbRo3J4e6CzAadZLeOQkIxXzWagu8pF-dF6TddbUhMmESfhf1LZSx0Icstvn98YC2fCrp2BaMd5UPkqmcpbw-cFBpN1vBxowchqK0ObrqJ6SJ9Xdxb0fPoGIAdzuNkYJ4JFLxn8ZafmaIzwrmZOUaq33cGVYYAO5h0R_VbRykNIB7GqCSneUHSdbHUjk5Uk5Oc475bqPoHaT4MFwI7BjKAr7FU-KvBCr6w9lNNlLJGbZ5IPk6aQPnMuccxPDBs5eJhOYEGnvbwV3FDv2cGUm3XjJm4u_jktO-c9FcWmCUKNOAeI3C1FHY-i1M8kLK7NYOhY0qRaZlMMZEoCsIngZ9P-et5urUAek6uxCNGTZEd7iG9_B3shsJp-dHEv1nTVTGAqbxClW_gub_0XH5oll-T6Dzq2ZjPZQeVf4b30IPDblfPoqLHqzsw-K5Tb7sthEAwB4AL-fjOS7rUdg8_zbOJZUeR37-UwbsMrEYRcp6QR504A0I; _gat_UA-171257281-1=1; _ga=GA1.1.1785607716.1686034796; _ga_94SQ5MKLB2=GS1.1.1686128610.6.0.1686128610.60.0.0; _clsk=1mczwjo|1686128610751|2|1|r.clarity.ms/collect'
        }));
    validateResponse(response);
    final List<ItemEntity> items = [];
    for (var product in response.data['data']) {
      final String id = product["_id"] as String;
      final String title = product["name"] ?? "";
      final String subtitle = product["delivery_type"]?? "";
      final String url = product["medias_ratio16x9"][0]["url"] as String; 
      items.add(ItemEntity(id: id, imageUrl: url, subtitle: subtitle, title: title));
    }
    return items;
  }

  @override
  Future<List<ItemEntity>> getAllGiftCards() async {
    final response = await httpClient.get('modules/giftcard/v1/client/listProduct',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Cookie':
              '_gcl_au=1.1.42682892.1686034795; _gid=GA1.2.139659297.1686034796; analytics_campaign={%22source%22:%22google%22%2C%22medium%22:%22organic%22}; _clck=1qb2pdo|2|fc9|0|1252; customer_access_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI2NDgwMmEyODE2MWQwMzE1YzMwN2ZmMzIiLCJqdGkiOiI1NWE1YTA4YzZkYWI2ZTg2MGUzOTY5YWViNmZlMTFlZmIzNzE2NDlkZmJhZGUwNjU2YzE2NzU4M2JmMWUzZjQzYzIxNGY1ZTI0YWQyMTdkOSIsImlhdCI6MTY4NjEyNDQxMC44NTQyMTYsIm5iZiI6MTY4NjEyNDQxMC44NTQyMjYsImV4cCI6MTcxNzc0NjgxMC44Mzc5MzUsInN1YiI6IjYyMjViNTQ3NjViNGFiNTM1NDQ5OGVhYyIsInNjb3BlcyI6W119.CwEtU0otXx7LqDZfPDP5Sc9pWFeAShP2ZK9a9jFPhual5wYdKYnNkPUqCSp6GXSBUUlXLhSvBBwNk4bUKOohwJqYQ2GdLcojWHi7qhUM6sXAP4wzEsfXGeshgDNYzNgii4tS_yD-hvxfePK7KRw1Eggp8_mnSEpyeIWtdcKc6VZH__CHp6XjfZVhqtfbRo3J4e6CzAadZLeOQkIxXzWagu8pF-dF6TddbUhMmESfhf1LZSx0Icstvn98YC2fCrp2BaMd5UPkqmcpbw-cFBpN1vBxowchqK0ObrqJ6SJ9Xdxb0fPoGIAdzuNkYJ4JFLxn8ZafmaIzwrmZOUaq33cGVYYAO5h0R_VbRykNIB7GqCSneUHSdbHUjk5Uk5Oc475bqPoHaT4MFwI7BjKAr7FU-KvBCr6w9lNNlLJGbZ5IPk6aQPnMuccxPDBs5eJhOYEGnvbwV3FDv2cGUm3XjJm4u_jktO-c9FcWmCUKNOAeI3C1FHY-i1M8kLK7NYOhY0qRaZlMMZEoCsIngZ9P-et5urUAek6uxCNGTZEd7iG9_B3shsJp-dHEv1nTVTGAqbxClW_gub_0XH5oll-T6Dzq2ZjPZQeVf4b30IPDblfPoqLHqzsw-K5Tb7sthEAwB4AL-fjOS7rUdg8_zbOJZUeR37-UwbsMrEYRcp6QR504A0I; _gat_UA-171257281-1=1; _ga=GA1.1.1785607716.1686034796; _ga_94SQ5MKLB2=GS1.1.1686128610.6.0.1686128610.60.0.0; _clsk=1mczwjo|1686128610751|2|1|r.clarity.ms/collect'
        }));
    validateResponse(response);
    final List<ItemEntity> items = [];
    for (var product in response.data['data']) {
      final String id = product["_id"] as String;
      final String title = product["name"] ?? "";
      final String subtitle = product["slug"] ?? "";
      final String url = product["medias"][0]["url"] as String; 
      items.add(ItemEntity(id: id, imageUrl: url, subtitle: subtitle, title: title));
    }
    return items;
  }
}
