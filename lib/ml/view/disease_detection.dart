import 'dart:convert';
import 'dart:io';
import 'package:app/ml/response/disease_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // For getting the filename

class DiseaseDetectionView extends StatefulWidget {
  @override
  _DiseaseDetectionViewState createState() => _DiseaseDetectionViewState();
}

class _DiseaseDetectionViewState extends State<DiseaseDetectionView> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  DiseaseInfo? _diseaseInfo;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    const String url = 'http://192.168.45.92:5000/predict/disease'; // Replace with your API URL

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _image!.path,
          filename: basename(_image!.path),
        ),
      );

      var response = await request.send();
      
      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
        final jsonResponse = jsonDecode(responseString);
        setState(() {
          _diseaseInfo = DiseaseInfo.fromJson(jsonResponse);
        });
      } else {
        print('Image upload failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred during image upload: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Detection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _image == null ? Text('No image selected.') : Image.file(_image!),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
              SizedBox(height: 16),
              if (_diseaseInfo != null) ...[
                Text('Disease Name: ${_diseaseInfo!.diseaseName}'),
                Text('Description: ${_diseaseInfo!.description}'),
                Text('Prevention: ${_diseaseInfo!.prevention}'),
                Text('Supplement: ${_diseaseInfo!.supplement}'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
