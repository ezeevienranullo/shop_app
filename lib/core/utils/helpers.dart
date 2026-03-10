import 'package:intl/intl.dart';

String formatPrice(double value) {
  final formatter = NumberFormat("#,##0.00");
  return formatter.format(value);
}