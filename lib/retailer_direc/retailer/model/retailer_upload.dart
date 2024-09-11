import 'package:app/retailer_direc/retailer/model/retailer_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UploadRetailerScreen extends StatelessWidget {
  final RetailerAccount retailerA = RetailerAccount(
    retailerId: "retailerA123",
    name: "Retailer A",
    email: "retailerA@example.com",
    gstin: "29ABCDE1234F2Z5", // Example GSTIN format
    phoneNumber: "+91-9876543210",
    address: "123 Market Street, Cityville, India",
  );

  // Function to upload retailer to Firestore
  Future<void> uploadRetailerToFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore
          .collection('retailers')
          .doc(retailerA.retailerId)
          .set(retailerA.toMap());
      print("Retailer uploaded successfully.");
    } catch (e) {
      print("Failed to upload retailer: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Retailer'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await uploadRetailerToFirestore();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Retailer uploaded successfully!')),
            );
          },
          child: const Text('Upload RetailerA to Firebase'),
        ),
      ),
    );
  }
}
