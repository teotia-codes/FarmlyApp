import 'package:app/farmer_direc/dashboard/model/exampleFarmer.dart';
import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/provider/farmer/farmer_provider.dart';
import 'package:flutter/material.dart';

class UploadFarmersToFirestore extends StatelessWidget {
  final FarmerProvider farmerProvider = FarmerProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Farmers'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _uploadFarmers();
          },
          child: Text('Upload Farmers to Firestore'),
        ),
      ),
    );
  }

  Future<void> _uploadFarmers() async {
    try {
      List<FarmerModel> farmers = [
        exampleFarmer1,
        exampleFarmer2,
        exampleFarmer3,
        exampleFarmer4,
        exampleFarmer5,
        exampleFarmer6,
        exampleFarmer7,
        exampleFarmer8,
        exampleFarmer9,
        exampleFarmer10,
      ];

      for (FarmerModel farmer in farmers) {
        await farmerProvider.addFarmer(farmer);
      }

      print("All farmers uploaded successfully.");
    } catch (e) {
      print("Error uploading farmers: $e");
    }
  }
}
