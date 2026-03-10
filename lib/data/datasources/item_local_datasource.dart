import '../../core/database/database_helper.dart';
import '../models/item_model.dart';

class ItemLocalDatasource {

  Future<void> insertItem(ItemModel item) async {

    final db = await DatabaseHelper.instance.database;

    await db.insert(
      'items',
      item.toMap(),
    );

  }

  Future<List<ItemModel>> getItems() async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query('items');

    return result.map((e) => ItemModel.fromMap(e)).toList();

  }

  Future<void> deleteItem(int id) async {

    final db = await DatabaseHelper.instance.database;

    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );

  }

  Future<void> updateItem(
      int id,
      String name,
      double price,
      ) async {

    final db = await DatabaseHelper.instance.database;

    await db.update(
      'items',
      {
        'name': name,
        'price': price,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

  }
}