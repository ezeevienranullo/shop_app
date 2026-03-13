import 'package:shop_app/domain/entities/session.dart';

abstract class SessionRepository {
  Future<List<Session>> getSessions();
  Future<void> addSession(Session session);
  Future<void> deleteSession(int id);
  Future<void> updateSession(int id,String sessionId, String name, int totalItem, double totalPrice, DateTime dateTime);
  Future<void> updateItemsSession(String id);
}