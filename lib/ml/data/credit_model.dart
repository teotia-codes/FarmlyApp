import 'dart:convert'; // For encoding the data to JSON
import 'package:http/http.dart' as http;

class CreditModel {
  String cropQuality;
  String landSize;
  String cibilScore;
  String ratings;

  CreditModel({
    required this.cropQuality,
    required this.landSize,
    required this.cibilScore,
    required this.ratings,
  });

  // Factory constructor to create an instance from JSON
  factory CreditModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> features = json['features'];
    return CreditModel(
      cropQuality: features[0] as String,
      landSize: features[1] as String,
      cibilScore: features[2] as String,
      ratings: features[3] as String,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'features': [cropQuality, landSize, cibilScore, ratings],
    };
  }

  // Method to send the data to the API
  Future<void> sendDataToAPI() async {
    const String url =
        'http://192.168.45.92:5000/predict/credit'; // API URL for credit prediction

    try {
      var headers = {'Content-Type': 'application/json'};

      // Convert the CreditModel to JSON format
      var body = jsonEncode(this.toJson());

      // Make the POST request
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Credit data uploaded successfully');
        print('Response body: ${response.body}');
      } else {
        print('Failed to upload credit data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
