import 'package:iranicard_demo/data/model/ItemEntity.dart';

import '../../common/http_client.dart';
import '../dataSource/item_data_source.dart';



final itemRepository = ItemRepository(ItemRemoteDataSource(httpClient));

abstract class IItemRepository {
  Future<List<ItemEntity>> getAllOnlineShopping();
  Future<List<ItemEntity>> getAllGiftCards();
}

class ItemRepository implements IItemRepository {
  final ItemRemoteDataSource dataSource;

  ItemRepository(this.dataSource);

  @override
  Future<List<ItemEntity>> getAllOnlineShopping() => dataSource.getAllOnlineShopping();
  @override
  Future<List<ItemEntity>> getAllGiftCards() => dataSource.getAllGiftCards();
}