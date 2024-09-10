import 'package:app/retailer_direc/retailer_cart/model/retailer_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String orderId;
  String retailerId;
  List<CartItem> items;
  double totalAmount;
  Timestamp orderDate;
  String status;

  Order({
    required this.orderId,
    required this.retailerId,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
  });

  // Convert Order to Firebase document
  Map<String, dynamic> toMap() {
    return {
      'retailerId': retailerId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'status': status,
    };
  }

  // Create Order from Firebase document
  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Order(
      orderId: doc.id,
      retailerId: data['retailerId'] ?? '',
      items: (data['items'] as List)
          .map((item) => CartItem.fromFirestore(item))
          .toList(),
      totalAmount: data['totalAmount'] ?? 0.0,
      orderDate: data['orderDate'] ?? Timestamp.now(),
      status: data['status'] ?? 'pending',
    );
  }
}
