import 'dart:math';

import 'package:app/farmer_direc/orders/model/order_model.dart';


class RevenueModel {
  double totalRevenue;
  double totalProfit;

  RevenueModel({
    required this.totalRevenue,
    required this.totalProfit,
  });

  // Method to calculate total revenue and profit
  static RevenueModel calculateRevenueAndProfit(List<OrderModel> orders) {
    double totalRevenue = 0.0;
    double totalProfit = 0.0;

    for (var order in orders) {
      totalRevenue += order.orders.values.first.amount;
      // Random profit calculation (for demo purposes)
      totalProfit += order.orders.values.first.amount *
          Random().nextDouble(); // Example profit calculation
    }

    return RevenueModel(
      totalRevenue: totalRevenue,
      totalProfit: totalProfit,
    );
  }
}
