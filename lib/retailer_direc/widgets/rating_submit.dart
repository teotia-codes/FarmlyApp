import 'package:cloud_firestore/cloud_firestore.dart';

class RatingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Submits a rating for a specific order in the Firestore database
  /// 
  /// [farmerId]: The ID of the farmer (e.g., 'farmerA123')
  /// [orderId]: The specific order document ID
  /// [rating]: Rating value (0-5)
  /// [review]: Optional review text
  Future<bool> submitOrderRating({
    required String farmerId,
    required String orderId,
    required int rating,
    String? review,
  }) async {
    try {
      // Reference to the specific order document
      DocumentReference orderRef = _firestore
          .collection('farmers')
          .doc("farmerA123")
          .collection('orders')
          .doc(orderId);

      // Update the rating field
      await orderRef.update({
        'rating': rating,
        // Add timestamp of rating
      });

      return true;
    } catch (e) {
      print('Error submitting rating: $e');
      return false;
    }
  }

  /// Calculates average rating for a farmer
  Future<double> calculateFarmerAverageRating(String farmerId) async {
    try {
      // Get all orders for the farmer
      QuerySnapshot ordersSnapshot = await _firestore
          .collection('farmers')
          .doc(farmerId)
          .collection('orders')
          .where('rating', isGreaterThan: 0)
          .get();

      // Calculate average rating
      if (ordersSnapshot.docs.isEmpty) return 0.0;

      double totalRating = 0.0;
      int ratedOrdersCount = 0;

      for (var doc in ordersSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['rating'] != null && data['rating'] > 0) {
          totalRating += data['rating'];
          ratedOrdersCount++;
        }
      }

      return totalRating / ratedOrdersCount;
    } catch (e) {
      print('Error calculating average rating: $e');
      return 0.0;
    }
  }
}