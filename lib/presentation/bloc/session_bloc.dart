import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/domain/repositories/session_repository.dart';
import 'package:shop_app/presentation/bloc/session_event.dart';
import 'package:shop_app/presentation/bloc/session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {

  final SessionRepository repository;

  SessionBloc(this.repository) : super(const SessionState()) {

    // LOAD SESSION FROM SQLITE
    on<LoadSessionsEvent>((event, emit) async {

      final sessions = await repository.getSessions();

      emit(SessionState(sessions: sessions));

    });

    // ADD SESSION
    on<AddSessionEvent>((event, emit) async {

      await repository.addSession(event.session);

      final session = await repository.getSessions();

      emit(SessionState(sessions: session));

    });

    on<DeleteSessionEvent>((event, emit) async {

      await repository.deleteSession(event.id);

      final sessions = await repository.getSessions();
      emit(SessionState(sessions: sessions));
    });

    on<UpdateSessionEvent>((event, emit) async {

      await repository.updateSession(
        event.id,
        event.sessionId,
        event.name,
        event.totalItem,
        event.totalPrice,
        event.dateTime,
      );

      final sessions = await repository.getSessions();

      emit(SessionState(sessions: sessions));

    });

    on<UpdateItemsSessionEvent>((event, emit) async {

      await repository.updateItemsSession(event.sessionId);

      final sessions = await repository.getSessions();

      emit(SessionState(sessions: sessions));

    });

  }
}