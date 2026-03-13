import 'package:shop_app/domain/entities/session.dart';


class SessionModel extends Session {

  final int? id;

  SessionModel({
    this.id,
    required super.name,
    required super.sessionId,
    required super.date,
    required super.totalItem,
    required super.totalPrice,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'session_id': sessionId,
      'name': name,
      'total_item': totalItem,
      'total_price': totalPrice,
      'date': date.toIso8601String(),
    };

  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {

    final rawDate = map['date'];

    DateTime parsedDate;

    if (rawDate is String) {
      parsedDate = DateTime.parse(rawDate);
    } else if (rawDate is int) {
      parsedDate = DateTime.fromMillisecondsSinceEpoch(rawDate);
    } else {
      parsedDate = DateTime.now();
    }

    return SessionModel(
      id: map['id'],
      name: map['name'],
      sessionId: map['session_id'],
      date: parsedDate,
      totalItem: map['total_item'],
      totalPrice: map['total_price'],
    );

  }

}