import '../../domain/entities/item.dart';

class ItemModel extends Item {

  final int? id;
  final String? sessionId;

  ItemModel({
    this.id,
    this.sessionId,
    required super.name,
    required super.price,
    required super.totalPrice,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'session_id': sessionId,
      'name': name,
      'price': price,
      'total_price': totalPrice,
      'quantity': quantity,
    };

  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {

    return ItemModel(
      id: map['id'],
      sessionId: map['session_id'],
      name: map['name'],
      price: map['price'],
      totalPrice: map['total_price'],
      quantity: map['quantity'],
    );

  }

}