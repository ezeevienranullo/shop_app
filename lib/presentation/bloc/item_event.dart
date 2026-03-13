
import '../../domain/entities/item.dart';
import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddItemEvent extends ItemEvent {

  final Item item;

  AddItemEvent(this.item);

}

class DeleteItemEvent extends ItemEvent {
  final int id;
  DeleteItemEvent(this.id);
}

class DeleteItemBySessionIdEvent extends ItemEvent {
  final String sessionId;
  DeleteItemBySessionIdEvent(this.sessionId);
}

class UpdateItemEvent extends ItemEvent {

  final int id;
  final String name;
  final double price;
  final double totalPrice;
  final double quantity;

  UpdateItemEvent(this.id, this.name, this.price, this.totalPrice, this.quantity);

}
class ClearItemsEvent extends ItemEvent {}

class LoadItemsBySessionEvent extends ItemEvent {
  final String sessionId;
  LoadItemsBySessionEvent(this.sessionId);
}

class LoadItemsEvent extends ItemEvent {}

