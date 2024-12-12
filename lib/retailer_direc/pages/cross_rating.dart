import 'package:cloud_firestore/cloud_firestore.dart';

class CrossCollectionRatingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Submit rating across multiple collections
  Future<bool> submitCrossCollectionRating({
    required String retailerId,
    required String farmerId,
    required String retailerOrderId,
    required String itemId,
    required int rating,
    String? reviewText,
  }) async {
    try {
      final retailerOrderRef = _firestore
          .collection('retailers')
          .doc(retailerId)
          .collection('orders')
          .doc(retailerOrderId);

      final farmerOrderQuery = await _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('orders')
          .where('itemID', isEqualTo: itemId)
          .limit(1)
          .get();

      if (farmerOrderQuery.docs.isEmpty) {
        throw Exception('Farmer order not found for itemID: $itemId');
      }

      final farmerOrderRef = farmerOrderQuery.docs.first.reference;

      final WriteBatch batch = _firestore.batch();
      final ratingData = {
        'rating': rating,
        'reviewText': reviewText ?? '',
        'ratedAt': FieldValue.serverTimestamp(),
        'retailerId': retailerId,
      };

      batch.update(retailerOrderRef, ratingData);
      batch.update(farmerOrderRef, ratingData);

      await batch.commit();
      return true;
    } catch (e) {
      print('Error submitting cross-collection rating: $e');
      return false;
    }
  }

  /// Retrieve rating for a specific order
  Future<Map<String, dynamic>?> getRatingByItemId({
    required String farmerId,
    required String itemId,
  }) async {
    try {
      final orderQuery = await _firestore
          .collection('farmer')
          .doc(farmerId)
          .collection('orders')
          .where('itemID', isEqualTo: itemId)
          .limit(1)
          .get();

      if (orderQuery.docs.isEmpty) return null;

      return orderQuery.docs.first.data() as Map<String, dynamic>;
    } catch (e) {
      print('Error retrieving rating: $e');
      return null;
    }
  }
}
