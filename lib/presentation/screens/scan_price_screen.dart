import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ScanPriceScreen extends StatefulWidget {
  const ScanPriceScreen({super.key});

  @override
  State<ScanPriceScreen> createState() => _ScanPriceScreenState();
}

class _ScanPriceScreenState extends State<ScanPriceScreen> {

  CameraController? controller;
  late List<CameraDescription> cameras;
  bool isLoading = true;

  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {

    cameras = await availableCameras();

    controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await controller!.initialize();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> scanPrice() async {

    final picture = await controller!.takePicture();

    final inputImage = InputImage.fromFilePath(picture.path);

    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    final price = extractLargestPrice(recognizedText.text);

    if (!mounted) return;

    Navigator.pop(context, price);
  }

  double? extractLargestPrice(String text) {

    final regex = RegExp(r'₱?\s*\d+(\.\d{1,2})?');

    final matches = regex.allMatches(text);

    List<double> prices = [];

    for (var m in matches) {

      final value = m.group(0)!
          .replaceAll("₱", "")
          .trim();

      prices.add(double.parse(value));
    }

    if (prices.isEmpty) return null;

    prices.sort();

    return prices.last;
  }
  @override
  void dispose() {
    controller?.dispose();
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading || controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

      appBar: AppBar(title: const Text("Scan Price")),

      body: Stack(
        children: [

          CameraPreview(controller!),

          Center(
            child: Container(
              width: 250,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 3),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: scanPrice,
                child: const Text("Capture Price"),
              ),
            ),
          ),

        ],
      ),
    );
  }
}