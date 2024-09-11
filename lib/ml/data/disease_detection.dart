import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For getting the filename

class DiseaseDetection {
  File image;

  DiseaseDetection({required this.image});

  // Method to upload the image file
  Future<void> uploadImage(String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Attach the image file in form-data with the key 'image'
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
        filename: basename(image.path), // Optional: Use to set a filename
      ),
    );

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed: ${response.statusCode}');
    }
  }
}
