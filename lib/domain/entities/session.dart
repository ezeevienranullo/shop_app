class Session {
  final int? id;
  final String sessionId;
  final String name;
  final DateTime date;
  final int totalItem;
  final double totalPrice;

  Session({
    this.id,
    required this.name,
    required this.sessionId,
    required this.date,
    required this.totalItem,
    required this.totalPrice,
  });
}