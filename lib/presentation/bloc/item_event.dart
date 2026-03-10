
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

class UpdateItemEvent extends ItemEvent {

  final int id;
  final String name;
  final double price;

  UpdateItemEvent(this.id, this.name, this.price);

}

class LoadItemsEvent extends ItemEvent {}

