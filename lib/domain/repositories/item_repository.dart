import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> addItem(Item item);
  Future<void> deleteItem(int id);
  Future<void> updateItem(int id, String name, double price, double totalPrice, double quantity);
}