import 'dart:convert'; // For encoding the data to JSON
import 'package:http/http.dart' as http;

class DemandModel {
  String day15;
  String day30;
  String day45;
  String day60;

  DemandModel({
    required this.day15,
    required this.day30,
    required this.day45,
    required this.day60,
  });

  // Factory constructor to create an instance from JSON
  factory DemandModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> features = json['features'];
    return DemandModel(
      day15: features[0] as String,
      day30: features[1] as String,
      day45: features[2] as String,
      day60: features[3] as String,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'features': [day15, day30, day45, day60],
    };
  }

  // Method to send the data to the API
  Future<void> sendDataToAPI() async {
    const String url = 'http://192.168.45.92:5000/predict/demand'; // API URL

    try {
      var headers = {'Content-Type': 'application/json'};

      // Convert the DemandModel to JSON format
      var body = jsonEncode(this.toJson());

      // Make the POST request
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      // Handle the response
      if (response.statusCode == 200) {
        print('Data uploaded successfully');
        print('Response body: ${response.body}');
        // Process the prediction result from the response
        // e.g., show a dialog or store the result in the UI state
      } else {
        print('Failed to upload data: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
