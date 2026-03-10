import '../../domain/entities/item.dart';

class ItemModel extends Item {

  final int? id;

  ItemModel({
    this.id,
    required super.name,
    required super.price,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'name': name,
      'price': price,
    };

  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {

    return ItemModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );

  }

}