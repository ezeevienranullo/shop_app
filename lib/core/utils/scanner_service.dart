import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerService {

  static String parseBarcode(String code) {

    // Example mapping
    if (code == "12345") {
      return "Apple";
    }

    if (code == "67890") {
      return "Orange";
    }

    return "Unknown Item";

  }

}