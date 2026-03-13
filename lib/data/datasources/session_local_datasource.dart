import 'package:shop_app/data/models/session_model.dart';

import '../../core/database/database_helper.dart';

class SessionLocalDatasource {

  Future<void> insertSession(SessionModel session) async {

    final db = await DatabaseHelper.instance.database;
    await db.insert(
      'grocery_session',
      session.toMap(),
    );
  }

  Future<List<SessionModel>> getSessions() async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query('grocery_session');

    return result.map((e) => SessionModel.fromMap(e)).toList();

  }

  Future<void> deleteSession(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'grocery_session',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateSession(
      int id,
      String sessionId,
      String name,
      int totalItem,
      double totalPrice,
      DateTime date,
      ) async {

    final db = await DatabaseHelper.instance.database;

    await db.update(
      'grocery_session',
      {
        'session_id': sessionId,
        'name': name,
        'total_item': totalItem,
        'total_price': totalPrice,
        'date': date,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateItemsSession(String sessionId) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'items',
      {'session_id': sessionId},
      where: 'session_id IS NULL',
    );
  }
}