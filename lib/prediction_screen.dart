// ignore_for_file: avoid_print, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  File? _image;
  String _label = '';
  double _confidence = 0;
  bool _isLoading = false;
  String _errorMessage = '';
  List<Map<String, dynamic>> _allDetections = [];
  final ImagePicker _picker = ImagePicker();

  // IP and Port
  final String _apiUrl = 'http://192.168.0.213:5001/predict';

  Future<void> _pickAndPredict(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      imageQuality: 85, // compress slightly to speed up upload
    );
    if (picked == null) return;

    setState(() {
      _image = File(picked.path);
      _label = '';
      _confidence = 0;
      _errorMessage = '';
      _allDetections = [];
      _isLoading = true;
    });

    await _sendToFlask(File(picked.path));
  }

  Future<void> _sendToFlask(File imageFile) async {
    try {
      // Build the multipart request
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );

      print('Sending request to: $_apiUrl');

      // Send and wait for response (30 second timeout)
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
      );
      final response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Parse all detections
        List<Map<String, dynamic>> detections = [];
        if (data['detections'] != null) {
          for (var det in data['detections']) {
            detections.add({
              'label': det['label'] ?? 'Unknown',
              'confidence': (det['confidence'] ?? 0.0).toDouble(),
              'class_id': det['class_id'] ?? -1,
            });
          }
        }

        setState(() {
          _label = data['label'] ?? 'Unknown';
          _confidence = (data['confidence'] ?? 0.0).toDouble();
          _allDetections = detections;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Server error: ${response.statusCode}\n\nBody: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Connection failed: $e\n\nMake sure Flask is running at $_apiUrl';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Knowing AI',
            style: TextStyle(
              letterSpacing: 1.2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            'Detection App (YOLOv8 Model)',
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1.2,
              color: Colors.yellowAccent[400],
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            //** Image preview
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(_image!, fit: BoxFit.cover),
                    )
                  : const Center(
                      child: Text(
                        'No image selected',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            //** Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        _isLoading ? Colors.grey : Colors.black,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        _isLoading ? Colors.white70 : Colors.white,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () => _pickAndPredict(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        _isLoading ? Colors.grey : Colors.blue,
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        _isLoading ? Colors.white70 : Colors.white,
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () => _pickAndPredict(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            //** Result area
            if (_isLoading)
              const Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Processing image...'),
                ],
              ),

            if (_errorMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red),
                ),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            if (_label.isNotEmpty && !_isLoading) ...[
              // Top result
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Top Detection',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _label,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Confidence: ${_confidence.toStringAsFixed(2)}%',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _confidence / 100,
                        minHeight: 12,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _confidence > 70
                              ? Colors.green
                              : _confidence > 40
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // All detections list
              if (_allDetections.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text(
                  'All Detections (${_allDetections.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _allDetections.length,
                  itemBuilder: (context, index) {
                    final detection = _allDetections[index];
                    final confidence = detection['confidence'] as double;
                    final label = detection['label'] as String;
                    final isTop = index == 0;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isTop ? Colors.green[50] : Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isTop ? Colors.green : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isTop
                                              ? Colors.green[700]
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    if (isTop)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: const Text(
                                          'TOP',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Confidence: ${confidence.toStringAsFixed(2)}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: confidence / 100,
                                    minHeight: 8,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      confidence > 70
                                          ? Colors.green
                                          : confidence > 40
                                          ? Colors.orange
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ] else ...[
                const SizedBox(height: 12),
                const Text(
                  ' No other detections found',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
