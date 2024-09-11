import 'dart:convert'; // For encoding the data to JSON
import 'package:http/http.dart' as http;

class DemandModel {
  String month1;
  String month2;
  String month3;
  String month4;

  DemandModel({
    required this.month1,
    required this.month2,
    required this.month3,
    required this.month4,
  });

  // Factory constructor to create an instance from JSON
  factory DemandModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> features = json['features'];
    return DemandModel(
      month1: features[0] as String,
      month2: features[1] as String,
      month3: features[2] as String,
      month4: features[3] as String,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'features': [month1, month2, month3, month4],
    };
  }

// Method to send the data to the API
Future<void> sendDataToAPI() async {
  const String url = 'http://172.16.45.31:5000/predict/demand'; // API URL

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
    } else {
      print('Failed to upload data: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}
}
