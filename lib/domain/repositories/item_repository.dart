import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> addItem(Item item);
  Future<void> deleteItem(int id);
  Future<void> deleteItemBySessionId(String sessionId);
  Future<void> updateItem(int id, String name, double price, double totalPrice, double quantity);
  Future<void> clearItems();
  Future<List<Item>> getItemsBySession(String sessionId);
}