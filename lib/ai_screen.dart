import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});
  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  File? _image;
  String _label = '';
  double _confidence = 0;
  bool _isLoading = false;

  final String apiUrl = '';

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    setState(() {
      _image = File(picked.path);
      _label = '';
      _confidence = 0;
    });

    await sendToBackend(_image!);
  }

  Future<void> sendToBackend(File imageFile) async {
    setState(() => _isLoading = true);

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();
    final body = await response.stream.bytesToString();
    final data = jsonDecode(body);

    setState(() {
      _label = data['label'];
      _confidence = data['confidence'].toDouble();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Object Recognizer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_image != null) Image.file(_image!, height: 300),
          if (_isLoading) const CircularProgressIndicator(),
          if (_label.isNotEmpty) ...[
            Text(_label, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Confidence: ${_confidence.toStringAsFixed(1)}%'),
            LinearProgressIndicator(value: _confidence / 100),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.camera),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
              ),
              ElevatedButton.icon(
                onPressed: () => pickImage(ImageSource.gallery),
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
