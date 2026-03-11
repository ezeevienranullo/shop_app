import '../../domain/entities/item.dart';

class ItemModel extends Item {

  final int? id;

  ItemModel({
    this.id,
    required super.name,
    required super.price,
    required super.totalPrice,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'name': name,
      'price': price,
      'total_price': totalPrice,
      'quantity': quantity,
    };

  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {

    return ItemModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      totalPrice: map['total_price'],
      quantity: map['quantity'],
    );

  }

}