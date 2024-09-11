import 'package:app/retailer_direc/retailer/model/retailer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class RetailerProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RetailerAccount? _currentRetailer;

  RetailerAccount? get currentRetailer => _currentRetailer;

  // Create or update retailer document in Firestore
  Future<void> createRetailer(RetailerAccount retailerAccount) async {
    try {
      await _firestore.collection('retailers').doc(retailerAccount.retailerId).set(
        retailerAccount.toMap(),
        SetOptions(merge: true), // Merge option ensures updates instead of overwrites
      );
      _currentRetailer = retailerAccount;
      notifyListeners(); // Notify listeners to update UI or data states
    } catch (e) {
      throw Exception("Error creating retailer: $e");
    }
  }

  // Fetch retailer document from Firestore by retailer ID
  Future<void> fetchRetailer(String retailerId) async {
    try {
      DocumentSnapshot retailerDoc = await _firestore.collection('retailers').doc(retailerId).get();
      if (retailerDoc.exists) {
        _currentRetailer = RetailerAccount.fromFirestore(retailerDoc);
        notifyListeners();
      }
    } catch (e) {
      throw Exception("Error fetching retailer: $e");
    }
  }

  // Update retailer details in Firestore
  Future<void> updateRetailer(RetailerAccount retailerAccount) async {
    try {
      await _firestore.collection('retailers').doc(retailerAccount.retailerId).update(
        retailerAccount.toMap(),
      );
      _currentRetailer = retailerAccount;
      notifyListeners();
    } catch (e) {
      throw Exception("Error updating retailer: $e");
    }
  }

  // Remove retailer from Firestore
  Future<void> deleteRetailer(String retailerId) async {
    try {
      await _firestore.collection('retailers').doc(retailerId).delete();
      _currentRetailer = null;
      notifyListeners();
    } catch (e) {
      throw Exception("Error deleting retailer: $e");
    }
  }
}
