

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
}

List<double> exRatings = [4.2, 5.0, 3.2, 4.8, 3.5, 4.0, 3.9, 5.0, 5.0]; // Dummy ratings list
TrueCredit exampleTrueCredit = TrueCredit(ratings: exRatings, cibilScore: 700); // Dummy CIBIL score


FarmerModel exampleFarmerModel = FarmerModel(
    name: "Farmer",
    id: "01110",
    orders: exampleOrderModels,
    revenueModel: calculateRevenueAndProfit(exampleOrderModels), add: '', credit: exampleTrueCredit);
