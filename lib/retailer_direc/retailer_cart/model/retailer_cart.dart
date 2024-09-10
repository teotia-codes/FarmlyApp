import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  // Convert CartItem to Firebase document
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }

  // Create CartItem from Firebase document
  factory CartItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CartItem(
      productId: data['productId'] ?? '',
      quantity: data['quantity'] ?? 1,
    );
  }
}
