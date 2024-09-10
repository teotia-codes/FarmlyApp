import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFarmer(FarmerModel farmer) async {
    try {
      await _firestore.collection('farmers').doc(farmer.id).set(farmer.toFirestore());
      notifyListeners();  // Notify listeners to update UI or perform actions
    } catch (e) {
      print("Failed to add farmer: $e");
      // Handle errors as needed
    }
  }

  Future<FarmerModel?> getFarmer(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('farmers').doc(id).get();
      if (doc.exists) {
        return FarmerModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Failed to get farmer: $e");
    }
    return null;
  }
}
