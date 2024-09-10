

import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/ratingandcredit/model/rating_model.dart';

class FarmerProfileModel {
  final FarmerModel farmerModel;
  final TrueCredit trueCredit;
  const FarmerProfileModel(
      {required this.farmerModel, required this.trueCredit});
}
List<double> exRatings = [4.2, 5.0, 3.2, 4.8, 3.5, 4.0, 3.9, 5.0, 5.0]; // Dummy ratings list
TrueCredit exampleTrueCredit = TrueCredit(ratings: exRatings, cibilScore: 700); // Dummy CIBIL score

FarmerProfileModel exampleProfileModel = FarmerProfileModel(
    farmerModel: exampleFarmerModel, trueCredit: exampleTrueCredit );
