

import 'package:app/farmer_direc/dashboard/model/revenue_model.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';

class FarmerModel {
  String name;
  String id;
  List<OrderModel> orders;
  RevenueModel revenueModel;

  FarmerModel(
      {required this.name,
      required this.id,
      required this.orders,
      required this.revenueModel});
}

FarmerModel exampleFarmerModel = FarmerModel(
    name: "Farmer",
    id: "01110",
    orders: exampleOrderModels,
    revenueModel: RevenueModel.calculateRevenueAndProfit(exampleOrderModels));
