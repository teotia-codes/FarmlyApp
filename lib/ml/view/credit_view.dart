import 'dart:convert';
import 'package:app/ml/data/credit_model.dart';
import 'package:app/ml/response/credit_response.dart'; // Import your text styling
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; // Replace with the actual path for CreditModel and CreditPredictionResponse

class CreditPredictionScreen extends StatefulWidget {
  @override
  _CreditPredictionScreenState createState() => _CreditPredictionScreenState();
}

class _CreditPredictionScreenState extends State<CreditPredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _cropQualityController = TextEditingController();
  final TextEditingController _landSizeController = TextEditingController();
  final TextEditingController _cibilScoreController = TextEditingController();
  final TextEditingController _ratingsController = TextEditingController();

  String? _predictionResult; // To store the prediction response
  bool _isLoading = false; // For loading state

  // Method to send data to the API and fetch prediction
  Future<void> _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      CreditModel creditModel = CreditModel(
        cropQuality: _cropQualityController.text,
        landSize: _landSizeController.text,
        cibilScore: _cibilScoreController.text,
        ratings: _ratingsController.text,
      );

      try {
        const String url =
            'http://192.168.45.92:5000/predict/credit'; // API URL

        var headers = {'Content-Type': 'application/json'};
        var body = jsonEncode(creditModel.toJson());

        var response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          CreditPredictionResponse predictionResponse =
              CreditPredictionResponse.fromJson(jsonResponse);

          setState(() {
            _predictionResult =
                'Predicted Credit: ${(predictionResponse.prediction[0] / 2).toStringAsFixed(0)}';
          });
        } else {
          setState(() {
            _predictionResult =
                'Failed to get prediction: ${response.statusCode}';
          });
        }
      } catch (e) {
        setState(() {
          _predictionResult = 'Error occurred: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Credit Prediction',
          style: TextPref.opensans.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.kBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Crop Quality input field
              TextFormField(
                controller: _cropQualityController,
                decoration: InputDecoration(
                  labelText: 'Crop Quality',
                  labelStyle: TextPref.opensans,
                  filled: true,
                  fillColor: AppColors.PaleYellow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.kSecondary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter crop quality';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Land Size input field
              TextFormField(
                controller: _landSizeController,
                decoration: InputDecoration(
                  labelText: 'Land Size',
                  labelStyle: TextPref.opensans,
                  filled: true,
                  fillColor: AppColors.PaleYellow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.kSecondary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter land size';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // CIBIL Score input field
              TextFormField(
                controller: _cibilScoreController,
                decoration: InputDecoration(
                  labelText: 'CIBIL Score',
                  labelStyle: TextPref.opensans,
                  filled: true,
                  fillColor: AppColors.PaleYellow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.kSecondary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter CIBIL score';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Ratings input field
              TextFormField(
                controller: _ratingsController,
                decoration: InputDecoration(
                  labelText: 'Ratings',
                  labelStyle: TextPref.opensans,
                  filled: true,
                  fillColor: AppColors.PaleYellow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.kSecondary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ratings';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator(
                      color: AppColors.Beige400,
                    ) // Show loading indicator when fetching data
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.Beige400, // Button background color
                        textStyle: TextPref.opensans.copyWith(
                          color: Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _submitData, // Submit data to API
                      child: Text('Get Prediction'),
                    ),
              SizedBox(height: 20),
              _predictionResult != null
                  ? Text(
                      _predictionResult!,
                      style: TextPref.opensans.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  : SizedBox(), // Display prediction result
            ],
          ),
        ),
      ),
    );
  }
}
