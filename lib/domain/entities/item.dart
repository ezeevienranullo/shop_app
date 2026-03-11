class Item {
  final int? id;
  final String name;
  final double price;
  final double totalPrice;
  final double quantity;

  Item({
    this.id,
    required this.name,
    required this.price,
    required this.totalPrice,
    required this.quantity,
  });
}