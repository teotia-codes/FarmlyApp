

import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/ratingandcredit/model/rating_model.dart';

class FarmerProfileModel {
  final FarmerModel farmerModel;
  final TrueCredit trueCredit;
  const FarmerProfileModel(
      {required this.farmerModel, required this.trueCredit});
}

FarmerProfileModel exampleProfileModel = FarmerProfileModel(
    farmerModel: exampleFarmerModel, trueCredit: exampleTrueCredit);
