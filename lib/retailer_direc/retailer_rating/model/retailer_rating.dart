import 'package:cloud_firestore/cloud_firestore.dart';

class RetailerRating {
  String retailerId;
  double rating;
  String reviewerId;
  Timestamp date;

  RetailerRating({
    required this.retailerId,
    required this.rating,
    required this.reviewerId,
    required this.date,
  });

  // Convert RetailerRating to Firebase document
  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'rating': rating,
      'reviewerId': reviewerId,
      'date': date,
    };
  }

  // Create RetailerRating from Firebase document
  factory RetailerRating.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return RetailerRating(
      retailerId: data['retailerId'] ?? '',
      rating: data['rating'] ?? 0.0,
      reviewerId: data['reviewerId'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}
