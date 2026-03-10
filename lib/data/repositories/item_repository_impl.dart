import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../datasources/item_local_datasource.dart';
import '../models/item_model.dart';

class ItemRepositoryImpl implements ItemRepository {

  final ItemLocalDatasource datasource;

  ItemRepositoryImpl(this.datasource);

  @override
  Future<void> addItem(Item item) async {

    final model = ItemModel(
      name: item.name,
      price: item.price,
    );

    await datasource.insertItem(model);

  }

  @override
  Future<List<Item>> getItems() async {

    final items = await datasource.getItems();

    return items;

  }

  @override
  Future<void> deleteItem(int id) async {
    await datasource.deleteItem(id);
  }

  @override
  Future<void> updateItem(int id, String name, double price) async{
    await datasource.updateItem(id, name, price);
  }
}