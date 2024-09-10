import 'package:app/farmer_direc/dashboard/view/farmer_dashboard.dart';
import 'package:app/farmer_direc/inventory/view/farmer_inventory_view.dart';
import 'package:app/farmer_direc/orders/view/order_view.dart';
import 'package:app/farmer_direc/profile/view/farmer_profile_view.dart';
import 'package:app/utils/appcolors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0; // Track the selected index
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  List<Widget> screenList = [
    FarmerDashboardView(),
    OrderView(farmerId: "farmerA123",),
    FarmerInventoryView(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.kBackground, // Background color for the Scaffold
      body: screenList[index],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: index, // Pass the current index
        items: <Widget>[
          Icon(Icons.dashboard_rounded, size: 30),
          Icon(Icons.shopping_bag_rounded, size: 30),
          Icon(Icons.inventory_2_rounded, size: 30),
          Icon(Icons.person_4_rounded, size: 30),
        ],
        backgroundColor:
            Colors.transparent, // Makes the navigation bar transparent
        color: Colors.amber.shade200, // Color for the navigation bar
        onTap: (i) {
          setState(() {
            index = i; // Update the selected page
          });
        },
      ),
    );
  }
}
