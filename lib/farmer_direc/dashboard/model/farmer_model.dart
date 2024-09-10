import 'package:app/farmer_direc/dashboard/model/revenue_model.dart';
import 'package:app/farmer_direc/orders/model/exampleOrders.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:app/farmer_direc/ratingandcredit/model/rating_model.dart';

// Farmer Model to Firestore
class FarmerModel {
  String name;
  String id;
  TrueCredit credit;
  String add;
  
  RevenueModel revenueModel;

  FarmerModel({
    required this.name,
    required this.id,
    required this.add,
    required this.credit,
    
    required this.revenueModel,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'id': id,
      'address': add,
      'credit': credit.toFirestore(),
      
      'revenue': revenueModel.toFirestore(),
    };
  }

  factory FarmerModel.fromFirestore(Map<String, dynamic> data) {
    return FarmerModel(
      name: data['name'],
      id: data['id'],
      add: data['address'],
      credit: TrueCredit.fromFirestore(data['credit']),

      revenueModel: RevenueModel.fromFirestore(data['revenue']),
    );
  }
}
FarmerModel exampleFarmers = FarmerModel(
    name: 'John Doe',
    id: 'farmer123',
    add: '123 Farm Road, Rural Area',
    credit: exampleTrueCredit,
    
    revenueModel: RevenueModel.calculateRevenueAndProfit(exampleOrders),
  );
List<double> exRatings = [4.2, 5.0, 3.2, 4.8, 3.5, 4.0, 3.9, 5.0, 5.0]; // Dummy ratings list
TrueCredit exampleTrueCredit = TrueCredit(ratings: exRatings, cibilScore: 700); // Dummy CIBIL score

