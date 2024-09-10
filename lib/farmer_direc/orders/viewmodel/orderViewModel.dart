import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/dashboard/model/revenue_model.dart';
import 'package:app/farmer_direc/orders/model/exampleOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  // Add an order to the Firestore
  Future<void> addOrder(String farmerId, OrderModel order) async {
    try {
      await FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerId)
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
  Future<void> fetchOrders(String farmerId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('farmers')
          .doc(farmerId)
          .collection('orders')
          .get();

      _orders = querySnapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc.data()))
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

OrderProvider exampleOrderViewModel = OrderProvider();
// Example FarmerModel with orders list
FarmerModel exampleFarmer = FarmerModel(
  name: 'John Doe',
  id: 'farmerA123',
  add: '123 Farm Lane',
  credit: exampleTrueCredit, // Use an actual TrueCredit instance
  // List of OrderModel instances
  revenueModel: RevenueModel.calculateRevenueAndProfit(exampleOrders), // Initialize with default values
);

