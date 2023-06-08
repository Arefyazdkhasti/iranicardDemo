import 'package:iranicard_demo/data/model/ItemEntity.dart';

import '../../common/http_client.dart';
import '../dataSource/item_data_source.dart';



final itemRepository = ItemRepository(ItemRemoteDataSource(httpClient));

abstract class IItemRepository {
  Future<List<ItemEntity>> getAllOnlineShopping(String accessTocken);
  Future<List<ItemEntity>> getAllGiftCards(String accessTocken);
}

class ItemRepository implements IItemRepository {
  final ItemRemoteDataSource dataSource;

  ItemRepository(this.dataSource);

  @override
  Future<List<ItemEntity>> getAllOnlineShopping(String accessTocken) => dataSource.getAllOnlineShopping(accessTocken);
  @override
  Future<List<ItemEntity>> getAllGiftCards(String accessTocken) => dataSource.getAllGiftCards(accessTocken);
}