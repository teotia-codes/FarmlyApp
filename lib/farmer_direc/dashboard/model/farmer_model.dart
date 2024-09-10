

import 'package:app/farmer_direc/dashboard/model/revenue_model.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:app/farmer_direc/ratingandcredit/model/rating_model.dart';
// Farmer Model to Firestore
class FarmerModel {
  String name;
  String id;
  TrueCredit credit;
  String add;
  List<OrderModel> orders;
  RevenueModel revenueModel;

  FarmerModel({
    required this.name,
    required this.id,
    required this.add,
    required this.credit,
    required this.orders,
    required this.revenueModel,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'id': id,
      'address': add,
      'credit': credit.toFirestore(),
      'orders': orders.map((order) => order.toFirestore()).toList(),
      'revenue': revenueModel.toFirestore(),
    };
  }
  factory FarmerModel.fromFirestore(Map<String, dynamic> data) {
    return FarmerModel(
      name: data['name'],
      id: data['id'],
      add: data['address'],
      credit: TrueCredit.fromFirestore(data['credit']),
      orders: (data['orders'] as List).map((order) => OrderModel.fromFirestore(order as Map<String, dynamic>)).toList(),
      revenueModel: RevenueModel.fromFirestore(data['revenue']),
    );
  }
}
FarmerModel exampleFarmer = FarmerModel(
    name: 'John Doe',
    id: 'farmer123',
    add: '123 Farm Road, Rural Area',
    credit: exampleTrueCredit,
    orders: exampleOrderModels,
    revenueModel: calculateRevenueAndProfit(exampleOrderModels),
  );
List<double> exRatings = [4.2, 5.0, 3.2, 4.8, 3.5, 4.0, 3.9, 5.0, 5.0]; // Dummy ratings list
TrueCredit exampleTrueCredit = TrueCredit(ratings: exRatings, cibilScore: 700); // Dummy CIBIL score

