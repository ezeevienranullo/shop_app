
import 'package:equatable/equatable.dart';
import '../../domain/entities/session.dart';

abstract class SessionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddSessionEvent extends SessionEvent {

  final Session session;

  AddSessionEvent(this.session);

}

class DeleteSessionEvent extends SessionEvent {
  final int id;

  DeleteSessionEvent(this.id);
}

class UpdateSessionEvent extends SessionEvent {

  final int id;
  final String name;
  final String sessionId;
  final int totalItem;
  final double totalPrice;
  final DateTime dateTime;

  UpdateSessionEvent(this.id, this.sessionId, this.name, this.totalItem, this.totalPrice, this.dateTime);

}

class UpdateItemsSessionEvent extends SessionEvent {
  final String sessionId;

  UpdateItemsSessionEvent(this.sessionId);
}

class LoadSessionsEvent extends SessionEvent {}

