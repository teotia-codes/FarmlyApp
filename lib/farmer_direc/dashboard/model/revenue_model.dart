import 'dart:math';

import 'package:app/farmer_direc/orders/model/order_model.dart';

class RevenueModel {
  double totalRevenue;
  double totalProfit;

  RevenueModel({required this.totalRevenue, required this.totalProfit});

  Map<String, dynamic> toFirestore() {
    return {
      'totalRevenue': totalRevenue,
      'totalProfit': totalProfit,
    };
  }

  factory RevenueModel.fromFirestore(Map<String, dynamic> data) {
    return RevenueModel(
      totalRevenue: data['totalRevenue'],
      totalProfit: data['totalProfit'],
    );
  }

  // Method to calculate total revenue and profit
  static RevenueModel calculateRevenueAndProfit(List<OrderModel> orders) {
    double totalRevenue = 0.0;
    double totalProfit = 0.0;

    for (var order in orders) {
      double orderRevenue = order.itemPrice * order.itemCount;
      totalRevenue += orderRevenue;
      // Random profit calculation (for demo purposes)
      totalProfit += orderRevenue * Random().nextDouble(); // Example profit calculation
    }

    return RevenueModel(
      totalRevenue: totalRevenue,
      totalProfit: totalProfit,
    );
  }
}
