import 'package:app/farmer_direc/crowdfunding/model/crowdfunding_model.dart';
import 'package:app/utils/appcolors.dart';
import 'package:app/utils/texttheme.dart';
import 'package:app/farmer_direc/orders/model/order_model.dart';
import 'package:flutter/material.dart';

class CrowdfundingView extends StatelessWidget {
  final double farmerTrueCreditScore;

  // Sample crowdfunding projects
  final List<CrowdfundingModel> crowdfundingProjects = [
    CrowdfundingModel(
      title: 'Organic Farming Initiative',
      description: 'Support organic farming practices in rural areas.',
      fundingGoal: 10000.00,
      amountRaised: 4500.00,
    ),
    CrowdfundingModel(
      title: 'Drip Irrigation System',
      description:
          'Help us install efficient irrigation systems for drought-prone areas.',
      fundingGoal: 15000.00,
      amountRaised: 12000.00,
    ),
    // Add more projects as needed
  ];

  CrowdfundingView({Key? key, required this.farmerTrueCreditScore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Only show crowdfunding projects if TrueCredit score is higher than 500
    if (farmerTrueCreditScore <= 500) {
      return Scaffold(
        backgroundColor: AppColors.kBackground,
        appBar: AppBar(
          title: Text(
            'Crowdfunding',
            style: TextPref.opensans.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: AppColors.kBackground,
          elevation: 1,
        ),
        body: Center(
          child: Text(
            'Crowdfunding is not available for your TrueCredit score.',
            style: TextPref.opensans.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.kBackground,
      appBar: AppBar(
        title: Text(
          'Crowdfunding Projects',
          style: TextPref.opensans.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.kBackground,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: crowdfundingProjects.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final project = crowdfundingProjects[index];

          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.PaleYellow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.kBackground, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: TextPref.opensans.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  project.description,
                  style: TextPref.opensans.copyWith(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Funding Goal: \₹${project.fundingGoal.toStringAsFixed(2)}',
                  style: TextPref.opensans.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Amount Raised: \₹${project.amountRaised.toStringAsFixed(2)}',
                  style: TextPref.opensans.copyWith(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement the action to support the project
                  },
                  child: Text('Support Project'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
