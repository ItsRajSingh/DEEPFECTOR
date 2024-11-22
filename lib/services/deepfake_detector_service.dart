import 'package:http/http.dart' as http;
import 'package:flutter/material.dart' show debugPrint;
import 'dart:convert';

class DeepfakeDetectorService {
  // You would host DeepSafe and use your server URL
  final String baseUrl = 'YOUR_DEEPSAFE_SERVER_URL';

  Future<Map<String, dynamic>> detectFromVideo(String videoPath) async {
    try {
      var uri = Uri.parse('$baseUrl/detect');
      var request = http.MultipartRequest('POST', uri);
      
      // Add the video file to the request
      request.files.add(
        await http.MultipartFile.fromPath('video', videoPath)
      );
      
      // Optional parameters
      request.fields.addAll({
        'model': 'CViT',  // You can choose from available models
        'processing_unit': 'CPU'
      });

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to analyze video: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during detection: $e');
      rethrow;
    }
  }

  Future<bool> isVideoReal(String videoPath) async {
    try {
      final result = await detectFromVideo(videoPath);
      
      // DeepSafe returns detailed analysis
      final isFake = result['is_fake'] as bool;
      final confidence = result['confidence'] as double;
      
      debugPrint('Detection confidence: $confidence');
      return !isFake;
    } catch (e) {
      debugPrint('Error determining if video is real: $e');
      rethrow;
    }
  }
}