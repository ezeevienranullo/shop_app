import 'package:equatable/equatable.dart';
import '../../domain/entities/item.dart';

class ItemState extends Equatable {

  final List<Item> items;

  const ItemState({this.items = const []});

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalItems => items.length;

  @override
  List<Object> get props => [items];

}