// lib/crowdfunding/model/crowdfunding_model.dart

class CrowdfundingModel {
  final String title;
  final String description;
  final double fundingGoal;
  final double amountRaised;

  CrowdfundingModel({
    required this.title,
    required this.description,
    required this.fundingGoal,
    required this.amountRaised,
  });
}
