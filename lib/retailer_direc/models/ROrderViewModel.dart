import 'package:app/retailer_direc/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ROrderProvider extends ChangeNotifier {
  List<ROrderModel> _orders = [];

  List<ROrderModel> get orders => _orders;

  // Add an order to Firestore
  Future<void> addOrder(String retailerId, ROrderModel order) async {
    try {
      await FirebaseFirestore.instance
          .collection('retailers')
          .doc(retailerId)
          .collection('orders')
          .doc(order.orderID)
          .set(order.toFirestore());
      _orders.add(order);
      notifyListeners();
    } catch (e) {
      print("Failed to add order: $e");
    }
  }

  // Fetch orders from Firestore
  Future<void> fetchOrders(String retailerId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('retailers')
          .doc(retailerId)
          .collection('orders')
          .get();

      _orders = querySnapshot.docs
          .map((doc) => ROrderModel.fromFirestore(doc.data()))
          .toList();
      notifyListeners();
    } catch (e) {
      print("Failed to fetch orders: $e");
    }
  }

  // Returns the number of completed orders
  int returnCompletedOrders() {
    return _orders.where((order) => order.status == OrderStatus.completed).length;
  }

  // Returns the number of in-transit orders
  int returnInTransitOrders() {
    return _orders.where((order) => order.status == OrderStatus.inTransit).length;
  }

  // Returns the number of canceled orders
  int returnCanceledOrders() {
    return _orders.where((order) => order.status == OrderStatus.canceled).length;
  }

  // Calculate total amount of completed orders
  double getTotalAmountOfCompletedOrders() {
    return _orders
        .where((order) => order.status == OrderStatus.completed)
        .fold(0.0, (total, order) => total + (order.itemPrice * order.itemCount));
  }
}
