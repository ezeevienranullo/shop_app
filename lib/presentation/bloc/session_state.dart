import 'package:equatable/equatable.dart';
import 'package:shop_app/domain/entities/session.dart';

class SessionState extends Equatable {

  final List<Session> sessions;

  const SessionState({this.sessions = const []});

  double get totalPrice =>
      sessions.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalSessions => sessions.length;

  @override
  List<Object> get props => [sessions];

}