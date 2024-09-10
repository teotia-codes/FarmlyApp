
import 'package:app/farmer_direc/crowdfunding/view/crowdfunding_view.dart';
import 'package:app/farmer_direc/dashboard/model/farmer_model.dart';
import 'package:app/farmer_direc/orders/view/order_view.dart';
import 'package:app/farmer_direc/ratingandcredit/model/rating_model.dart';
import 'package:app/farmer_direc/ratingandcredit/view/credit_and_rating_view.dart';
import 'package:app/onboarding.dart';
import 'package:app/utils/appcolors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: ListView(
        children: [
          // PROFILE IMAGE
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.OamzV3kluF4F8x90_GsMwwHaHb?w=768&h=771&rs=1&pid=ImgDetMain'),
              ),
            ),
          ),
          // NAME
          Center(
            child: Text(
              "Desi Kisan",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Center(
            child: Text("desi.kisan@gmail.com",
                style: Theme.of(context).textTheme.bodySmall),
          ),
          const SizedBox(height: 25),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            title: const Text("My Orders"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderView(farmerId: "farmerA123",),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.monetization_on,
              color: Colors.black,
            ),
            title: const Text("Apply for Crowdfunding"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CrowdfundingView(
                      farmerTrueCreditScore:
                          exampleTrueCredit.calculateTrueCreditScore())));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.scale_rounded,
              color: Colors.black,
            ),
            title: const Text("View your TrueCredit™️ score"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CreditAndRatingView()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => FoochiOnboardingView()),(route) => false, );

            },
          ),
        ],
      ),
    );
  }
}
