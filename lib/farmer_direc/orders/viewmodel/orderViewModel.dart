import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  // Add an order to the Firestore
  Future<void> addOrder(OrderModel order) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders') // Top-level orders collection
          .doc(order.orderID)
          .set(order.toFirestore());
      _orders.add(order);
      notifyListeners();
    } catch (e) {
      print("Failed to add order: $e");
    }
  }

  // Fetch orders by farmer ID
  Future<List<OrderModel>> getOrdersByFarmer(String farmerID) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('farmerID', isEqualTo: farmerID)
        .get();

    return querySnapshot.docs.map((doc) {
      return OrderModel.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    print("Error retrieving orders by farmerID: $e");
    return [];
  }
}


  // Returns the number of completed orders
  int getCompletedOrdersCount() {
    return _orders.where((order) => order.status == OrderStatus.completed).length;
  }

  // Returns the number of in-transit orders
  int getInTransitOrdersCount() {
    return _orders.where((order) => order.status == OrderStatus.inTransit).length;
  }

  // Returns the number of canceled orders
  int getCanceledOrdersCount() {
    return _orders.where((order) => order.status == OrderStatus.canceled).length;
  }

  // Calculate total amount of completed orders
  double getTotalAmountOfCompletedOrders() {
    return _orders
        .where((order) => order.status == OrderStatus.completed)
        .fold(0.0, (total, order) => total + (order.itemPrice * order.itemCount));
  }
}
