import 'package:flutter_bloc/flutter_bloc.dart';
import 'item_event.dart';
import 'item_state.dart';
import '../../domain/repositories/item_repository.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {

  final ItemRepository repository;

  ItemBloc(this.repository) : super(const ItemState()) {

    // LOAD ITEMS FROM SQLITE
    on<LoadItemsEvent>((event, emit) async {

      final items = await repository.getItems();

      emit(ItemState(items: items));

    });

    // ADD ITEM
    on<AddItemEvent>((event, emit) async {

      await repository.addItem(event.item);

      final items = await repository.getItems();

      emit(ItemState(items: items));

    });

    on<DeleteItemEvent>((event, emit) async {

      await repository.deleteItem(event.id);

      final items = await repository.getItems();

      emit(ItemState(items: items));

    });

    on<UpdateItemEvent>((event, emit) async {

      await repository.updateItem(
        event.id,
        event.name,
        event.price,
      );

      final items = await repository.getItems();

      emit(ItemState(items: items));

    });

  }

}