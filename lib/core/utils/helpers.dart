import 'package:intl/intl.dart';


// formatPrice("1000.00"); // 1,000
// formatPrice("1000.50"); // 1,000.5
// formatPrice("1500000"); // 1,500,000
String formatAmount(String value) {
  final number = double.parse(value.replaceAll("\₱", ""));

  final formatter = NumberFormat("#,##0.##");

  return formatter.format(number);
}