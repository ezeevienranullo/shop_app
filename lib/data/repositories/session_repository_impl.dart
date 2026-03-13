import '../../domain/entities/session.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_datasource.dart';
import '../models/session_model.dart';

class SessionRepositoryImpl implements SessionRepository {

  final SessionLocalDatasource datasource;

  SessionRepositoryImpl(this.datasource);

  @override
  Future<void> addSession(Session item) async {

    final model = SessionModel(
      name: item.name,
      sessionId: item.sessionId,
      totalItem: item.totalItem,
      totalPrice: item.totalPrice,
      date: item.date,
    );

    await datasource.insertSession(model);
  }

  @override
  Future<List<Session>> getSessions() async {

    final sessions = await datasource.getSessions();

    return sessions;

  }

  @override
  Future<void> deleteSession(int id) async {
    await datasource.deleteSession(id);
  }

  @override
  Future<void> updateSession(int id, String sessionId, String name, int totalItem, double totalPrice, DateTime date) async{
    await datasource.updateSession(id,sessionId, name, totalItem, totalPrice, date);
  }

  @override
  Future<void> updateItemsSession(String sessionId) async {
      await datasource.updateItemsSession(sessionId);
    }
  }